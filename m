Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA6EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 17:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D19496E156;
	Wed,  8 Dec 2021 17:28:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81626E156
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 17:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY4nW+Ped8G5jZ4gaSxOU8ijgBTAdhmPnepvYdln6iBZrvYxDEasDxz3Ian/zCpGOTY3ODxlOC6ZqhmwFQxi4KNns8oySEKNm/GMmyzaTrnTOtjhq+/zEU6p381+hrgT4AzQjvQVvHWr7yIOutt7mudYejjD+4hEwAXkXszcdPNwQPq7m183zi+yi03zFTKDRxVMBrsHN7HKxqy2n5dQ4Ax/iLlCcPOf8kYf2Y0RzHHbHCTU5LwXNrqtYRY2NA08zgh5vs/GFtXienVBtOk8jsd0HGZpPtLvrUok6h1vpxVhEuXgLEJ2S8WCRRIAxCRdpCVkfAgdSFU6+KcVh/MPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovrsFJoZ1RhD3KOTTuK/5CW3vAXsZyKbuavKyyZemy0=;
 b=Ny5NrlWvLxD0JeBW0CrgFGexDy3nQLNBh2hw1KJGGU8w4xSOP1DGMYzCK/dVsOyhEoSBH6wTynxogegMi59l+ws5j4+zNZyh+SgiOfjh/f9j+C8I2ai1f7/tQVi5/fmKsaIRMt+HUphqV12qWGdCYIrMUT1DBRr4VN8ca5zStsp92VhtE6eLJuhKpSwoqXmSUtesh/JycCyzSBNOViMy33ZCt0WuDRHVF2v5KurZYKHWRu025Kt6zXzvdvHuzXEuKeF5HgeS9NRxlu1189NuS3f1mlVaZoMPpY/G+u2QLQ4qQ7sfB4Y2MPNJNzsg+/WbiJW4TleHUESTpAJEQMKskw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovrsFJoZ1RhD3KOTTuK/5CW3vAXsZyKbuavKyyZemy0=;
 b=De3XfuAARvcHdzHQ3YzCi9RzNYwtNl9MkbAr981KzUHKG43FS+8Xs5ynnFu/j6LTFPjqAvXbg0vfwUlpf1RmHSbEpnlHTF3buq3cy4Mr7W9CNyUB6MciheFDRNu+GE/KzTAxSiVQERjowuI4T585MkTfPbRb38OkY33UJ8YQThQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17)
 by CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Wed, 8 Dec
 2021 17:28:43 +0000
Received: from CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::d3e:78b2:716a:3302]) by CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::d3e:78b2:716a:3302%6]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 17:28:43 +0000
Subject: Re: [PATCH 1/3] drm/amdkfd: Fix error handling in svm_range_add
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211208082457.918004-1-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <65830ead-6dbb-3c4c-44a9-f8ab435c9b3d@amd.com>
Date: Wed, 8 Dec 2021 12:28:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211208082457.918004-1-Felix.Kuehling@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::6) To CH0PR12MB5138.namprd12.prod.outlook.com
 (2603:10b6:610:bd::17)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BL1P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21 via Frontend Transport; Wed, 8 Dec 2021 17:28:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49162932-8a99-4718-400b-08d9ba702ed4
X-MS-TrafficTypeDiagnostic: CH0PR12MB5330:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB533077554D5751164933D5A6E66F9@CH0PR12MB5330.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QevibIATRBSSA4hXLwb1G2NVxAdysCmNSk4iPIUDMKFz6XNSGAd753qnrCKOv+xPoFxoLnDwPQLAKGPKipeGIAZr4uV2Mhl807jIxxRofNW3Eyl3GNMoi7LBil8pTcBEAfRbVs8Aoi/P259gY+3U4QKyNWbgYE2pRaNqUhKtQIBjmh+bxrECYxDuhlzknzfptbKrcaQPyuSqRb76y2KzqZ1fXTgj281od43JG0NWeRBCYInEipgBSvcPg3CuuZgpUdwcMzpqIRvscrcA4/VOVuHkxwHWOaBLTs0ouzdGc7GAq0zhQKQ/VM+MycVcwCkgxMP2EsyxDMGHruZUe5ITwzivqhVr6SlcOU7LH1Q/OLvxjSNKfv9wFKgovha0cHNED8MNLRkgjh1n2BzOI397ATFOWrHaZ8yEC3LPC1zjHcpfK2RQMczTxxFDdSYf/Xi9aoa70P2kGVvh/TG9UNuMmxu2yWNADEeD3vHq3jWw7GQaR7Ao+aEgPrkXtRsh8dpyWcp6jnPNUfWB+LVwu+bIVIqHpuwxm01dYfrq9JkuYBk6sS2yFXbNlwqRZGQsQnRkp4vJlkT6lh5EaiFSMWTnTeOhApTXMW9BqJt0/8bd40NOZsGS5/Y3OMuwrshRZxCMegvYj0cUrXIFhU0XBc7mOzG13BIj4Z03YDWkC0sYJwJxoNnzjk/evtNSL+FnV6dJT6QHoSpZHfnmMkwqI0hO36PHfsu5LYhaohsAnEREf9Vhw33vpFs4H8pszQ4z4+gX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(508600001)(8936002)(16576012)(66946007)(66476007)(66556008)(2906002)(5660300002)(4326008)(31686004)(83380400001)(8676002)(26005)(36756003)(6486002)(31696002)(186003)(956004)(2616005)(38100700002)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdkUkJZemdpbDZraUZJSERHZE5hM1VGZTA1dmtkcWdqMW1zNWlyZDl5YkV5?=
 =?utf-8?B?UGlyV25YRXhRMFM2OFJwRERvdjdQSVFET0lQQnM5eHE2Y1duMS9Jd0krQjFh?=
 =?utf-8?B?OENUYUdnM1pBSXh4SzJvV3lnaW4vOXFjL0tmMTZEcjNOY0ltdURnYVcrYUZJ?=
 =?utf-8?B?ajBuMG51MG5BdTVkYVozTTlhc0JMeDBBRTRkOHJUa2dQQVNncUtKQjczZ3VK?=
 =?utf-8?B?MFpIaGV0M2RLbERJeUF4VmMzRzBIS1g1SGlyejhmL1FlMDRBUGYyZVkwMWZ6?=
 =?utf-8?B?MHlUM2VETktpbjZESk5HYVVtSEM4SUtUZ2ZDaVNHcUxqZVRWVk9acFFLSnhP?=
 =?utf-8?B?MGY5eFJJY0pwWUp2enNWWXBlQndBS0VBUVNLdHJFZ0RFVWtUNGxaOEFLcDZJ?=
 =?utf-8?B?ck5ZNk1sTDVJUlNVOWFiSDFYVjF0REpxd3J1eTRoM0JSRDFvVmF6L2R4UTN1?=
 =?utf-8?B?MkRLMFIvWjhONlZWdW5KakIraEJoc3BsRVFTSXFPT2NHUkswbzRITlpOck9l?=
 =?utf-8?B?bUhPSWVXbnYyZ3ZUbW05Mm9GeHN0MEhvSnhGOEo5Z3lPWU5KY2lnaE5PR3Nk?=
 =?utf-8?B?OE1VZGF0T3hNWGFsLzNCSEsxbktzMDNVVkxwandIMVZ4eDRLS2NWNDQvMGho?=
 =?utf-8?B?Nzg2RW94N2l2RHFXRlk3bzd2RE9YWkFMSXFZTHo2R0VoK2FEaUlEU3o1Umhy?=
 =?utf-8?B?WXRRbGtsQ0VBSTBvdzFVbkZOR2FOOUFWakNNZVVFNmtUZm5iU052cXdXd2sr?=
 =?utf-8?B?NHE3SEtRNVV2VlZMai95RExnOUpHRUlwWTJNLzk2K01WVnZUVmlsNFJUK3ky?=
 =?utf-8?B?U2cvR2NhbHJLcld6bDdyaHdaVE9iYjdyMTJmbExQc1hGZEcrUjdqNXpHR3hW?=
 =?utf-8?B?WG10czQ2NzNZUGJxUnJpbEFRKzYvbHllTzJmMnJUaHlybHFJanBjdjRhMkdq?=
 =?utf-8?B?d2l5L1VnMmx6ckhVOFBMbW9uRStiMFpNWXQ1elVzRG5Fa2ZWUWRNTlZibGNo?=
 =?utf-8?B?enFYcDVlVWlDUXFTS2lEaVlveGdTdHVjbmxRd3hVblRlWEZNS1VudEVTQlBL?=
 =?utf-8?B?by9yMVNIYVRHb09QbGJQc2poOEpjSC9qVVdMckRlUkRnc1l0RkRwSjN0cjVy?=
 =?utf-8?B?ZEhiTVQ2TTVJTjQ5WHpWNUlweTNlVkc2d29GVVZvc2JYQU9zTFd3aCtxME9D?=
 =?utf-8?B?T3lZUkJObythU0hlVFBTcHdrUG0wSGxRdEY4V25MZStXdU9qcXV5OWFENTk3?=
 =?utf-8?B?N2lkN1Btc0FSTTA1UVczOVR2WHFhcmFkTVVPem9ydlUxSkk4TWFNMnBJTHd4?=
 =?utf-8?B?UmxidEJhWTcyMkFXVzUzTVU1Qkcvb1llZkFWSmE2dXJBMGQzMStCbHd6Qmk1?=
 =?utf-8?B?SUNhcHZyL3k5V3JSblZQUDRsSHlVRXloTW9SWnFlUFFRR1l0cWl1SG51OSs2?=
 =?utf-8?B?NTVBMjNSTkswNDNXTXRjSHNONk1YanduT3NDeHRrb2RqQnd6K2UrbHF3YmZI?=
 =?utf-8?B?R2Fzb1NvSFkvYUZNY2pLL3hpVEFiay9RNGNHYjlFN21uSUZhLzB0SXcrK21K?=
 =?utf-8?B?eVlrWDVlbHdPcFVjRE1vaUVoQ3JjNnZjK0g2eHVSb2QzQWFBU1U1NnhPYXoz?=
 =?utf-8?B?Y09JUFVaaVR5UlplbDcxaHFjSS9zUHQwOTY1bk5YYUtuTUlwWnRDMWtyRWlx?=
 =?utf-8?B?b1NYZXRTZHgyMStTUitxMzRWUDBtZk82V3g3clM1L1d4a1g4WlBUYTJKR29p?=
 =?utf-8?B?OEJqMGV0R3hVZnlvTVZteE9SRVdTMVlrZXQ4alZEVWtKRCtwUHRQUy9BdE5z?=
 =?utf-8?B?M1AweERTVmRWOGx2Q3I0VkUxcTFLVmdKRytreVNjWmpkU3NIRUpMWTY2SmVG?=
 =?utf-8?B?WVJnQjd6L25uT1NSWmlFM1lNZ2NmUVp4SEIvbmF3R2d2eFB3dG5VS1RUc0lX?=
 =?utf-8?B?SFZZTTMyWitOWnF3dzB2dlhwaGI4Q0pzVTE5Ny9Dcys0cnpjZHRycUl1YkFW?=
 =?utf-8?B?bkxDR0VSdEMzQi9EQ2JLS3RxYXNCVG51aUpCMWVSUWppeG5kZUZ4NkxNT2dH?=
 =?utf-8?B?UThIeE1HanRNd3NaTGc2UGVZSDBhcXh4ZDRDUWFSYy92S3RzY3N1Uy8yVDQy?=
 =?utf-8?Q?a2f8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49162932-8a99-4718-400b-08d9ba702ed4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 17:28:43.5651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+Xu2ulPa4f+6j7zSrUCBhxcGHEZlly+6XNXiESGnJR9cyAQ0Mwen/A6nFhpN4YW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5330
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
Cc: alex.sierra@amd.com, philip.yang@amd.com, Zhou Qingyang <zhou1615@umn.edu>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-12-08 3:24 a.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211208082457.918004-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">Add null-pointer check after the last svm_range_new call. This was
originally reported by Zhou Qingyang <a class="moz-txt-link-rfc2396E" href="mailto:zhou1615@umn.edu">&lt;zhou1615@umn.edu&gt;</a> based on a
static analyzer.

To avoid duplicating the unwinding code from svm_range_handle_overlap,
I merged the two functions into one.

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Cc: Zhou Qingyang <a class="moz-txt-link-rfc2396E" href="mailto:zhou1615@umn.edu">&lt;zhou1615@umn.edu&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
    <blockquote type="cite" cite="mid:20211208082457.918004-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 138 ++++++++++-----------------
 1 file changed, 49 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f2db49c7a8fd..ed4430e31307 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -941,7 +941,7 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 }
 
 static int
-svm_range_split_tail(struct svm_range *prange, struct svm_range *new,
+svm_range_split_tail(struct svm_range *prange,
 		     uint64_t new_last, struct list_head *insert_list)
 {
 	struct svm_range *tail;
@@ -953,7 +953,7 @@ svm_range_split_tail(struct svm_range *prange, struct svm_range *new,
 }
 
 static int
-svm_range_split_head(struct svm_range *prange, struct svm_range *new,
+svm_range_split_head(struct svm_range *prange,
 		     uint64_t new_start, struct list_head *insert_list)
 {
 	struct svm_range *head;
@@ -1754,49 +1754,54 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 }
 
 /**
- * svm_range_handle_overlap - split overlap ranges
- * @svms: svm range list header
- * @new: range added with this attributes
- * @start: range added start address, in pages
- * @last: range last address, in pages
- * @update_list: output, the ranges attributes are updated. For set_attr, this
- *               will do validation and map to GPUs. For unmap, this will be
- *               removed and unmap from GPUs
- * @insert_list: output, the ranges will be inserted into svms, attributes are
- *               not changes. For set_attr, this will add into svms.
- * @remove_list:output, the ranges will be removed from svms
- * @left: the remaining range after overlap, For set_attr, this will be added
- *        as new range.
+ * svm_range_add - add svm range and handle overlap
+ * @p: the range add to this process svms
+ * @start: page size aligned
+ * @size: page size aligned
+ * @nattr: number of attributes
+ * @attrs: array of attributes
+ * @update_list: output, the ranges need validate and update GPU mapping
+ * @insert_list: output, the ranges need insert to svms
+ * @remove_list: output, the ranges are replaced and need remove from svms
  *
- * Total have 5 overlap cases.
+ * Check if the virtual address range has overlap with any existing ranges,
+ * split partly overlapping ranges and add new ranges in the gaps. All changes
+ * should be applied to the range_list and interval tree transactionally. If
+ * any range split or allocation fails, the entire update fails. Therefore any
+ * existing overlapping svm_ranges are cloned and the original svm_ranges left
+ * unchanged.
  *
- * This function handles overlap of an address interval with existing
- * struct svm_ranges for applying new attributes. This may require
- * splitting existing struct svm_ranges. All changes should be applied to
- * the range_list and interval tree transactionally. If any split operation
- * fails, the entire update fails. Therefore the existing overlapping
- * svm_ranges are cloned and the original svm_ranges left unchanged. If the
- * transaction succeeds, the modified clones are added and the originals
- * freed. Otherwise the clones are removed and the old svm_ranges remain.
+ * If the transaction succeeds, the caller can update and insert clones and
+ * new ranges, then free the originals.
  *
- * Context: The caller must hold svms-&gt;lock
+ * Otherwise the caller can free the clones and new ranges, while the old
+ * svm_ranges remain unchanged.
+ *
+ * Context: Process context, caller must hold svms-&gt;lock
+ *
+ * Return:
+ * 0 - OK, otherwise error code
  */
 static int
-svm_range_handle_overlap(struct svm_range_list *svms, struct svm_range *new,
-			 unsigned long start, unsigned long last,
-			 struct list_head *update_list,
-			 struct list_head *insert_list,
-			 struct list_head *remove_list,
-			 unsigned long *left)
+svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
+	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
+	      struct list_head *update_list, struct list_head *insert_list,
+	      struct list_head *remove_list)
 {
+	unsigned long last = start + size - 1UL;
+	struct svm_range_list *svms = &amp;p-&gt;svms;
 	struct interval_tree_node *node;
+	struct svm_range new = {0};
 	struct svm_range *prange;
 	struct svm_range *tmp;
 	int r = 0;
 
+	pr_debug(&quot;svms 0x%p [0x%llx 0x%lx]\n&quot;, &amp;p-&gt;svms, start, last);
+
 	INIT_LIST_HEAD(update_list);
 	INIT_LIST_HEAD(insert_list);
 	INIT_LIST_HEAD(remove_list);
+	svm_range_apply_attrs(p, &amp;new, nattr, attrs);
 
 	node = interval_tree_iter_first(&amp;svms-&gt;objects, start, last);
 	while (node) {
@@ -1824,14 +1829,14 @@ svm_range_handle_overlap(struct svm_range_list *svms, struct svm_range *new,
 
 			if (node-&gt;start &lt; start) {
 				pr_debug(&quot;change old range start\n&quot;);
-				r = svm_range_split_head(prange, new, start,
+				r = svm_range_split_head(prange, start,
 							 insert_list);
 				if (r)
 					goto out;
 			}
 			if (node-&gt;last &gt; last) {
 				pr_debug(&quot;change old range last\n&quot;);
-				r = svm_range_split_tail(prange, new, last,
+				r = svm_range_split_tail(prange, last,
 							 insert_list);
 				if (r)
 					goto out;
@@ -1843,7 +1848,7 @@ svm_range_handle_overlap(struct svm_range_list *svms, struct svm_range *new,
 			prange = old;
 		}
 
-		if (!svm_range_is_same_attrs(prange, new))
+		if (!svm_range_is_same_attrs(prange, &amp;new))
 			list_add(&amp;prange-&gt;update_list, update_list);
 
 		/* insert a new node if needed */
@@ -1863,8 +1868,16 @@ svm_range_handle_overlap(struct svm_range_list *svms, struct svm_range *new,
 		start = next_start;
 	}
 
-	if (left &amp;&amp; start &lt;= last)
-		*left = last - start + 1;
+	/* add a final range at the end if needed */
+	if (start &lt;= last) {
+		prange = svm_range_new(svms, start, last);
+		if (!prange) {
+			r = -ENOMEM;
+			goto out;
+		}
+		list_add(&amp;prange-&gt;insert_list, insert_list);
+		list_add(&amp;prange-&gt;update_list, update_list);
+	}
 
 out:
 	if (r)
@@ -2883,59 +2896,6 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 				  NULL);
 }
 
-/**
- * svm_range_add - add svm range and handle overlap
- * @p: the range add to this process svms
- * @start: page size aligned
- * @size: page size aligned
- * @nattr: number of attributes
- * @attrs: array of attributes
- * @update_list: output, the ranges need validate and update GPU mapping
- * @insert_list: output, the ranges need insert to svms
- * @remove_list: output, the ranges are replaced and need remove from svms
- *
- * Check if the virtual address range has overlap with the registered ranges,
- * split the overlapped range, copy and adjust pages address and vram nodes in
- * old and new ranges.
- *
- * Context: Process context, caller must hold svms-&gt;lock
- *
- * Return:
- * 0 - OK, otherwise error code
- */
-static int
-svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
-	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
-	      struct list_head *update_list, struct list_head *insert_list,
-	      struct list_head *remove_list)
-{
-	uint64_t last = start + size - 1UL;
-	struct svm_range_list *svms;
-	struct svm_range new = {0};
-	struct svm_range *prange;
-	unsigned long left = 0;
-	int r = 0;
-
-	pr_debug(&quot;svms 0x%p [0x%llx 0x%llx]\n&quot;, &amp;p-&gt;svms, start, last);
-
-	svm_range_apply_attrs(p, &amp;new, nattr, attrs);
-
-	svms = &amp;p-&gt;svms;
-
-	r = svm_range_handle_overlap(svms, &amp;new, start, last, update_list,
-				     insert_list, remove_list, &amp;left);
-	if (r)
-		return r;
-
-	if (left) {
-		prange = svm_range_new(svms, last - left + 1, last);
-		list_add(&amp;prange-&gt;insert_list, insert_list);
-		list_add(&amp;prange-&gt;update_list, update_list);
-	}
-
-	return 0;
-}
-
 /**
  * svm_range_best_prefetch_location - decide the best prefetch location
  * @prange: svm range structure
</pre>
    </blockquote>
  </body>
</html>
