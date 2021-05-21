Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34513C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 07:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F284B613CB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 07:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F284B613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835996F5C0;
	Fri, 21 May 2021 07:13:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7D46F5C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 07:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/cffo+bFphsDnleHlchN5Y66OWzXKDVHUIJEj4f0pZLzEjc2VnW5bxYQae1Mje9pptJ+alNx8HKFcuP0rDC55yflZsDUeCmjaRxDmXQWe9lJ34BR0+qoI/xX04H0w+G6tcYYvxVtFNxXdgk0OHv4WTzAVhT7ViKLqfSCtqOBumZ9LIoG9oSQ1RBgHJg5deAW703T57e5mgURM1lyHdEb29w8ZUakd2G/0mckmUKBfyrkPbDAhDiCW3EEJj/SqHcffM3GaDKe/S6hH3bfZwGFr3+qvNw0G0s59DOdFrw/Z7CGVrdkOuJqv2ACdsPoDqfw3Td4O7aGDV+UbcQzwGjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EggF53gwxySdF1qoWh2dgGmm2AHI8RagAtEkUoxaRCM=;
 b=LFn7oGxxDmD3s8mNjGEPnmaGH9wTV3MZ90in2KxxpDXPYe/RWe8Fps5ghDnMscVC+YFAC13gr/LCf/KOBDtbyeAYRoZIJL6Ss1wXtLq1Mg1ueqxL0G/58ke3hjb9UOEIi56HyQrZU5hnuzpSfR2GZXhIgubR4uH6rt4bp2jeiIp6k+zCkkBAPBPaGoRVbUw9NTsnAEOjrA72/FFoAsz4D0AmP4SiYPuYvNWVSywnBnhFW26MCyiy9SRfH1Qco2c/9ctVDwSvr1YHAKNwzlv7eThcDehZGQNDacDFH9R2W4yXucmwetxtsOJrBf5KXG3hh1KCoQXlQdOTk4j7yv5gBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EggF53gwxySdF1qoWh2dgGmm2AHI8RagAtEkUoxaRCM=;
 b=qh6RUZwBFyEWHber9S2/8lWwl5EpGM+jIcdedustRfEwxDtlU99AQlH6bMVspl17QqQ806katpKKD6FykaUCv7yMenohoS/VAmHuG7sMKlNC4c86fUbyXiJ1+OzurTT4P/7UkZMIntBSgkkBotskODeWQY9WNJGacPW3ymPoSjE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 07:13:07 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 07:13:07 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu/apci: switch ATIF/ATCS probe order
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210520155614.309986-1-alexander.deucher@amd.com>
 <20210520155614.309986-2-alexander.deucher@amd.com>
From: Lijo Lazar <lijo.lazar@amd.com>
Message-ID: <0ab2237e-9769-f9ae-266a-48461efa6869@amd.com>
Date: Fri, 21 May 2021 12:42:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210520155614.309986-2-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: MAXPR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::32) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 MAXPR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.24 via Frontend Transport; Fri, 21 May 2021 07:13:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c1e5b61-5f9a-4dc9-0dfd-08d91c27e21b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5138:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5138BE1CA3151F8A4D75A6BE97299@CH0PR12MB5138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2x3NNHX+8wligNYwl2NZGh5Jj9ZQ222R0EzSp+JAAZTQ6qi9z4bBgJhtwqsTb3sQaH72+ZpsIQOwPBOQ064MV9F2lLy7ETJNbPqd/ofY84rPZATdnL++Y2EalGJeRvLmvwBfIhbRW5YEnOHEgBJCHfU9yxztpYKqgkCRUK3K/+OanHhO1io+bH/kLVkXCINvfqM4x2DSismTNgDlKBRBuU0FzbSR1axHBS37TKZPGxO3Rs2iv8/+5JlomQchL1+mHsv032xTNUUleDv5yhoboqElu+ZRKv0A/UDK61kP63J/IW/a61iybVs+SM94fQagY1/n2dBAM/Dk4fAjRUIzyeO1eb2p9lipIPtiSAvH7wU6UUuc67J9AQePLOr2oJ5G/t4Y6Yqd1GO1ei8D+wh8wGlLrYG+NIC+iiFMsYCnvR5rV5M72zyGe33XSeeUY+Nn8vQYjrlZgvBHrVlvF8lPXGLLBH/aYlhEC02mvGvxGfCyDrs39C7uWH+9s3qTgDvZ0o5IkAKQ2hhOps6ipHcCwIbgN8cf1l9lQK9TCBT6Qqn9gOWqMFNSk7+RLqOs76tGwBmGgRC0f02sXRE6WL+/jlR+RE75ASYNf475+EpB1DQqcYxf+oKsYycTkUGpdKW/BIE3VzgOqrMxmiak3TyCcO9PeTjro3Y1xBlbRL6BaPCE2GLFWdke8Wx5A2kp4LANmHdeUB/dV+225WnEni4pdKRd8XHndgCD3/wg4qvPIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(8936002)(16576012)(52116002)(66946007)(316002)(38350700002)(38100700002)(31686004)(36756003)(2906002)(8676002)(26005)(956004)(31696002)(6486002)(44832011)(16526019)(5660300002)(478600001)(83380400001)(66556008)(6666004)(66476007)(186003)(86362001)(53546011)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MW5lc3dsenAyYjFsakxiL1ZqTjRBcTIzUzRTcTVTNkZIZlMzM2xxd0ROWHFt?=
 =?utf-8?B?RjBJUm8wUTRpMmxKcFVSYld5b3ozdStKNmhSb3ljbjZyNjF4UFQxV0FjN3cr?=
 =?utf-8?B?K2pwNHZ6N2wrQmtJb1JKTUpONVRRR1kvYnVYQ082TjZWODQydlFtVHNkVmp5?=
 =?utf-8?B?TitOdndNVWgvSmt2ME1nNUJyMHp0MVdpT0ZtT01Da3ZFWGhYNlZLZzlrTEtY?=
 =?utf-8?B?Nk5ZWWpmTU9NcHFMUzJxY2VXczlzNTJodnVyeGlKVUZ2VGlRTHZybSs4UlVS?=
 =?utf-8?B?NXltcllvM01QbGhUcUVtM1dVMFVtNGtyb0FiWGNKQjIvVlBUWTJ4RitIQjN4?=
 =?utf-8?B?TndjUElCTnF3UnZYNkNtUnliUnpJSzN1RmVpQ29kMlRtSmNPWDRTWVZ0dTFQ?=
 =?utf-8?B?THlVbHhjZ3BXczhpblJBbzhPZ1ozcHgwM2JyRFNudjc2c2lhdEZYN1FvSGR2?=
 =?utf-8?B?enp5b3dJaVoyQXlhYXhRbWFVRithZW43VTR1VVRnSFhmZnBSVHIwVE1JY1Fo?=
 =?utf-8?B?YnZ2a1BEb0RNZFdiNWJvVWU3MHl5K1BIM0c5bWhFQVhqY2RiWWxFSGVocmI3?=
 =?utf-8?B?NHcwSis4Q0tNd1VHRFlKd3g3YmQxYmNQQ3VNcGVNMWlVZlVxZVYwdEJuaExH?=
 =?utf-8?B?WStaVE5helNsZW4vOGIwUFpJZlErOWIwREVvb29lZGN3clhQRWs1OFAzYlh0?=
 =?utf-8?B?MVpGakRCZUQveWRxUnZiT0UwUlJUR00yZmNRVFpjd0h4ZGNDMXBFUmQrNEt4?=
 =?utf-8?B?QVNLb2RseUh2SnhuTHdMdDluRWczb2Z2WEhFcVd3VUIySjRqalpsamk4bUpH?=
 =?utf-8?B?dGFoZEY1VEVuckNCUWxDQVZ2c1E4elAwRkxmYTZqNTJpcUNqbjArVmkvZEZT?=
 =?utf-8?B?bmdCM2FvTjBIc2JhRnV0TDZkQXF5NXArSlN0bmNhUVZwRXNaRXo3UG55VXpW?=
 =?utf-8?B?Qk45MGhPWU5wNjVhbXdxK0Q3OGkwRWk5dGxMckRsY01hbmpFWVhISnVrUCsw?=
 =?utf-8?B?UmxYbUhrdlNGcFNndUUzV2tyRXNTazBZMlo2aTI5eGpwZTlGSUFQNXI1enJn?=
 =?utf-8?B?cm1HREQ0NGlSZzRkVklCdFY4eHRXdjFDVG41UjUwL1AwTE13M01WWW45T3d6?=
 =?utf-8?B?Q29OcWh4b0pLSXdSdEV6WkF1ckFuS3NxV0dMQVRBY1l1V1VaalowSkYxSmVG?=
 =?utf-8?B?Ty9qTnFqOStWOGJ0UEFXMmVlSGN4QVF1dHY4eUpQRU5SbmYzRloxN3VWK2hp?=
 =?utf-8?B?M1MvMFI5TTdPSjM0cGliSXAzOXNFLzJOd2IzTHZCMHAxdXNJN0V2Sm05YW0r?=
 =?utf-8?B?aHNEMXNuZzd4bXk4YXQ3ckFHU1psdzlWdEVuV3ZPck03bHFxYXlBdTFJS05T?=
 =?utf-8?B?YllVY3NsVjJkK0poY1NsMDcwbW9FLytaTUY0ZFcvNTNUN29GUFE1RlVjNkc0?=
 =?utf-8?B?bDFWUDJHTUkzaW9abVhXQXJKaU04V2tLTThDS2ZEd2tkQW81SjFDQ2FkS2dR?=
 =?utf-8?B?Z0EwNENmblJDWHYyZWtFb2ZOeGZLbFR4aTVZdWZ1dDFMdVFYd00rcGpaaHdR?=
 =?utf-8?B?d1Zpb3ZldFRrNmJOWXFJMW9DVlJjMExtb3lVRG9XRmEwUFA1aUhQYUZJcEJq?=
 =?utf-8?B?S1ErYTdoQjM2cVdOd3ZqTm5QQnZsZEYwZkpxRGZ6YnY2eU5YVnpYK1A4Rms2?=
 =?utf-8?B?VVVaMmoxSk9sUGQvaEVoL3BPd3JBc2k3a1dGZUlOK0dTKzg0NFY0a0N2Vkhs?=
 =?utf-8?Q?zFivhHJlSfIkZu4NBlfK4cy0GhbVhZUK3KoSaxR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1e5b61-5f9a-4dc9-0dfd-08d91c27e21b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 07:13:07.5318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQPrCUfhTTu6r0UULiHg7Rz5OyC2IAwGhok7jxZNcYYixTWvnak5e3SPdFwmdREq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5138
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

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 5/20/2021 9:26 PM, Alex Deucher wrote:
> Try the handle from ATPX first since this is the most
> common case.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 29708b5685ad..49563ff87f1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -231,16 +231,15 @@ static acpi_handle amdgpu_atif_probe_handle(acpi_handle dhandle)
>   	/* For PX/HG systems, ATIF and ATPX are in the iGPU's namespace, on dGPU only
>   	 * systems, ATIF is in the dGPU's namespace.
>   	 */
> -	status = acpi_get_handle(dhandle, "ATIF", &handle);
> -	if (ACPI_SUCCESS(status))
> -		goto out;
> -
>   	if (amdgpu_has_atpx()) {
>   		status = acpi_get_handle(amdgpu_atpx_get_dhandle(), "ATIF",
>   					 &handle);
>   		if (ACPI_SUCCESS(status))
>   			goto out;
>   	}
> +	status = acpi_get_handle(dhandle, "ATIF", &handle);
> +	if (ACPI_SUCCESS(status))
> +		goto out;
>   
>   	DRM_DEBUG_DRIVER("No ATIF handle found\n");
>   	return NULL;
> @@ -260,16 +259,15 @@ static acpi_handle amdgpu_atcs_probe_handle(acpi_handle dhandle)
>   	/* For PX/HG systems, ATCS and ATPX are in the iGPU's namespace, on dGPU only
>   	 * systems, ATIF is in the dGPU's namespace.
>   	 */
> -	status = acpi_get_handle(dhandle, "ATCS", &handle);
> -	if (ACPI_SUCCESS(status))
> -		goto out;
> -
>   	if (amdgpu_has_atpx()) {
>   		status = acpi_get_handle(amdgpu_atpx_get_dhandle(), "ATCS",
>   					 &handle);
>   		if (ACPI_SUCCESS(status))
>   			goto out;
>   	}
> +	status = acpi_get_handle(dhandle, "ATCS", &handle);
> +	if (ACPI_SUCCESS(status))
> +		goto out;
>   
>   	DRM_DEBUG_DRIVER("No ATCS handle found\n");
>   	return NULL;
> 

-- 
Thanks,
Lijo
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
