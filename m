Return-Path: <SRS0=bpzG=HO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82357C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Feb 2021 16:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC9E64DE7
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Feb 2021 16:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC9E64DE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE896E1D5;
	Fri, 12 Feb 2021 16:59:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3960D6E1D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Feb 2021 16:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uhv1crOb09XGZ0nAHY8/5lOTqO7BvkfmYZB+Y63hMPAPMRrQFYchM4koQSMqFX0bw1dADBa7fr3Qp28EXELP7Lh/wkRJUaDZgCtHcsr/cmXq7xX6VMoJB2FcDPlkM9N3DZNuKOpznZHSIbZxdxT3uP077Ob2gRJLQHFzzve11/AP26or9MB2Er2aPLDsjMabR42MLeCKW/YtpOgbXi/HTD5q8GGXsO20T1dhYiDTxHR0yyeSQXcTxPWkzfOnBkJLTsYzP8Uql4nhYY9qBXpsdbEqKU8eEGQu6cIgP5bzxJvFqYGh7r+1W6UR/YHppeqlMK4Ab61vMOpZtrDDWXrHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/DLvjEhWG64oofonfCHZW35mT4UNyHL+B4yzKcjkeM=;
 b=C5BRYii/HmKjFEfha4ArSoWYgX5FkSrliE0rPguMWG08Kvw7FfxBO2zQI7tudNzvVzifHJI/MnNNGd7INlKsSxfxoivn6Hw72Z6T6tln98kByW8MwO8fnT2PjiFQAerCFp8oMH3WupT/Al9YxAlOqPi3fLk29NmDh47T8GpAE0VGtp537ZMPWcZrzfnbCYjI4dfSuo5sWjCwZ8m1lnpPoKUseTvzjeJ/8Vnz/0gHPBKzjyD8ZBBLrpF/PaOu21JMmgc8bDczqwOPfkiWx7gpjekXiAMmlfhozyMiDg6ajriGm/9cjybKHvuwPglMXLRQ2g6xEhklIbPTXpgacElqZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/DLvjEhWG64oofonfCHZW35mT4UNyHL+B4yzKcjkeM=;
 b=jvK2ChOk6nh0gXt3AV5A7p8xWky2H0uxT1u/eCxq8iYYZD6Jsc6ZTxrv7mftfQPNOHuVqIFPK/ylj1P2EP+kKQP8eWCc5E8ipKibCmCIdxEry56hJdTYJZu26pmegqLJXx5rVmwh6+ZRq62gVJL8FVjPx784aEwIDpL7pins70w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 12 Feb
 2021 16:59:54 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.027; Fri, 12 Feb 2021
 16:59:54 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu/display: remove hdcp_srm sysfs
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210210172134.121327-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <ad0e03da-0d50-e262-cd4a-531980dbbdfc@amd.com>
Date: Fri, 12 Feb 2021 17:59:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210210172134.121327-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.126.240]
X-ClientProxiedBy: AM9P193CA0020.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::25) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.126.240) by
 AM9P193CA0020.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.27 via Frontend Transport; Fri, 12 Feb 2021 16:59:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69186aa5-c73b-4d4e-590b-08d8cf779eb9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4419:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44196DF5EDCCBE488C8AD6D08B8B9@DM6PR12MB4419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4Wj120ICbbV77X6CtiFCjrajgJofSCoH4GnUYn/3vC06i7yX0i2RFgD4DnJZrM6bP4r5khkJsh5esqQAEVcRm4ekxCWxr2XZWpMP2aaodWaxZHSMIUz3o9jdWdtf6KUBM89Y9mT+kV7dUR1Sc5z2acYAef6wr4WDn9DEsJvXvMEsA9D6SUujyvVP/uwtDLCy2vmlaYYcw6GCnSrArOmwqNP2icMmcdMrlhJRvr1w1rhEU7AMHI+6A7rFBIEVzdYInTuyUDD5l+90KjvFc3aLri7njewqs70ZQ0Vw19iRom1dYINTVFwbyM+bUAomIagmsT6VQ9hfRLs7ICoVSejJccipsa/S8OIY/YJKM8QHKME5RP2teUHsDf+NKIMdgbBi4k5nO/f/EoWMYRMoqmG5R8mP8fO+lfWSN+OKU253NUqvoLA6TZwe3oNmtXRTRhgoVK5Ec7io2lLhN99ATRlvBb4LYtgkhAkLBI+fDkhGnHjIQwu+AQ4pqfMBy1MYBzaGVU57pCxngDxJK1Wm8kpAtVneBaUknXX/ZLGarR6htQEOIqE2Gz4LXHwW4rtGKpxgX85M3slGyziXcV/9ALam9FacyNSj8UPaIZRtaLne8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(31686004)(36756003)(8676002)(83380400001)(316002)(2906002)(6486002)(66556008)(956004)(31696002)(2616005)(478600001)(8936002)(66946007)(5660300002)(26005)(186003)(52116002)(53546011)(16526019)(16576012)(66476007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c2N4ZTVjRFY3WVpjaWhXRE9SMC95UlpNYlVQaGV4Sk4xNmVFVTZzVS9FOTJv?=
 =?utf-8?B?bVlTSkF2OHBDbEZURkJmWnBGZnNKS3plTUNUbUZKb2xLYkJmclZWM0NGM044?=
 =?utf-8?B?RHhFcFJkTzZtcEI0MTUyY2tFdXBRbERsSXR3cFJXV0hBVkI5dEVOTVJ2Rmg5?=
 =?utf-8?B?b1JaOTRzK0syS01ZaGY1L2J0OGIxZVIwMEoyTlBmb1doMTJTWUh6S2FITmNw?=
 =?utf-8?B?ZzhaVEZ5WUdzdDhwVGhPdEQxVktCV09peS90THNMVHNmVlpyMkw3YUNnWE8x?=
 =?utf-8?B?OHR4YU9MZTk3amhpaTBVd1F3WXhnS252cTVjQ0x3RjNyS0hFSEJzd201MndC?=
 =?utf-8?B?UXRYd3BUN3p2QWlNVndFbTI1VWJaS3VNSng4cjVIUWJsQ1l2SHpMdDh5ZVlP?=
 =?utf-8?B?VU1NeFhWaDZNU3MxUWR1czV4Yml4clRCdzdJSlZGdkZuK0EzUitrSXdtYnpu?=
 =?utf-8?B?dWlaVGRza04zVmVBYk9LN2RRNy9vQ0ZaS1M2N1hnbWd5VnNnRXZHajRYVnk5?=
 =?utf-8?B?bWFPK0wvRGl0a2J5ck42MGdQZUhLaVF2QXAwMkJiZ0ZSaG1COE1Xb1Y1VmFB?=
 =?utf-8?B?dExNemNOMkJicE0wcklhd0lnVXFyaUZaMjdFYW5NK0RMRVZaZnFBbFY5dGZF?=
 =?utf-8?B?b1kxcnF6aTJlOTVEZStYamcyaGJDOHd3a3haWFdVVzlVY0VwWUJlWlBydGNR?=
 =?utf-8?B?RzFSUDUxSnZ4dDkvMnc1TGFFQ3FOdS91bnhOeGtRN0hPbEwxMTM4RStQTll4?=
 =?utf-8?B?bGNSakZTNXVGS2hsMjY1MXFySTgyeE1PditDNHBqczNzZCtuSWkvWVF4ckFY?=
 =?utf-8?B?NEcyZjcwN1FVdmRzQXV2VUZ1NndwR1hodGJzdGxrZHJsRDRKUzBsR1ZHWTY2?=
 =?utf-8?B?ZVZxdWxpRERqdXMvYWVOYmRoODRkeGpXbE1qSFpPYXpRdHZZMXJjem56OTli?=
 =?utf-8?B?U2FuYVpFeEttYjVoYjY1Z1oybXdtekFOZUlETFRNSGIzVHMrTDU1NkJ4NUxq?=
 =?utf-8?B?WmUyQlU3SkRqMUJQT2xSSXFoYnlsaEpzZHI5MWpXOTU5aUtzOXJCMkpYRkpV?=
 =?utf-8?B?OEtDT2lTUU03c1Y2dmk5RHhEdTAwbmlGSmFjR3VZL1ovQmNiMDFKM1BhVkEw?=
 =?utf-8?B?bHV6eitBYzNIaTdNbVloc3J3cmU4VmIvdVV2QXhoMjhvVHNVOE9UdXZGTlJw?=
 =?utf-8?B?ZEtCbERkdUd4cjNUVDdlaVpjODN2VENpcEJmMjNiWTg1MEhwZHVWOXVWUDhi?=
 =?utf-8?B?YmFyeXVJY204UEZXejVGaDAxOFJ5cElHNlBoT0JPdUcxOFFnbmJweEdERWlJ?=
 =?utf-8?B?QXRQOWZWRk54Q09VM1RtUHJLaDkzdFVmbFhFbFpHcHB3QTlOTFFoSTg1VjVT?=
 =?utf-8?B?OXdlVW9OYXRxMENhYzg1c0RtWU5nbzZQYVpnMjdzVlllalpIZTNBNTRJTmV3?=
 =?utf-8?B?REFsdE9UTTdDN0xiUElRWlkwZ3g0SG41QUY2RnBiMlZsNmdtdWM1Z2pqcTE2?=
 =?utf-8?B?TGtWaFpJY1kwa283RVZEZ0pVQlVsTkJQOFhtNkJ5REE4Q0pLRmFuakdjMyt3?=
 =?utf-8?B?VFIrRW9wSkNXMWt1cy81cFJScVJHN1ZlNVd5NkNnSXY1Z1JJM2tWTVBUVHAy?=
 =?utf-8?B?dkxWQ1pwQXZrZlBVQ0x2N2tLWDRHYmVBOHBLSU1TVkp4SjBUU0ZpcWh2bmd4?=
 =?utf-8?B?bVArb0haVmdTekFPTm1VZ2tzckwzNlVnY21MM1htd2RSd3FDQ0taTUx0TzlD?=
 =?utf-8?Q?x2O5z12wxXCA1CvojpxS9LvwenFyLY+yFyBkJgk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69186aa5-c73b-4d4e-590b-08d8cf779eb9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 16:59:54.8217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOydOMjMpjFpukoqgwJKNcicSuyrbwuEJyyHkOq7Kw2yCo9YbbPAPNdRe6LJs81BUDOd4KixkjrEKsjv3zNWIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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

ping!

I should've added more info into the subject line :

s/remove hdcp_srm sysfs/remove hdcp_srm sysfs on device removal

Without this patch I get below error on second/later modprobes

[ 404.362298] sysfs: cannot create duplicate filename 
'/devices/pci0000:00/0000:00:01.1/0000:10:00.0/0000:11:00.0/0000:12:00.0/hdcp_srm'



Regards,

Nirmoy

On 2/10/21 6:21 PM, Nirmoy Das wrote:
> Fixes: 9037246bb2da5 ("drm/amd/display: Add sysfs interface for set/get srm")
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 2 +-
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 3 ++-
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h | 2 +-
>   3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 626a8cc92d65..083d75b747c2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1128,7 +1128,7 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
>   
>   #ifdef CONFIG_DRM_AMD_DC_HDCP
>   	if (adev->dm.hdcp_workqueue) {
> -		hdcp_destroy(adev->dm.hdcp_workqueue);
> +		hdcp_destroy(&adev->dev->kobj, adev->dm.hdcp_workqueue);
>   		adev->dm.hdcp_workqueue = NULL;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index b297ddc24d3a..0cdbfcd475ec 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -376,7 +376,7 @@ static void event_cpirq(struct work_struct *work)
>   }
>   
>   
> -void hdcp_destroy(struct hdcp_workqueue *hdcp_work)
> +void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
>   {
>   	int i = 0;
>   
> @@ -385,6 +385,7 @@ void hdcp_destroy(struct hdcp_workqueue *hdcp_work)
>   		cancel_delayed_work_sync(&hdcp_work[i].watchdog_timer_dwork);
>   	}
>   
> +	sysfs_remove_bin_file(kobj, &hdcp_work[0].attr);
>   	kfree(hdcp_work->srm);
>   	kfree(hdcp_work->srm_temp);
>   	kfree(hdcp_work);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> index 5159b3a5e5b0..09294ff122fe 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> @@ -69,7 +69,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
>   
>   void hdcp_reset_display(struct hdcp_workqueue *work, unsigned int link_index);
>   void hdcp_handle_cpirq(struct hdcp_workqueue *work, unsigned int link_index);
> -void hdcp_destroy(struct hdcp_workqueue *work);
> +void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *work);
>   
>   struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct cp_psp *cp_psp, struct dc *dc);
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
