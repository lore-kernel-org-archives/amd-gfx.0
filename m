Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6158CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 09:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E694573798;
	Fri,  3 Dec 2021 09:52:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3639E73741
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 09:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA71cSN61NEFmrsLucQAf2BW29GWXeoZC6eS5pMM+ghnPAV9idCArKSBBXo56ke+MoyqXyRKlod5DBBaJXN+t8ecHslSYWO9c1UcKe7S2p2xaI/ozC59pntzSNdHomYwDgt96RM2PZHVbDwFN3XscxbLLQIe9omQw5NKUGQesy850RvDuFMhTDxpm+vR9V9qbRj5KjIaZgVv8HO++5njxwHvbQWYE9snkvt1I1NXCSkvXJN4pZgJyHAKpZUdF49f4nspBJuhAvjFsuUlw0UmWtpz18mHTCuCu1aWlf+Z9ya13e6ynR6RGggbOAl8e5qagAQgFZMg7W6ChuombXaVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj0CD2GgjxFLEuVK96FCPzWp4l+y7Zbid0La6jhMWPc=;
 b=O1hjmVDFKXCfMdZSWk1P3uIOO5TjrFpaH9stNZStj0po8VoMYH3xrWmecnJx49n7YlB1cMbmTPXNDGtkbGVA04jEYBoAsBfjo4vUPKu+pJgywRsC4mq7qwW2PLRUVPLiUnD34nXLh+NYa4//ygBenkaZbIMJ46Au4QVubPJ8VSjRYwd1uHEslFHrzdQq+qS1cogTODb69sIBdpovSGfctu822O/9Ebr2TLdAkyXF1+951HFcrNrJwvYREUuw+xM8h6EPQ0nL6tXsOtX2l6uKNxCxlgXpOzX4q6a1MQpijT+UrwmrsQdLVcmFdZacknmLvkF0qrvXHrUVwlBpYAM7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj0CD2GgjxFLEuVK96FCPzWp4l+y7Zbid0La6jhMWPc=;
 b=ofPdJ4OlXc3oM4cUg5Y/NruRnhFxAzso9hk0Yo8mKFITNXALEPIn+HmhsVFY5dP0Ml7G0n7dBMNWTNCDBK7Bn/7GJVHRWZEx8wgTN/O7EInn3DgYKoEJ16Y8Baq05czEixcllxs4yK6jz29kQQ+qONwcNEIzQVYvof0Ks+lKauw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 3 Dec
 2021 09:52:37 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 09:52:36 +0000
Message-ID: <52f4d894-b122-a831-8182-70bcc2e1ce94@amd.com>
Date: Fri, 3 Dec 2021 15:22:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message when
 dpm is disabled
Content-Language: en-US
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211203065407.3714697-1-lang.yu@amd.com>
 <20211203065407.3714697-2-lang.yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211203065407.3714697-2-lang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::23) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0037.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend
 Transport; Fri, 3 Dec 2021 09:52:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7090b4fe-1013-4f8c-992a-08d9b642a2c0
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01061CD85A293ABC99F95E6F976A9@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEnIvgXV3IMvBjtec2rpSeaxMxYmm19Ro2bzcpesaH2iPME1ZTwJSDgKozXtaDwIYYvM+wrXv3btNG9Y+uLZIQApO6kdIdCGYL395d+0r3CflpKHbvsI8oCDkrFWUZOuc3HxQmwmil+t/iSNxjlQhjzzpEYNQyn0GBWiFBH/bQudiH+7/wV7AQyRyQCcQTtmZ65O8Zi2D2r0x668nh/1Hoj5f1w8bIOwsE8W1KSRS3SQNmCBoywGTMWofQJqFnmOk3523h1p9gDnoCRSVWrKzRcpCPomt7zhSZqqQIWqQ4Cen/joe0V8ecvkSubs5PX7vHUQ/FkrNCCjdLPvpL8YVid1VbaZFBhas0DxK/8WQ04UbFDM+xZDVE+whn7w1WJyl5R+5lyI0IiuyC3k/LiWgW5GOeHdiFv0ftftbL8nKTqBH7+hiY7k3D/g0/9Qi5wB3m+VoRNzhUxMTh9pTBcrUFUTEYF99NmwLBCmP0+E8HDvwMuugrK+Dz8uUbh6YnhA4UmnFhzGYeiuzXkQj8VdnrW5H84lpQT/fD62dokq8y85Klw2DuiZqt1JpmNe6jrgzJ1GFytTAIuB9S1SZi3hDCrdAppskP5FsIvP7o8IzzSA42alDK7VArovw1W4jA/5xGA+UIled4hrLzMLQYE3HfDhJxM/HegJHrbT3af8Jh4j2AsERyjiq4/VeAgHbRXlIoymZo48cdGmG7/6CyZaN4flwtEWOQSzyNE7ihiz9VKj+0Tdv5RaUUPMILQRbCNNPbmmz2JstHLXClxdmH1opA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(38100700002)(186003)(66556008)(66476007)(83380400001)(6666004)(6486002)(8676002)(53546011)(86362001)(36756003)(15650500001)(5660300002)(54906003)(956004)(2906002)(31686004)(31696002)(16576012)(316002)(4326008)(8936002)(2616005)(26005)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGxUVFpoaFVwdkgvWkhUbVdDVW5SZDNnTTBEMjFMTVBlcElxMDNrT2lNc1Rv?=
 =?utf-8?B?ditUQXR5QS81VHFpK2VyWVVFeEkxM0pydGdDcXR0ODB5YW5lMTlQTWllMk15?=
 =?utf-8?B?UVB1YlZZVy9EUVROdzJ1RTd0eXRFdVBDVGZCeGJnRDBVSWNQcjB4NWE1dHIw?=
 =?utf-8?B?aW9WcTBxTmdqYmZ6MUxpT1k3T1krYkloZERFZFNqTS9EOGxDSVNkc1lDd2hH?=
 =?utf-8?B?d2pNNmpvckRlOTdMOTkwTDBFRU8xYmlrUFIyUHhNV0dyUjdYQS83akt3aWNY?=
 =?utf-8?B?NERsQWZTeHI1QzViOCsrdkcwSXN3b3BabS9GQ0RKY2RWdjQwY1lqVEJUUlN1?=
 =?utf-8?B?ajdSeTA2ZzFIWWhzZVdIT0ZVNWJFSGZ4eDlRazFPNFR6SmhRWVB5WHZ3SWVs?=
 =?utf-8?B?ZUh4VVdBYm5vbmNWVlVnQ2lvWkZ4dFVlTnJHOWRvblVDbDhSa0hISG1nTHZK?=
 =?utf-8?B?UGR5SzdOYTJEMWxBalFBUitUSXJtRDFXNm9EMmpzUW9LOCtHeVhPc3E2OHM5?=
 =?utf-8?B?N3ppcFFuZyt2MVBiMUNhcG9leEQzbXphN1R0WEl6VVN0OFZZNmtRQTA4Ujlt?=
 =?utf-8?B?dXVBMldYVGEwU3hqMW1GQmpEOXREL2ZPbGF3R0IrQ2dXU0NCSm9wT09Dc3c1?=
 =?utf-8?B?R3RYZG9UYVprYnVMZlhFb1psbUZvOFBqdnFLZkJZZGRNV1RwUGNUTHh1RVM1?=
 =?utf-8?B?Sy8wOVc3cUtjakxzRVFYUmphSHVOWUxNajhaS3EycU4zd0RHSnMrbkFNaEtG?=
 =?utf-8?B?VExLOW03NXBuUUZOMXJrZTZDb1ZaU296dXlERU5BZk9VK1BFVnowWHN0NGNy?=
 =?utf-8?B?eVpFOUY1ZG9KelZWMURuZDBGVzRHMGpsdjBnQ0lyTnhWZ2dxU0lBWFRUaHpY?=
 =?utf-8?B?Nm5KMW9kQ2gxWStuSVBpMDJja04zMFZGTVBzOXdnclh6Y2MzM3JTUnVUZ1pm?=
 =?utf-8?B?dW5QMmMvclRWdXlYZlF4MElDb3ZoY1doVDVmL3BVTVVsalQyMUsyYXhMZkFM?=
 =?utf-8?B?YVVoL0JtclRkVXNTTGVoZ3JnenN4RGE5MXVVRG84WlFXOTFDYTRDckJRZVJH?=
 =?utf-8?B?ai9kYjdxUTltYWYrOEl4Y3Z3cXVkMEo0aWtJeFJYbjRLSTV0bXIvbnovaE5l?=
 =?utf-8?B?M1E4cGhuWFJFb2NRa1JJaGVqL0gyN0VNcndxWGwwNUtYc2FMSUI4ZDE4OTVj?=
 =?utf-8?B?ZnV5TjRtNUhlclRJWFlUN3BrUERQaWFTWEdFdGxVT2dWU2ZadGhBS0FQM0dH?=
 =?utf-8?B?Z3UzUUc0NFBYUmN1NThSRWFzYkdZM0huMFQrUXZsNWw2MllVSXB1ZnhITjBE?=
 =?utf-8?B?dFBwU1lNOVI2K3RzWGNxbHYxcmpxNzR2cjV1WTVWdXhIdTh6aVh5UU1iM0NS?=
 =?utf-8?B?TTlFQ1llYzgyYTZ1ci9LS2QwaXlpenZKMUlIZE0wUHVMTnQrcldaTkxYYUk3?=
 =?utf-8?B?YmtjZFhzQWxzQXczcXNUZFpEdjNaa1ZQMXdBRDhlT0E2NEtMRzhpRjhlZzZH?=
 =?utf-8?B?WG9FZ1hYZ2NYNVh2ZGh5OERXbUdLbktKMVg3WUU0Sm5PVUd4Y0lQbFBrNEh0?=
 =?utf-8?B?RmxSa0dyQ1ZGWlZKZy9hN1llRmdUQkhIazV4cUh2NFMvRkIrMWIxRGdjaXlO?=
 =?utf-8?B?L0lUSXhMbWt6enJPNzNRTXZRMzlLTVJPaHpaQzZUemJHa2l6blZHQzlva1Yr?=
 =?utf-8?B?MGVybVJVSEJQWllaNUFwZmdnYWJ1UmpnbmpKQlZ2WUhsOEl2czk4bjN6UHdP?=
 =?utf-8?B?aFdKWGIwWWRWRUNYQm1FTktjcm1Wa0hSdXRjcDd6NDBSelA1SUpOYWRzb3lR?=
 =?utf-8?B?N0lMckZCODJhR2g2SGpHcU1JcE43akFBL0NMeFJ6WnZSTklObzFhSXpFSVVt?=
 =?utf-8?B?MEVCTjNCRmR3UFRjMFNRWS9JaFFIazVSS1E2RVJ5NjhWTTdSMDlGaERTUHor?=
 =?utf-8?B?bmdZWThyei9mQjJCZFpwNkJwdmJRY3d2NGluYTkvNWVkTUNPMW1CcHl3QmlK?=
 =?utf-8?B?cEdRVGNjRHdNSnRWUHg5d1ZWTS85MUVHOU5uUTRyZytlSE9uUXU0UzNNdFgx?=
 =?utf-8?B?N3JjZCt3eDNrRnJYM1pIYWJMY1ByeE94cktaeENuMVc3ak5RaEN2aDU4NVJR?=
 =?utf-8?Q?XDDE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7090b4fe-1013-4f8c-992a-08d9b642a2c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 09:52:36.7741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6qs8Jps2l0/GNvjum4Tl3qQj9kpTnz4KSi9FnQLb5WjFbxecDzOkCoopo4x+nUw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/3/2021 12:24 PM, Lang Yu wrote:
> The general hw fini sequence is SMU-> ... ->SDMA-> ...
> We need to send power gate message to power off SDMA(in SDMA hw_fini())
> afer dpm is disabled(in SMU hw_fini()). Allow that for APU.

This message is not right. In APUs there is no message provided by FW to 
enable/disable DPM, it is done in BIOS. Rephrase to something like after 
smu hw_fini is completed.

> 
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 2d718c30c8eb..285a237f3605 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -277,7 +277,7 @@ static int smu_dpm_set_power_gate(void *handle,
>   	struct smu_context *smu = handle;
>   	int ret = 0;
>   
> -	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
> +	if (!smu->pm_enabled || (!smu->is_apu && !smu->adev->pm.dpm_enabled)) {


This check was there before also, only the WARN is added. That means it 
was skipping sending messages in APUs also and so far this was working 
fine (until this gets noticed because of the warning).

Now this would try to send the message to APU without any check. That 
doesn't look good. Ideal way should be to fix the sequence. Otherwise, 
suggest to do something like below as the last step of smu hw cleanup 
rather than sending the message blindly.

	if (smu->is_apu)
		smu->pm.dpm_enabled = smu_is_dpm_running(smu);

Thanks,
Lijo

>   		dev_WARN(smu->adev->dev,
>   			 "SMU uninitialized but power %s requested for %u!\n",
>   			 gate ? "gate" : "ungate", block_type);
> 
