Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F317C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 13:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF17E20786
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 13:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dhRDDsVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF17E20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704F289DDD;
	Tue, 18 Aug 2020 13:45:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55ACF89DBF
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 13:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9pvWwl70fOB3TTuWARHX1Xam+NjXr3voaHfSQM8q5i8+k7/ykglsoj9LPWa6SAv4E3qYX/QB8hO/Gi3TVwzna3EMm+TaHJPFbVqmgFJTuHTCGrrsvf4QtjKgJIxkyvbA783BUyzxxa7Sv39TQk59KM1AAwRH5V0oOtnlDEY8ZmK5gnzUvsmUEZUia45yBAYK5VFqFtVGNM+j5LN0IOx5LCLPzL/u6BcTZ8jNharjQ00d0+psKOI6dfubS4PxOdASeUEF4Uf7J/JpSHmmVrutZmGcxHUXSBYrGMDBcpqZ2999WYckKYD2xD2rtURKWvxZU5edvzUUllDjG3+LHUhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgbSMebUSRWXGtB0z5sih/qx6EjgMArz8HfPlFEq/tI=;
 b=ENux38i57PXQkR+T+LQTsb2H3bhL7NQuLi4ENjRfFHgOUTOgsyVbyyq2ISS1nYc3luo8NzR2/bI0JqY2RM/nNlDNgxWAGJnBnul4BoaBpHqO89G780255PobgDdGk0wflJbGpLSLt3TzLNaaNEf21oXhJwG+DJC4PhTELmfshmgXLfXy5lCjGiBzlQkkpHVNe5vi+HFpd4lh/4zYSZCNdAUOePJIqCJ5JpkTP39UT2XzYS21Jh2EJSaP777vBC5jAfR/WxkIwqWusv1uvoFj2r5UlDMXy5QKzhmwm80zwt93BJg5nDRCKF7kTYKLKTPJvPPc4j6iSZ2FQ8I0/Q6ihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgbSMebUSRWXGtB0z5sih/qx6EjgMArz8HfPlFEq/tI=;
 b=dhRDDsVT7ZaIJXDqiIN1sAcEr1fKJplqEyqsywrT0w6iWqwGncZnbnlW9KIGzzbLcZ5fy3bBysfNdAP/XojgE9/wWZgKGgI8Q7BHEvtX3lefgWubCRbBtMQ7783EOhmbKO4Nc+oDGJfpsG37fpTi+uoVwOty5UEz5Reiztjd7Ws=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4577.namprd12.prod.outlook.com (2603:10b6:5:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 13:44:56 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 13:44:56 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Limit the error info print rate
To: amd-gfx@lists.freedesktop.org
References: <20200818094144.378857-1-Emily.Deng@amd.com>
 <20200818094144.378857-2-Emily.Deng@amd.com>
 <BY5PR12MB41156F2FF9DBC5A5FE111F438F5C0@BY5PR12MB4115.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <ab1bfc95-0196-eb77-b16e-d20b949710c8@amd.com>
Date: Tue, 18 Aug 2020 15:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <BY5PR12MB41156F2FF9DBC5A5FE111F438F5C0@BY5PR12MB4115.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0021.eurprd07.prod.outlook.com
 (2603:10a6:200:42::31) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2b:8b00:ad4a:160b:54c5:6c69]
 (2003:c5:8f2b:8b00:ad4a:160b:54c5:6c69) by
 AM4PR0701CA0021.eurprd07.prod.outlook.com (2603:10a6:200:42::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.16 via Frontend
 Transport; Tue, 18 Aug 2020 13:44:55 +0000
X-Originating-IP: [2003:c5:8f2b:8b00:ad4a:160b:54c5:6c69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2b03238-3ff9-4d6e-84f7-08d8437ce462
X-MS-TrafficTypeDiagnostic: DM6PR12MB4577:
X-Microsoft-Antispam-PRVS: <DM6PR12MB45775F4C636BD5378D71DE2D8B5C0@DM6PR12MB4577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxJUiBHpZZuV0x45xYOGODGgXxEsVu21AIrQSsy/O2l6tcuCYfGiNOZ4332cydX6BeA8cm/rV/Vv9lVcjdl0p8cOqMsSFQ0nheWI1iewiDJ0UOy+MEs8sPxAlYhd0FzXW6sgw3CW5GwJymmkxbvv7AgfhY27+AzF5UqhTUUdyMffuAayhyg/dBgxi/4y76cfXEY7lmheCP2cVaujFmnvppei6phQNMjW1e4R+LT/FigMTzuxM/4b71n+RoJO8P+QUY0LWPve74NtvGETjpGzcIxAT67bfhRz2/szJJ5uBmV+kDkxqBZe1Tx+GJxsdniU7uT+N/GKaazep0MY7pzK5o4StgOvQCaGB1iwLQLor+AWz2rfNF/Kop+HBP/8cOFh/4wfVy/pP8atFyjBfEhhj+WrYtGdb5bC9nX93TwLU/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(31686004)(966005)(45080400002)(2616005)(66946007)(66476007)(316002)(66556008)(478600001)(6666004)(36756003)(83380400001)(6486002)(31696002)(53546011)(8936002)(52116002)(2906002)(6916009)(8676002)(16526019)(5660300002)(186003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: g0cqSQHb3gAPa6FosgOTFS95at2YToxQE8VRZfdX5x+8d/bhfkHMRTkWXsL1QbKpCY1cL2sJC07iy8T8fOOWPSiVrgFNDRCDu/8gvo45QsO7UpOSN/WoOlQOrKOp7/znL4nunjPJT4B3V8NNg7H44mg6XWevDyTAd/h6schvy2oSWDomtslYebgyAe6Uh30kOokRWaPZhhQ/ih3rfgIJ3x95bdkkj2LGrOJz8I9Ky0rAy/gs+LKjOTAyRe1piYDH+/xtpkm54k2qFGvOy0fK18FC8MNLfDZmb6WelUraCU0Ennw1/3zyz/8gRZ0fd/b/UN/vf3si1mTCtF3vDTREVJZ+LblaMTFRhIWVsW9E6QhJDlZ/MhbyeIpvK747d0c3jL6FPP0pqbbDhNW/h8eb+3ThVqr5qwbsgj1F/o/xNZejAj6aq34UiY6bAM56tZZyr6dE9bfsIHfd9OTWi1jNuavh7v+AswgY/q9M2DJXA8nb4Xf8sKGPHPcFjWLmbV+HALUdbOuVzjaAIvuQLsGSsznWQ3a4I4y0BjInsMwMQNoDrx92bXwPmEs+3sfJ7V4GPvv2G+1jVSV4miFZz77uABnspYgqtF5fVJtgWoz5eOAwqzwtWZD/EwYozdqwNMW5lP86zjsY18GmLUriMFV7igX909ftXQL0PJePfrmM1Zbjbu1hXxBQbP+ikFGv2LEaCYb21OZddpTCfhlhnlW/GQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b03238-3ff9-4d6e-84f7-08d8437ce462
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 13:44:56.1941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FY/qKWMEzzh9QsD6dTvstOIaWCkTOLGm9D5HdM+ks8k7SrUN6urXZ0d8rS441Z7oFGgQDgLwA1I0Kf8HpN/3ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4577
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 8/18/20 3:43 PM, Deng, Emily wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Ping ...
> What about this patch.
>
>> -----Original Message-----
>> From: Emily.Deng <Emily.Deng@amd.com>
>> Sent: Tuesday, August 18, 2020 5:42 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>
>> Subject: [PATCH 2/2] drm/amdgpu: Limit the error info print rate
>>
>> From: jqdeng <Emily.Deng@amd.com>
>>
>> Use function printk_ratelimit to limit the print rate.
>>
>> Signed-off-by: jqdeng <Emily.Deng@amd.com>
>> Change-Id: Ief05debe30d975cbcf88e473c9f486d70b5a202c
>> ---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index a94b3f862fc2..727b909b4b9e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -1296,7 +1296,8 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void
>> *data, struct drm_file *filp)
>>
>> r = amdgpu_cs_parser_init(&parser, data);
>> if (r) {
>> -DRM_ERROR("Failed to initialize parser %d!\n", r);
>> +if (printk_ratelimit())
>> +DRM_ERROR("Failed to initialize parser %d!\n", r);
>> goto out;
>> }
>>
>> --
>> 2.25.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cnirmoy.das%40amd.com%7C3dced10477a64f725ec908d8437cbcfe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637333550337050316&amp;sdata=acJSHuHMYH7THStjQ1QwjPvUbEnQGlwNL%2FaNDbLDT6M%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
