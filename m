Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEB5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 12:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2387061409
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 12:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2387061409
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC6F96EB68;
	Tue,  5 Oct 2021 12:02:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01DAF6EB68
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 12:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gb874FFVfpiQ4ajRODUq0Mhnx7IlCeuN5bwHW7aUqV1z36FdJ56IBP3B+lGDb5Z0nyRqd/MVuNtWBrbHhV4yX6gDf0WxUMAAK9l2lmWdK734EGxtPdd2cWr6APMyQyP8rgN00CXkhUpzIgHku+RowTKUBdadh2rYH8zYSlHKUwT30r1mi8GTnXsHOSdgOpwmuKfsJdrvFFW0xXn1bgjUlN/e/AQCdn82xki4U6VftcFYDByOUsxpzjBZLiGBbcroZSAgsq4rGV6r5Jd7PuIkiq5UOwDQhBfsG85pdnRxBDPebqf2H2HwuR5+ourFcRiC9hy9At/ZuK21iOve9pve7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVhc/EwdvDPGYXwPQnxMyiQqbYu/lbwqPh63yUDUL6c=;
 b=JP6p+BcvaXROG/y5ashMVTqaSlJ+74YEAKokzIwyTAmnlDrKIseAMEcbcQfjHgVDRCDskmTglOa7kYPoJfrYqhU4voaj1KvfXXwXQLkX/759r8LyLe6rt6oxTtTeoxBBwm2VH/9zT8tnlGaFy8kAhS9yi521j9mTBux3VbUsoc8mlL9e483jgt/MUCxXPbUzySsPYrz7zDfLOfKu7THLeGPZpmF50friqhioSEq9Uxz4On7qxGA1vWRK0Mknlc/ryVUNMrYH9BckiewNN83/dLhu7VfkDK623CdOzpMt/nXAlcox/OFmwQCIgZlehsbLUcOlRVjB95Q+6+lNeb7ykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVhc/EwdvDPGYXwPQnxMyiQqbYu/lbwqPh63yUDUL6c=;
 b=lcE3U6aOxlNWtGkpJtzhK8GYFmYl0rOg9vDh0ELA3B4wDkPDXRXNf6mxIOPx2hnwXiRMx/YIvZ+GET3OFTSN1iPicu6Xjp0i/Ho3p4uBrHQo5SOgkJEkTE1YuHCrgXmbWfDaoiST+9pyOnTemwTauxhWx3eWCEeuy/zpprk1dBo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Tue, 5 Oct
 2021 12:02:29 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 12:02:28 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: init debugfs drm driver callback
To: amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, shashank.sharma@amd.com
References: <20211005115856.59649-1-nirmoy.das@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <0c89e073-7626-34b2-05b4-8e23b131337a@amd.com>
Date: Tue, 5 Oct 2021 14:02:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211005115856.59649-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR0202CA0071.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::48) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f22:7600:b5bd:631d:2ddc:3835]
 (2003:c5:8f22:7600:b5bd:631d:2ddc:3835) by
 AM6PR0202CA0071.eurprd02.prod.outlook.com (2603:10a6:20b:3a::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Tue, 5 Oct 2021 12:02:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ff19132-96c2-4c32-5a92-08d987f800e6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5152:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51523F8C2253C90AF4D9F8EA8BAF9@DM4PR12MB5152.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +q0xjSjFjuEtW5XNWw6KZE+EhUfQiQOT612JHMxbZUvxPwPsJz/d7VKQ/K9RegSu8xWEeitwpMBRJR8V/0WQhjzfmbYMfiWQ30tPFCe75xr4/0E+Hym3zzKtnqAAYTis89px2khbr4Wyjzi0dBZF1aoKfaatuk2AGN49Cqp/7GCUH0mvvdNaWPLTud5b3MiBFo58ZJ+GxkFXXQEtUiuerHi5zLKWBSaITinYhZWXPk7r+8It6MDUrCvs8YIsRJLdeEFojQtdLVbccvPStBzLeAE66Ha6OQd8nPqBDQvIhdxbob+jOTwuYYF9CLJznkYhFq6WtAOikBuxtGqETj2NbBPGPEAnex0eXnJzfhhALmGwiTw5EjFLpnBU/6cuxd5A4X0iFMP5jpJ8xSlGG+9BlEcVtBhnWGJE6og61X19i90HUZrwFTRYeGsA35ay34sUxncynASoHJ3ir5zhkhklErA/xQz5sjEUCLJCW83PtRMIk79hNSzyBrWHJXOKNSIoZQbwXBz+fnLXkH2djB4vL5PoN4ZxV6LssrWHOUgn7GZycN2f3fqzcIclRvxltmVucmzyRu1BXqkSzqdcoQyopt5orjxNwRM02WG3hmhDD8XHAKQrzvw9wzb5oSkIpbPBnEiRxd8w9sqR/Rlq+S1XkT/JNJq42fzfFbPp+UqQy8I7+nLbazgt9wadXjHgLP40Ib6JxDRWR0mXt11otsPG+5NpnS3+IuRe0WAlTqT24sU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(38100700002)(31696002)(66476007)(2906002)(6666004)(508600001)(36756003)(31686004)(52116002)(2616005)(8936002)(8676002)(316002)(186003)(53546011)(83380400001)(4326008)(5660300002)(6486002)(66946007)(86362001)(6916009)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUgwQjNyeEZ5MVRaak94Q0tKdVJOWk1uVGVONW4xNHlXSjI3VXYvaWZVell4?=
 =?utf-8?B?dTlISmR6algyVlpIVEJaM2FuNmo2NGdSTy9CMVVqTUhGZUlVOVRXckp5dmE0?=
 =?utf-8?B?YkVndHlXVnlMWm1UcHgxUW50MjJUby9VRU95citEU0cxcWZlNVN1a0hqYkd2?=
 =?utf-8?B?WFZZQzNLdjBERVR2T2pNRzUwcDNkYmE0cEpFOFcrMmNScm5hbjIwVmhLaTY2?=
 =?utf-8?B?TERoVzJKVTZBZHpjbGorQUlrazVNT0h0bDRUQjRjUDVBeXZqalkxek9LZHFV?=
 =?utf-8?B?SGw3cEwzcFQ2OXV4M01ZY0xFZmxSZHlpSGtFdUhDQ2JZTmpmeW5od3pEaVVZ?=
 =?utf-8?B?YUJpclVTKzI5WVh0OXF3VEpZc3VnU1RFOVBxdWVyalRPWU5wbmRQdjBhTTUv?=
 =?utf-8?B?cUJ6dnNjeHVHdnJQcXBiUGV6QndsNTFBM0lRS1Vwek1FMWFhWDcwRUZxWnBM?=
 =?utf-8?B?bVFMdWovb3MyWE9BREZPTTFYQm1XSm9KK1UxZEJhamt3eGlYTjF1S0lBazJo?=
 =?utf-8?B?d0ovbnFXUnFXRmg1K29HelAzZGVQVDZNUXVHQy85WHAwbWh2Wk94SHI1QW54?=
 =?utf-8?B?SEl1cWxhZk1SV3oyaFlOWnF4K25GV2NUZzdZSW82NlA4Z3hXV21qTDZDNnZu?=
 =?utf-8?B?SHAxM2xkRmdxMlpkOExFWnZ0Sk9GMzRtditFU3NZUCtnVU1pYjhLaDJwMXkv?=
 =?utf-8?B?NEVmc2N2RkJXdGNjdjZHUjFoMi8wMHNiclRZYVhraVdEM0MyaTRNVE0xdUZz?=
 =?utf-8?B?ZllHWXM1ZEs0ZWx1VTZmdjA4R3REWkxRbkhDNG1ROEtvSzdBMkxNMDRZbDdk?=
 =?utf-8?B?N0pCTldxN0Rqa3lGVUdpUWc2UDhRRDBwelpGR0M2dW9qdXdyNCs5OGFVNlQ2?=
 =?utf-8?B?NWN3R2R0TUlPbXZSSkcyQWZBRXM1WDJ6NHZXT2dwMUF5aGxPYXRiL2g0NXBt?=
 =?utf-8?B?b0NuZEdrVEpZTVFDQ0pJblczWlVhNnRFY3RFY3FhZUVNNnN4T2owMG9aTVgz?=
 =?utf-8?B?SUg0bURIMHJwRGRtbG1lMzY4RFpoZy9FQmo2bzNMV2tKNTFGY2dCbnFIUVNR?=
 =?utf-8?B?S0plRUVuNFJYc1VTcnpraGdtSWE3L0xza3NOYVhoRWt6T202MTlIV3U1a2JT?=
 =?utf-8?B?M1VucWxMd3dQYW14YnNQZ3c1akNPMGZnajByRzBRNkc0c3ZYOFA2VU9hRkYr?=
 =?utf-8?B?dCt5eVNyTDlGZUx6N0NKZW1MUElZUUdXWUZ5bjlwdVpMTjkvSHpEWjVrMnNH?=
 =?utf-8?B?enpZcmRsVkpGZXp2MkorS2dlcHczR1JZaWRCa1RRU2Rva1ZGRmFFdmtGWThF?=
 =?utf-8?B?cFUzYzBVYUZTRy95Q2t0WDNsdW94eEpRMXEwcElKdnlnT3pKZXpwY1dtdkdG?=
 =?utf-8?B?ZGtkTkF5ank2c2hreVczdUlVK0s3QldZWnJaRXZqVVZjM2hKcHlSd3FzcmQy?=
 =?utf-8?B?eCtHYVBrMlc3YTFadk5DbFhMRnljMlNXSlVtSEhKb1h3ZUM2TGdFc1VUV0Zh?=
 =?utf-8?B?eUV5OHhpVXBySDJ1N0dZbWxRMGlYeUlEUTdaUHRVb01uZFc3aDkvTkJ2M1U4?=
 =?utf-8?B?Z1hydmlFYVhHQTlQRzI1N1YrbU9OU2RjRytVa1dBSEQ5clBhN2ZmOE50dTFW?=
 =?utf-8?B?U1k2VXVibnZzT1J6QVdjQU5iVFJUdUpRS1ZmekgyRnlyRVd5SWdacTlzSEpa?=
 =?utf-8?B?bDZreEpSSGVydWVaNnFFTytoWEVyek8rNTJId2loL2J5QkowbEtJbW9tb1hh?=
 =?utf-8?B?a2FCYk1vOFZld3NHa2VTSHEyeDBPV0hRUEhJUExJVktzTHdSL3ZtZXhhUzdi?=
 =?utf-8?B?MndTaFpqTjFaWjR0L1YzYnZ5ZXgxSTNlYkMrcXFpL0t2SWZIQkFkSThaUXFw?=
 =?utf-8?Q?6UGFJCf/iIW4A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff19132-96c2-4c32-5a92-08d987f800e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 12:02:28.7625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJqV/2LSo5EQM0BGdQwz71YQMUibrLwC3zopMfJ1MksCtWAv5v5LFdLJ8HHAQ3brAb3A5hWQZxsCbshZrG1n5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5152
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/5/2021 1:58 PM, Nirmoy Das wrote:
> drm_dev_register() will try to init driver's debugfs using
> drm_driver.debugfs_init call back function. Use that callback
> also for amdgpu to intialize debugfs.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  7 +++----
>   3 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 6611b3c7c149..3076742f8f85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1611,8 +1611,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> -int amdgpu_debugfs_init(struct amdgpu_device *adev)
> +void amdgpu_debugfs_init(struct drm_minor *minor)
>   {
> +	struct amdgpu_device *adev = drm_to_adev(minor->dev);
>   	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>   	struct dentry *ent;
>   	int r, i;
> @@ -1621,14 +1622,14 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   				  &fops_ib_preempt);
>   	if (IS_ERR(ent)) {
>   		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
> -		return PTR_ERR(ent);
> +		return;
>   	}
>   
>   	ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
>   				  &fops_sclk_set);
>   	if (IS_ERR(ent)) {
>   		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
> -		return PTR_ERR(ent);
> +		return;
>   	}
>   
>   	/* Register debugfs entries for amdgpu_ttm */
> @@ -1682,11 +1683,10 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	debugfs_create_blob("amdgpu_discovery", 0444, root,
>   			    &adev->debugfs_discovery_blob);
>   
> -	return 0;
>   }
>   
>   #else
> -int amdgpu_debugfs_init(struct amdgpu_device *adev)
> +void amdgpu_debugfs_init(struct drm_minor *minor)
>   {
>   	return 0;


Ah, this should be just "return".

>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index 371a6f0deb29..06b68e16e35d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -27,7 +27,7 @@
>    */
>   
>   int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
> -int amdgpu_debugfs_init(struct amdgpu_device *adev);
> +void amdgpu_debugfs_init(struct drm_minor *minor);
>   void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>   void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index df83b1f438b6..ceda650895db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2012,10 +2012,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   			drm_fbdev_generic_setup(adev_to_drm(adev), 32);
>   	}
>   
> -	ret = amdgpu_debugfs_init(adev);
> -	if (ret)
> -		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
> -
>   	return 0;
>   
>   err_pci:
> @@ -2479,6 +2475,9 @@ static const struct drm_driver amdgpu_kms_driver = {
>   	.dumb_map_offset = amdgpu_mode_dumb_mmap,
>   	.fops = &amdgpu_driver_kms_fops,
>   	.release = &amdgpu_driver_release_kms,
> +#if defined(CONFIG_DEBUG_FS)
> +	.debugfs_init = amdgpu_debugfs_init,
> +#endif
>   
>   	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>   	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
