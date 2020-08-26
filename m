Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556A7C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 00:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00A920707
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 00:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="msRaomI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00A920707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 237DE6E9D2;
	Wed, 26 Aug 2020 00:40:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B6986E9D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 00:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4y8cIoJN4oY/Y/jlo2WAqNDLCo4c0+HPgi0RAqUO8BA1WP7H9IvKBL9A5Ke1UN9ZkwQIC4WrryZoapGfn6Jhll6/8k2nzNjesV1sOqNSpJYoOjue9vC5GYXsLY2eWf40cPt7ZoKiDAO1XwoKL+4b6PwOwyKXkpItaLS1x/J7/FqpaZmUzutRkFbj3N87pZZs7+Efus4FZ7dc0s+IXqv4FxKz+DVKXNXtMFAgnJywQTXlkVSywR+APh8iUw6TpB7gVm2hVvdzDvrtKz4eXagYU1lgBk3hLk9yOBCgO/KzyLQFYSRllj7ifTI4ejP+wrx5IfhzBN8ihvLjYKd49iDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QxZe8UjnY0XPIX1LPKQjZz1rz8ufSzaLL6BfrSWYHM=;
 b=WNevoAejXqaRjcszz/JJk1I/OuUVH5SgqyGt67WmLgeKtKdhr2viwD+cwOnm5fwpFj40gEUccGbKTVJVYShIUsbZpWfQ1/da4kDJXW0j4HccP6Sehocpo7eZ7ltvoFsUH5ll4LpVJJ6Fj7P/OPSfmJsBXv8S7AqkBTNXXpeCdi2llO8PzzyJrZgDhm/M5hrsdNUwdk3LDD5JjIIFwKMtXJIvVA7HtqcYxYtUdjoJ3Gv/CDzqTmIXKT3S/4YNP19whhMuE4M2ACQbPGzHSu3ixbTwpoqls9ZP4neACdiiyNADq7MovqreQZylTDb1h/qWaDHJTHIt2z7LZ6payouKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QxZe8UjnY0XPIX1LPKQjZz1rz8ufSzaLL6BfrSWYHM=;
 b=msRaomI7zBAiF+wDVT/ZiVcDQ3hcy5vKhxDbcO5c0LN4Xx99r7+5UcdQIEefLGwz419XicGDe0szYY/TivQ8PMfeL01NJV5XM5ICqHb9YhwS5upgFcX7RTxB3faUrTVGzUq1LwOLWnIQN451X1i1UwSrpMdP6pXfL803hjsLMTE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 00:40:11 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 00:40:11 +0000
Subject: Re: [PATCH] drm/amdgpu: report DC not supported if virtual display is
 enabled (v2)
To: Nirmoy <nirmodas@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200825141808.300152-1-alexander.deucher@amd.com>
 <01fe612b-be52-e0f2-3351-2a4969f214e0@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <44cea7a7-7ff0-6f2c-1b56-99d39233972b@amd.com>
Date: Tue, 25 Aug 2020 20:40:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
In-Reply-To: <01fe612b-be52-e0f2-3351-2a4969f214e0@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::41) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTOPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 00:40:10 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 985d5bfc-123c-4e8c-dbae-08d84958969b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4433:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4433D7934B372ABB7275BC3099540@DM6PR12MB4433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKofkn0/5+qKUsNMKTpnMI1JUtYy2OnF/hKybtuAFuFuF3ZIGUPObSRcrN3FxcuKbyo32VApqUbA/Ctm7xK1qEmh+vlA07vqSEBlNUsh9B6HdLn05Iqi/yniS2xnc0Yp0ROGU8sja758iel1KAnAE8dTIpbmxyJBXDg95vi/bimxd2uAj/u4PABLQ32hLPHpSUXaV1L7qQJcLdMn05MtzAaH6EImSypl8bSO4dy5iJauv37dVz8SGEyqH8Bw5jlfRaYmG6982MJQeOh+JWYrHjXAFkceFeMwL6DYeXJg4KI0bioQhv35TYyPs2EwlQdDLQgPez8iAdZXu6UxOV6i0vhS9niSe+8QMzpT1PgUG5A4OdkgeDTBjbIRdiw0UbwBS0x6/1dNhPxdO+YPPJKHISvutXTVbSSmyPctufRv854=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(8676002)(16576012)(66476007)(66556008)(186003)(31696002)(45080400002)(4326008)(66946007)(26005)(52116002)(86362001)(110136005)(316002)(44832011)(31686004)(5660300002)(8936002)(966005)(2906002)(36756003)(956004)(478600001)(2616005)(53546011)(83380400001)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qyjQg1fuy7QS/DgSN+OyBgqARRm7YtR2OtWe8nyKdbhJdEEBTlU0w6Y/FOSHUa48HlAnJOqUAPy+81pvqCW9pOzj7ADFXM9O5HeDp4xsYkcjMvnn/QhZVx51WROZFitsPl2yXSZFMvhJ+y49fX4QwzOv+HO8wbsnPzM1k0nj8NLyCTpVYstXJ26MUvoSk6gxdC9LySy4dMizv/O3gR0fXJwjrvnA1mY5XUhWNXAhWWo6obryV+Q99INEJEbbP1wlEVEJ7gjVdmTSqK5UPhKnfS9aP4n6UiSYLV94pmnnNhGjWkkUAh1uw/8aE70mnPQWJQdt598TeV91EpFXj7sYZbxMTJPyN3Z8Npc82FDxUEt0H/YjRyiW8cITAcX/kpFYDA2nj9qwAl6biHexiicJXx1l2FnupU8meI2Dz4j/Hz6zO2rmQQKyR8vblZvfq8B6/gHf3R3JNHM8dcywDcg1IujjHBbl4BMLMBa/osxPpWzL3M+ThvdgDqMhOzOQq8jy4Nt8PtK9v9yWrkEEN/z9U+hpxgZ3aTiRa3DTzjcXoXrah/EpNbuZ7L/VcA8Wkz1b6CiWkK4gqn12GO23zsbGCJWs/LSZGiHIUT9gmays7dBT00wdfVUYN4xKA8F104F6leqLFCjiuxmAF6gmbVQG8g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985d5bfc-123c-4e8c-dbae-08d84958969b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 00:40:11.0249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qF/qiJf3HMzuuo17VUWl87ePQ40d59C3mn67lmy5VyLPiVwxl8nMQGVp9U7FNwp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-08-25 10:34 a.m., Nirmoy wrote:
> 
> On 8/25/20 4:18 PM, Alex Deucher wrote:
>> virtual display is non-atomic so report false to avoid checking
> 
> With below nitpick fixed, Acked-by: Nirmoy Das <nirmoy.das@amd.com>

Another nitpick: "below" is not an adjective. It's a preposition or in
this case as an adverb:

	"With the nitpick below fixed,"...

Regards,
Luben

> 
> virtual --> Virtual
> 
> 
> Nirmoy
> 
> 
>> atomic state and other atomic things at runtime.
>>
>> v2: squash into the sr-iov check
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 5a948edcc93c..8f37f9f99105 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2861,7 +2861,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>>    */
>>   bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
>>   {
>> -	if (amdgpu_sriov_vf(adev))
>> +	if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
>>   		return false;
>>   
>>   	return amdgpu_device_asic_has_dc_support(adev->asic_type);
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7Ca80cd8a3f9b34b19d07708d849036b25%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637339626337747219&amp;sdata=6xwRnYCESQNachEMmT2jpVjKTsDg4RkwQKpMsOTsSkA%3D&amp;reserved=0
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
