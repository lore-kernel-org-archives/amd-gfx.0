Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C7606A32F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AOxIJCyI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723AF10E5A8;
	Wed, 18 Nov 2026 17:48:42 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF41210E5A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 17:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K22JMuczQwgskcauqfW1hUnrOIicM9Zb2kU1viO5rUtHolmAr8fQgH3AnBJHuPio4kSjTs7dGm8cbts6tpMmwfkCk7C6HvPvuMgjjHpg4vytpI+GYwby7a15SZVKbflt5Gk4Or1BFAx+SG4PtOl8E0eYakb3IKmr1zIOliia6O09NbGo07hdhxVOvkimSAn38L33pMUgo+ZFgYIfGWmqlro8IoGymHzVn4N0pw/EcLGXy47skcxIA09GaY/F1s3dkKeQwxD2/5y5JsSVD96bcMYDz2PAqcgJtPeJONt6MxutziDEK9m+QcICulC6F7BXkVPW/trulaCrE/63oPOFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gj94NHOzxFENGuddxA/lureJN8rhSmN+GWUc4PAKMEY=;
 b=p9LyvLAaYctadYLOcSH/FUt855nn9YzheRoEaWPlZ1e9RMkU7ZYjUyKhEENrVj7qfWAhtxjN2tUGQNTWLkw3LwRPMwirTb4/iAJGuiHePFb0YgUadwId36XBgClwbexdXoNx3JR/b0BG/jMr4w68AnOFJB3IIlaxF60+vQBzPqCYQlN8swr9UXO3895JVYgo9u9zA9QZUeq6tAPdQWvG4jjFj+A0lJ+y1AkbWRuz2CqAKCheW73QeyvzacQrDQsJ+HiGIB0CPPX19Eptv4Tz/9vKTURSbD7K7aVT40M6saJWRUWu6tzoDroPYWTxZ2GNkt5Rr+ex59+cxzSVZi006Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gj94NHOzxFENGuddxA/lureJN8rhSmN+GWUc4PAKMEY=;
 b=AOxIJCyIWoWiMYJk/ZfOqUqnUMYhP5mvzS9S2yzsk8nztewtvyMhcZqF4aT0fRRE2lTfh3s0N6pkMVwsUlOsAv9sfVwY45wlXhvaJAtonm+g29YZffaKdZnmvHrGpGgLfUxtljGsGs2RyD5YSlqK0EnwJxlFv3l2bDxyGqWIHqg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by MN7PR12MB288644.namprd12.prod.outlook.com (2603:10b6:208:636::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:48:33 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:48:33 +0000
Content-Type: multipart/alternative;
 boundary="------------0YaxL1h3RXy9aDAeMU8J3wrS"
Message-ID: <3adb82f7-7e82-4695-bbb3-4adc95787a11@amd.com>
Date: Wed, 18 Nov 2026 12:48:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: Swap order of svm_range_dma_unmap_dev and
 migrate_vma_finalize
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261118151045.134908-1-xiaogang.chen@amd.com>
 <20261118151045.134908-2-xiaogang.chen@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261118151045.134908-2-xiaogang.chen@amd.com>
X-ClientProxiedBy: YQ1P288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::9) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|MN7PR12MB288644:EE_
X-MS-Office365-Filtering-Correlation-Id: de202a7f-cac5-4994-c241-08df459c29c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|261009223027099003|22082099003|8096899003|11063799006|261026121527099003|261026140227099003|56012099006|4143699003|261021123027099003|261028144727099003|261022105027099003|261021121427099003|261022075727099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: Nuzu9wZ/mPVmKf1zvTeVNMZwjROeP9l6iXm/QfR1/dvKD99LN83tGrCY17TPiCG8L/bf8tsHamp//y0BmNYu4/Mao4UAGiZBP1VmuxdeaafxLQ6SNofFU2H9IIpzDlqsHvINrmFFu24ljSKi95ir3ml7DZBQBS5FNS3O/IXyUGymj9X+EJlpiCYEamE+oVhfLEMveSMWoYTlC58dGYpwcHPzCbT1HpCTUW5Lje4q3+aOxxUtD2SgfbUqdH78s8aH/Btan074Hi+PYit2EPI5NLrMpHjiD00YIRyLguGhPsgkStc2FskjlSo5Q5El7SWxR+ekTXrbOqToWaIb8mHg+l5t2XXqwipYsckAVt1RmMKEWeONe4ZYAnpZAXls7ZfZoKGgp6+H0u8LSTi+az+p2U3u/bohTeCJCQan4am1oytiG+GpyMN98Hm1q5ngbr273c8LgBwU0c29pSJ0SF5FC2rS4dCNdH4O6XQWPVmNK//HeGoEUy6x83MebOTPXlMjqqdkWe7ihUlVneXFJvbuFi+IOeIieaBS9wUzV1mCYMpOgbDWVv9kxPgc3gPhxOliPA8w+Lff2I7Var5ZWXCxddavtv6VzJnonKMhAh9Q38K3rrO9Xqo2oR7HkLhCOs45q7h2F2szjMqOhjvmbOsIruLXEUCBjUn+XO3FRYnQipo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(261009223027099003)(22082099003)(8096899003)(11063799006)(261026121527099003)(261026140227099003)(56012099006)(4143699003)(261021123027099003)(261028144727099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czNOSnZ5YkdyZjFGbDIvK0phL0NRd2ZXSmpsS0V1ZmU0dUVUbnFEdTlsUHpm?=
 =?utf-8?B?ZWllVDBkY3dreGpGN1RZdFl2aEJxVnhoTURKOGg2anNxZFFtV2h2dUk1QWhI?=
 =?utf-8?B?bzVaWEE5VEZJamxRSTZXSFpPTFVnOHFyZmx5bVVsYU5YU3NybFM3SVliL25W?=
 =?utf-8?B?UlQvQVljdmhCSXdreWNZN05iVkN6Y09GQzRyRnBPOW9aWXRPL2RKaGxyRTQr?=
 =?utf-8?B?MVFlN1F2MGxnbmZVcUFDY0p6ejhWN3dpTThCWWozMUJPM1Q0U081TkVLSkdh?=
 =?utf-8?B?Y2FMY3Qrc3RhWVIvQkR4ZXBwTVVUQVBmM0tyRkVWU2F4Ri9JUHZGM0h3OW1p?=
 =?utf-8?B?ak40cFVKMmhXQVVCN0dMOTRjUG92a1p2OHUrcGNGYWFzaGQzeGhBSk9IQkE4?=
 =?utf-8?B?dDJYeDYzSkxDZG1kMGFVU0RJZnppZm1GQVdsZURFRStrTFNHNnc2RUJTQk1F?=
 =?utf-8?B?b0lIbmFRWkFXVUNrMHUyL0J1U3E2d1VoZ0JabzU4SDByWVhmcUNxeWNWT293?=
 =?utf-8?B?UFpqZU4ycHl0SVJWZmNoN2V5cUxMZkRaTWRJOHJQMVRzY0pqRExVZjhUdWVx?=
 =?utf-8?B?ZDR6T2lEdVNtSkZteEJHaFNTN3VVb2c5bEdYbFpXcXE0Q3k3eUcxYmlSOFBB?=
 =?utf-8?B?bGc4dEh0MGhYaUhzSnltU2xxalVUN2RmWGtDNW5zZThja0NpazV4K09BbzJm?=
 =?utf-8?B?UnVkU3hJU3A5Q1RJbVVnWWtvQ2xjZFF5cWRuZWpUdjlIaWNFUi9oMTF3NnJm?=
 =?utf-8?B?cDBlOTdNOGdvN1RTcTZtZGZHeTBwUTcrOXl6elgvcVdMVWxMQ1I0UGtzS3Nx?=
 =?utf-8?B?ZFVRSHFLQVFWSGUxV3VLODlDSVJ2RDgzeVR1TVpkTU5yYmdjWkJVbG5lNjIx?=
 =?utf-8?B?NlJWMEtSdzA2Y1F0MFBrb0svQXdhYSs3RTdvSHMxZlpMajVnUEZoZXJYUFFj?=
 =?utf-8?B?V1kyUVpISFQ3SjM2V3RFV1JMNVBweHZueXhCODRXcFBvbmt3V3gyWVVDWlE2?=
 =?utf-8?B?K0tsWlcwRWZ3KzJia0E0WmphQ2FvaTBRWXcwQW9OTXR4MHRaVm42VG1QS2xV?=
 =?utf-8?B?aTU1MUNOVmgxSlBVeXNDYTVtelcrY0VsSTdGd0pRbEFBOXdmUVpiM3FMWVJl?=
 =?utf-8?B?Nlo0ZFZNUWRUSXErbWV5cHIveU9BUnVabS9MLzc5b1JNd1h1V3J4ZHR1VzdK?=
 =?utf-8?B?Tk10am1pYlVoOTNmUjNDWmhSMVFJanoyeUFzQ2ZkNXpnRGNTY01GR2luTVR4?=
 =?utf-8?B?d2Y2ZEF3aWtLVFlWZDdOcDI4UjZXMmgyVmh4b0IxY1VOZHMxamxhQVRXbWY5?=
 =?utf-8?B?TENYYWkzcDFhNTdIeldOV0pIdjJPUnNZWXQ2UUlJb0k5Vkp2dzdZUU13cFJ3?=
 =?utf-8?B?ejJZKzBHS3c0RE92VDU2elN6MHR5ZHZPUTFVWWtTak1lWkR3OUJYMkxqa0pv?=
 =?utf-8?B?VVJFRjZlS295dy9RYWdtRmZwRS8wTFJ4OG5pcVpJUjl4NVBnaHNkTElXNWJi?=
 =?utf-8?B?em1rZ0gycDJIcHBIelQxS29CU28xUWFETGVpOU5oQTJIbzRNTVN5ZU95Q2lI?=
 =?utf-8?B?dWlZdG4ydE1uRkJ0cndHWU1UQVdHVUMwZWxWV3BtbUxMSHZ2MGQ3d2E2eEs4?=
 =?utf-8?B?dUlHdTRRM2ZEclpNV09DWTVUTkJPK2JVSUVqRFQ5KzlLRHpxSnVrbFhldzhV?=
 =?utf-8?B?M24zTDd6ZmRuMTgyYmI0cEQ4SmxXcTZvRTNqeXBicm9tcVNNMWNvZGRubURW?=
 =?utf-8?B?dW5jMzVmUVFNWTNlb3pPczNZMzh4OU9SYzlkczNOazlHT1NqanNQYm9hTDNr?=
 =?utf-8?B?M0o3TVh4RWZ1OUFvdWxiZ25wTHhISG1GU0xVWmRQRzFMRk1NYmswWW5mNm56?=
 =?utf-8?B?SHBSTUYvKzBaaHFZSnpGUjFpMHBzSG1LSU9IZGN3QnZBSkVOMm9YNC9GQW15?=
 =?utf-8?B?c2pORTlZcHAwN1FRd2VuNzM0bVJORmtGaGdRM1FUVzBmVkcrRExuSStDbjhN?=
 =?utf-8?B?WXI4NkcxK1NXSWIvTGNFek85RTRhVmkyVGI5WkMyQmJseGZVaVE3bjR0YU1t?=
 =?utf-8?B?Y0FSZ3pLWHNlQmpXcE9lN3FFdG1lS09MZXF1WHlhbEM1SFEwbUxia2piTHBn?=
 =?utf-8?B?YWVRTkp2dXZSMzBXQ1dkZDc1QlljcG5RT3R6bDVoOW1xVkNRbXFESnBRVHNG?=
 =?utf-8?B?eU1KcmxSU2lrelZCMHlPc1BOaE9VRTJxZVZyTjlkTzdGZkFudmVDU3hRenV1?=
 =?utf-8?B?aUVZbFlMd3I3dVE3L05MNUlUcjZjS3dleWkvZjhTVEVPdVNoS2E0TExpVm9a?=
 =?utf-8?Q?0cnhYRfX3MNtTbeFQb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de202a7f-cac5-4994-c241-08df459c29c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:48:32.9825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNRRk7QChCMapf38zljyywH6gCrTQ0YMcMXhq+vUbCtRtO4YlcC1HVx9wR3h3yPA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR12MB288644
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------0YaxL1h3RXy9aDAeMU8J3wrS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-11-18 10:10, Xiaogang.Chen wrote:
> From: Xiaogang Chen<xiaogang.chen@amd.com>
>
> svm_migrate_vma_to_vram() on success: migrate_vma_finalize() releases the old
> system-RAM source pages. Only after that they are DMA-unmapped.
>
> svm_migrate_vma_to_ram() for slots that failed to migrate: finalize frees the
> newly allocated dpages, and the unmap comes afterwards.
>
> Every mapping uses DMA_BIDIRECTIONAL. With swiotlb, that kind of unmap copies
> the bounce buffer back into the original page, and by then the page may belong
> to someone else. With an IOMMU, the IOVA stays valid for a short window after
> the page is freed. During the window GPU may write into the pages that may
> belong to someone else.
>
> So, swap svm_range_dma_unmap_dev and migrate_vma_finalize at both migration
> direction to make dma unmap happen before sys ram pages got released.
>
> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 78a2aab81c17..4bcdedd91d2e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -494,14 +494,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	migrate_vma_pages(&migrate);
>   
>   	svm_migrate_copy_done(adev, mfence);
> +	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>   	migrate_vma_finalize(&migrate);
>   
>   	mpages = svm_migrate_successful_pages(&migrate);
>   	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
>   		 mpages, cpages, migrate.npages);
>   
> -	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
> -
>   out_free:
>   	kvfree(buf);
>   	kfd_smi_event_migration_end(node, p->lead_thread,
> @@ -838,9 +837,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   		 mpages, cpages, migrate.npages);
>   
>   	svm_migrate_copy_done(adev, mfence);
> -	migrate_vma_finalize(&migrate);
> -
>   	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
> +	migrate_vma_finalize(&migrate);
With the suggested change in patch 1, this will be

if (!r) {
svm_migrate_copy_done(adev, mfence); svm_range_dma_unmap_dev(adev->dev, 
scratch, 0, npages);
}

migrate_vma_finalize(&migrate);

Regards,
Philip
>   
>   out_free:
>   	kvfree(buf);

--------------0YaxL1h3RXy9aDAeMU8J3wrS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-18 10:10, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261118151045.134908-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

svm_migrate_vma_to_vram() on success: migrate_vma_finalize() releases the old
system-RAM source pages. Only after that they are DMA-unmapped.

svm_migrate_vma_to_ram() for slots that failed to migrate: finalize frees the
newly allocated dpages, and the unmap comes afterwards.

Every mapping uses DMA_BIDIRECTIONAL. With swiotlb, that kind of unmap copies
the bounce buffer back into the original page, and by then the page may belong
to someone else. With an IOMMU, the IOVA stays valid for a short window after
the page is freed. During the window GPU may write into the pages that may
belong to someone else.

So, swap svm_range_dma_unmap_dev and migrate_vma_finalize at both migration
direction to make dma unmap happen before sys ram pages got released.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 78a2aab81c17..4bcdedd91d2e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -494,14 +494,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	migrate_vma_pages(&amp;migrate);
 
 	svm_migrate_copy_done(adev, mfence);
+	svm_range_dma_unmap_dev(adev-&gt;dev, scratch, 0, npages);
 	migrate_vma_finalize(&amp;migrate);
 
 	mpages = svm_migrate_successful_pages(&amp;migrate);
 	pr_debug(&quot;migrated/collected/requested 0x%lx/0x%lx/0x%lx\n&quot;,
 		 mpages, cpages, migrate.npages);
 
-	svm_range_dma_unmap_dev(adev-&gt;dev, scratch, 0, npages);
-
 out_free:
 	kvfree(buf);
 	kfd_smi_event_migration_end(node, p-&gt;lead_thread,
@@ -838,9 +837,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 		 mpages, cpages, migrate.npages);
 
 	svm_migrate_copy_done(adev, mfence);
-	migrate_vma_finalize(&amp;migrate);
-
 	svm_range_dma_unmap_dev(adev-&gt;dev, scratch, 0, npages);
+	migrate_vma_finalize(&amp;migrate);</pre>
    </blockquote>
    With the suggested change in patch 1, this will be<br>
    <br>
    if (!r) {<br>
    &nbsp; &nbsp;<span style="white-space: pre-wrap">svm_migrate_copy_done(adev, mfence);
   </span><span style="white-space: pre-wrap">svm_range_dma_unmap_dev(adev-&gt;dev, scratch, 0, npages);</span><br>
    }<br>
    <br>
    <span style="white-space: pre-wrap">migrate_vma_finalize(&amp;migrate);</span><br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:20261118151045.134908-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
 
 out_free:
 	kvfree(buf);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------0YaxL1h3RXy9aDAeMU8J3wrS--
