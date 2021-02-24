Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25B3C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842C860233
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842C860233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2211289C3F;
	Wed, 24 Feb 2021 22:19:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0429C89C25
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBvirP+KeN4iY7XxsG86P6q333uJoDz3Qg1wnnv/N835TbE+Jl3A+rl/Hg+R2CQZBBfiweu09n6Pb0tDCaKJaTkzvIrQ2o353mi3kf1JXz9oIU8u/oDNUFfqETQLcXCJFOHBcdl41U0juCB4ow2A80vXluey7WSwgVnnHLJd+C4nhrZWdS3UytW7Csdp+R59gIx4BOgfxb0qyOg3ps6gfFnMGHW4W4A4FuQbiOYJCbmMggmWmvEC+f8kH0T9vH1q4Gld0ZW/Wol8MDLNvXrxLq8fwSY5uJDH/RA+X8M8/LbCiqWpbY1mEOu1s077hvGyzF/JZjtJwREbAAI6vt2Akw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSRGL8X4x2/3Rd7dnO57BQF737uT62CN7HRbjMZ54XE=;
 b=lEwAShNxw2ttPRXj6YYBcs4CKm1oX3t01GE9Xc4HZdWomq/LCVLz6mlQgBdnkJyjvw3XRZsMM/aDlnp6ltV0nsbh6lc+5oUqUIwUHupeRIM18CqtUR7KoNdes0LS/m6k8mxloBbJ1901NImSHogLzJAWuWAvfC88C/Qgk1muOZ2RVXNb8xq0i0ZzltQ2PcxV34iAUC3WuG10l2/FIgiCHtHCR1u45shnP1oDsgiwcJ53ZEhbbOLeLvRnfBdUbLd74lVdrlhGYp1G+wQaAM3PmOVfp1JdR91rLanxU9iH/ok22AQzGt6h3yf1rFZOuCrU9EuLHH2EghYRJyWpviB34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSRGL8X4x2/3Rd7dnO57BQF737uT62CN7HRbjMZ54XE=;
 b=uTRTVvVSUEJPivj84lvsklwO8/W12hgcaX8PHibtciaqHthxCr/DYLBJJM1iqPHtSuCY0rquPqxUNdo6wTkU5mBoDncGHS8cYM1g9o1BKMx26yzY+mwXOu9RhRiDqq/yVFfK6jVFRWxLfK7yOnaSG8QIavQfSSplY2E/AQEjlcc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:19:23 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:22 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 000/159] Aldebaran support
Date: Wed, 24 Feb 2021 17:16:28 -0500
Message-Id: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cd3be8d4-5315-40c9-bd7c-08d8d9123cb5
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-MinimumUrlDomainAge: gitlab.freedesktop.org#0
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB249773E79834F83BA3F9FC2AF79F9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYlHqhRCOapNaJqc/5S8cEE69oRjSdFf7mrZPJdgNUIKsfxlMiiwgAS8mGxnr1QWdwZcr+rdlsclA0PUFPikzLEwb2H+Mc4/q3ncTSxtyissNHDokq+mskXCZgH5Tx+8DqRIL6Km8ejVGM1OzNojlYle7abpkvKeeAR7qP3AS4YucWpoPmEzc5WB+N1LTdzIpmoYZJ7RkC66yz8BvIBhOql7Asy+AlDNuu1oML6utdq1zwcNfAR41ZXyd09+4Uj4aMNuBQMuvi9T9zX/egGpubPPe9y7XhhqRVU+899Ao0h9X9o/9uwrut9sW/vb26YzlgSmY7qJKIgceJ8wtLXaMIEvE6+m58pxgphSAhsHr0MWoaLAWCtDrMmwbcxISx6Ij2iTqVQYIwiAgc+orERuQfzdSi6V6rYekOlJP5L9qWWoMN46fo9naGAaPBZKeZ45wJsWyKbbJgljuGUGApGCFxVbgMeKNT4QKaOTXIN7KN2/vH6fqSY84whChv8F6hr/duIvBo1Im+CKkZi3rJSDy/Nh+DlDBfmKpbzfDaEA5sISy6VL5Nhfl1lbHa1GBazt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(8936002)(6512007)(6916009)(26005)(956004)(6486002)(316002)(2616005)(52116002)(8676002)(6506007)(2906002)(86362001)(186003)(16526019)(36756003)(478600001)(83380400001)(66946007)(66556008)(66476007)(966005)(30864003)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZUt6dTYyTklmZ0ovZytNeFBKVENoTzM5cVFDc1BYRm9UWERETXRUYis3L3dr?=
 =?utf-8?B?MlhXdkgwZ1JGSTJ2S3FsUWdsZFViMkVkVE9hZUVEQzZYaUs0TXAxdlBTdnc4?=
 =?utf-8?B?UFlJVkpVZ2dZZmRkWDhSL0dkZnBxcWhkQmJNc1dOZVZGV1BJV0RzUHllSEc5?=
 =?utf-8?B?bGFMS0JnQnFJU1N4YXNJRGtvVmxxbVVqZlJpNzVjZVJUNGZPTUFZRloxdjdR?=
 =?utf-8?B?aUJieGZHdjV3eGZCV3czaWt3SEVyZStOTk4vNXhDL01VKzdoYzE2WHlSWWly?=
 =?utf-8?B?ejNPbHRpSE0vUDVWSEY3UnZFK1RrUEN3eDcxRERTRkJvYmVBUTVzcmtSd1lX?=
 =?utf-8?B?QWhsdGFSTmtnOWtGem1CWUUvZzFnWjExejE5dkQ5SDZ6UUJ6QnppVmlmMGZt?=
 =?utf-8?B?cXU2emVkZ05YckV2RjByY013MWpaVWFlc0ZURmZnZTJvL01qNm9neFgrb1Ji?=
 =?utf-8?B?TXI5RGdnWHdWeGsxVm84ZUxNdDNJM0JDQW5zVy9CUWtIMW9IdTdCTUtpaGQv?=
 =?utf-8?B?dzI0bzU2SGMwdC9kU2E5MCswQk5uTG0vd21TUDVpYkVYYm1lVVM3N1IyRmhs?=
 =?utf-8?B?Y0ZsUmpZaHZ0Q2pieTVMb1d1UnlWVE5WTWNHNG1CQ2ZUekhHZmhvYnM3Qkli?=
 =?utf-8?B?aXZHczExYVZjYytmT0M5QXVoelB2QlRTcmVZOHBHWTllZUNaWTFrdEZwL0g2?=
 =?utf-8?B?RkJmR0swYncvQkNFS2xWK3Z2UzE5bTlvSkhpcERBMjZrTXVIelljeVVOSGh3?=
 =?utf-8?B?NHpMTVBNdzBvMFFocEs2NWdaczNDQVhSc2ZQaGVTNitIZmNUemF3NHB5WEd3?=
 =?utf-8?B?dktOR0VTaWUrazRwUk9yd3l0TmlOektSdTV2a3NlaEtOdXlNUUJUMWYrazJN?=
 =?utf-8?B?QjRxKy9MQ2dRR09URFFlV1daRFU1R0tXVjA4WURBOXdJa0ttMlNHUW5JZzZG?=
 =?utf-8?B?UFVEQUJBRE1SNDZ4MktDREU0bkJrNUdzU3hZV09OajA5WmVxYXhzNW5iemhM?=
 =?utf-8?B?TDJWdHBOdnZNL3Q0bENtWFFSOVhrRFAyQzJ4bk1zUEZCeUMvV2ZXWVFjak1X?=
 =?utf-8?B?SVB4cG1mV0FNTS9TQXJjSVg5N3VoRm5oMHVuVzlwV0lvQ1U2cktYbyswT1d0?=
 =?utf-8?B?Umh5Y2ZBUHpEaEIzK2RrRm1XUU5WMzhWaitsb3FDSUt3ZTR4ZW5wSmppNmpo?=
 =?utf-8?B?eUE2S0NnMXAxWDBOaCs5Y1pMWFZ4L1RFN1BiSFlMdXJnUWlXdG1qWnlGa2N0?=
 =?utf-8?B?eW82aXdiRzk2RlAxS2ppbzNuem90WFc1cm8wUUh2SFJ1MkZwME8rUUV3RWRs?=
 =?utf-8?B?S2E5WUhvSjkxUGpTMklwUC9MeC9sVmhuelExUTVjRlZHb0R0eVhvRXgvYW0r?=
 =?utf-8?B?SkloUGNlRHd4SUVtMzBkV25ZelNXK2RMSFltY1hwUTU4cC9zRkhPQWxrdjd3?=
 =?utf-8?B?ejFQRGJHOVArcVhqVGNBQjFTSjJ6dnhhc3lmK1pMYm56WHRmaG1YYWc3Rjhz?=
 =?utf-8?B?N0t0L3RiNEZBYm44QTgwTTM1ZjBrRlM1RlBWbVl1bVFaWVRLbUtGczFUV1hI?=
 =?utf-8?B?KzVFY1gwTWw4VXc0bndGbE9vVTZXQWtJejlHY1FacjlWWmhDQ2VQeWhrdjRC?=
 =?utf-8?B?WlhiNEx6LzZSbXhoa0E0MHpYOVdremdHN2pmaWo1QXFTSTZsVlp6a2ZVRDl6?=
 =?utf-8?B?c1Y2a0VzVFJab05wVzQ0VTMvaktBL08zTzdjMzluQ2hNVysxWmk1M3NnMXYx?=
 =?utf-8?Q?7J4z1WkBYLx8yKlvpcqOwkWd7y2rKXaGjizwb7Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3be8d4-5315-40c9-bd7c-08d8d9123cb5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:22.8139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFYe7AV8mt2eUyfCb7zrjoSGEfvCR8905vnpSX25W8sDuZmdjihUxy9lXzQ4G4qZW9uZTjSE7jQSdCUpLm1dmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
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

This patch set adds support for the Aldebaran GPU. This
includes support for all of the IP blocks on the ASIC.

I'm not sending out the register header updates due to
their size, but you can view the full patch set here:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-next-aldebaran

Alex

Alex Deucher (1):
  drm/amdgpu: add mmhub client ids for aldebaran

Alex Sierra (4):
  drm/amdgpu: UTLC1 RB SDMA timeout on Aldebaran
  drm/amdgpu: enable 48-bit IH timestamp counter
  drm/amdgpu: update mmhub client ids for Aldebaran
  drm/amdgpu: use pd addr based on gart level page table

Amber Lin (1):
  drm/amdgpu: Aldebaran doesn't use semaphore

Dennis Li (4):
  drm/amdgpu: enable sram initialization for aldebaran
  drm/amdgpu: add ras support for gfx of aldebaran
  drm/amdgpu: refine ras codes for GC utc of aldebaran
  drm/amdgpu: enable watchdog feature for SQ of aldebaran

Eric Huang (4):
  drm/amdgpu: new cache coherence change for Aldebaran
  drm/amdkfd: add new flag for uncached GPU mapping
  drm/amdgpu: set CPU mapping of vram as cached for A+A mode (v2)
  drm/amdgpu: set snoop bit in pde/pte entries for Aldebaran A+A

Feifei Xu (7):
  drm/amdgpu: Add DID for aldebaran
  drm/amdgpu:add smu mode1/2 support for aldebaran
  drm/amdgpu:return true for mode1_reset_support on aldebaran
  drm/amdgpu: correct vram_info for HBM2E
  drm/amd/pm:add aldebaran support for getting bootup values
  drm/amdgpu: update atom_firmware_info_v3_4 (v2)
  drm/amdpgu: add ATOM_DGPU_VRAM_TYPE_HBM2E vram type

Felix Kuehling (1):
  drm/amdgpu: Let KFD use more VMIDs on Aldebaran

Harish Kasiviswanathan (2):
  drm/amdgpu: Add support for cached VRAM in A+A
  drm/amdgpu: Don't change CPU mapping of on-chip memory pools

Hawking Zhang (51):
  drm/amdgpu: add gc v9_4_2 ip headers (v3)
  drm/amdgpu: add mmhub v1_7 ip headers (v3)
  drm/amdgpu: add mp v13_0_2 ip headers (v3)
  drm/amdgpu: add smuio v13_0_2 ip headers (v3)
  drm/amdgpu: add sdma v4_4_0 ip headers (v2)
  drm/amdgpu: add thm v13_0_2 ip headers (v3)
  drm/amdgpu: add umc v6_7_0 ip headers (v3)
  drm/amdgpu: add vcn v2_6_0 ip headers (v3)
  drm/amd/include: add ip offset header for aldebaran (v5)
  drm/amdgpu: init sos microcode for psp v13
  drm/amdgpu: add kdb loading support for psp v13
  drm/amdgpu: add sys_drv loading support for psp v13
  drm/amdgpu: add tOS loading support for psp v13
  drm/amdgpu: add psp v13 ring support
  drm/amdgpu: init psp v13 ip function
  drm/amdgpu: fix incorrect EP_STRAP reg offset for aldebaran
  drm/amdgpu: load pmfw prior to other non-psp fw for aldebaran
  drm/amdgpu: detect sriov capability for aldebaran
  drm/amdgpu: bypass gc_9_x_common golden settings
  drm/amdgpu: enable psp v13 ip block for aldebaran
  drm/amdgpu: add new smuio callbacks for aldebaran
  drm/amdgpu: implement smuio v13_0 callbacks
  drm/amdgpu: initialize smuio callbacks for aldebaran
  drm/amdgpu: skip MEC2_JT initialization for aldebaran
  drm/amdgpu: initialize ta firmware for aldebaran
  drm/amdgpu: comments out vcn/jpeg ip blocks for aldebaran
  drm/amdgpu: initialize external rev_id for aldebaran
  drm/amdgpu: declare smuio v13_0 callbacks as static
  drm/amdgpu: support get_vram_info atomfirmware i/f for aldebaran
  drm/amdgpu: init gds for aldebaran
  drm/amdgpu: skip gds ras workaround for aldebaran
  drm/amdgpu: use physical_node_id to calculate aper_base
  drm/amdgpu: apply sdma golden settings for aldebaran
  drm/amdgpu: add sdma v4_4 ras function
  drm/amdgpu: add sdma ras error query callback for aldebaran
  drm/amdgpu: add sdma ras error reset callback for aldebaran
  drm/amdgpu: add mmhub ras error query callback for aldebaran
  drm/amdgpu: add mmhub ras error reset callback for aldebaran
  drm/amdgpu: add mmhub error status query callback for aldebaran
  drm/amdgpu: correct IH_CHICKEN programming for aldebaran
  drm/amdgpu: switch to vega20 ih block for aldebaran
  drm/amdgpu: disallow use semaphore on aldebaran
  drm/amdgpu: query aldebaran gfx_config through atomfirmware i/f
  drm/amdgpu: retire aldebaran gpu_info firmware
  drm/amdgpu: bypass hdp read cache invalidation for aldebaran (v2)
  drm/amdgpu: switch to cached noretry setting for aldebaran
  drm/amdgpu: apply new pmfw loading sequence to arcturus and onwards
  drm/amdgpu: allow use psp to load firmware (v2)
  drm/amdgpu: apply gc v9_4_2 golden settings for aldebaran
  drm/amdgpu: add common gc golden settings for aldebaran
  drm/amdgpu: update TCP_CHAN_STEER_1 golden value for aldebaran

James Zhu (9):
  drm/amdgpu: add Aldebaran to the VCN family
  drm/amdgpu/vcn2.6: Add vcn2.6 support
  drm/amdgpu/jpeg2.6: Add jpeg2.6 support
  drm/amdgpu/nbio: add aldebaran support
  drm/amdgpu/vcn: enable VCN on aldebaran
  drm/amdgpu/jpeg: enable JPEG on aldebaran
  drm/amdgpu: enable vcn and jpeg on aldebaran
  drm/amdgpu: enable vcn dpg mode on aldebaran
  drm/amdgpu: enable dpg indirect sram mode on aldebaran

Jay Cornwall (1):
  drm/amdkfd: Add aldebaran trap handler support

John Clements (3):
  drm/amdgpu: updated host to psp mailbox cmd (v2)
  drm/amdgpu: added register list driver ctx (v2)
  drm/amdgpu: added support for register list loading (v2)

Jonathan Kim (3):
  drm/amdgpu: mask the xgmi number of hops reported from psp to kfd
  drm/amdkfd: add aldebaran kfd2kgd callbacks to kfd device (v2)
  drm/amdgpu: restore aldebaran save ttmp and trap config on init (v2)

Kenneth Feng (1):
  drm/amd/pm: add new data in metrics table

Kevin Wang (10):
  drm/amdgpu: add aldebaran sdma firmware support (v2)
  drm/amdgpu: switch to use reg distance member for mmhub v1_7
  drm/amd/swsmu: add aldebaran smu driver if header (v2)
  drm/amd/swsmu: add aldebaran smu13 ip support (v3)
  drm/amdgpu: declare sdma firmware binary file for aldebaran
  drm/amd/pm: remove aldebaran serial number support
  drm/amdgpu: add gc powerbrake support (v2)
  drm/amd/pm: add aldebaran serial number support
  drm/amdgpu: change psp_rap_invoke() function return value
  drm/amdgpu: add psp RAP L0 check support

Laurent Morichetti (1):
  drm/amdkfd: Fix saving the ACC vgprs for Aldebaran

Le Ma (11):
  drm/amdgpu: add aldebaran asic type
  drm/amdgpu: add register base init for aldebaran (v2)
  drm/amdgpu: add gpu_info fw parse support for aldebaran
  drm/amdgpu: add soc15 common ip block support for aldebaran
  drm/amdgpu: add mmhub support for aldebaran (v3)
  drm/amdgpu: add gmc v9 block support for Aldebaran
  drm/amdgpu: set fw load type for aldebaran
  drm/amdgpu: add gfx v9 block support for aldebaran
  drm/amdgpu: add sdma block support for aldebaran
  drm/amdgpu: correct mmBIF_SDMA4_DOORBELL_RANGE address for aldebaran
  drm/amdgpu: set ip blocks for aldebaran

Lijo Lazar (17):
  drm/amd/pm: Add atom_smc_dpm_info_v4_10 for aldebaran
  drm/amd/amdgpu: Add smu_pptable module parameter
  drm/amd/pm: Add support to override pptable id for aldebaran
  drm/amd/pm: Remove CPU virtual address notification in aldebaran
  drm/amd/pm: Set no fan control flag as needed.
  drm/amdgpu: Enable swsmu block on aldebaran
  drm/amdgpu: Add clock gating support for aldebaran
  drm/amdgpu/pm: Remove unsupported MP1 messages from aldebaran
  drm/amdgpu/pm: Fix reset message mapping on aldebaran
  drm/amdgpu/pm: Remove redundant generic message index
  drm/amdgpu: Enable CP idle interrupts
  drm/amdgpu: Fix aldebaran MMHUB CG/LS logic
  drm/amd/pm: Fix power limit query on aldebaran
  drm/amd/pm: Add DCBTC support for aldebaran
  drm/amd/pm: Enable performance determinism on aldebaran
  drm/amd/pm: Correct msg status check for powerlimit
  drm/amd/pm: Enable user min/max gfxclk on aldebaran

Oak Zeng (20):
  drm/amdgpu: Fix IH client ID naming table
  drm/amdgpu: Clean up mmhub functions for aldebaran
  drm/amdgpu: pre-map device buffer as cached for A+A config
  drm/ttm: ioremap buffer properly according to TTM placement flag
  drm/amdgpu: Don't do FB resize under A+A config
  drm/amdgpu: Use free system memory size for kfd memory accounting
  drm/amdgpu: Don't reserve vram as WC for A+A
  drm/amdgpu: Use physical translation mode to access page table
  drm/amdgpu: Moved gart_size calculation to mc_init functions
  drm/amdgpu: Modify comments of vram_start/end
  drm/amdgpu: Placement of gart and vram in sysvm aperture
  drm/amdgpu: Use different gart table parameters for 2-level gart table
  drm/amdgpu: Add function to allocate and fill PDB0
  drm/amdgpu: Set up vmid0 PDB0
  drm/amdgpu: HW setup of 2-level vmid0 page table
  drm/amdgpu: workaround the TMR MC address issue
  amdgpu: Fix GART page table s-bit
  drm/amdgpu: Fix the comment in amdgpu_gmc.h
  drm/amdkfd: Add kernel parameter to stop queue eviction on vm fault
  drm/amdkfd: Check HIQ's MQD for queue preemption status

Philip Yang (1):
  drm/amdgpu: enable retry fault wptr overflow

Rajneesh Bhardwaj (4):
  drm/amdgpu: enable xgmi support for Aldebaran
  drm/amdgpu: define address map for host xgmi link (v3)
  drm/amdgpu: support get xgmi information for Aldebaran
  drm/amdkfd: expose host gpu link via sysfs (v2)

Yong Zhao (3):
  drm/amdkfd: Add Aldebaran KFD support
  drm/amdgpu: Print the IH client ID name when vm fault happens
  drm/amdgpu: Fix an omission when adding Aldebaran support

 drivers/gpu/drm/amd/amdgpu/Makefile           |    14 +-
 .../gpu/drm/amd/amdgpu/aldebaran_reg_init.c   |    54 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |     9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |     2 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |    47 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |    16 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.h   |    30 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |    31 +-
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |    41 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    42 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |    40 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   139 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |    30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |    35 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |    29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |    94 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |    13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c       |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h     |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |    15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |     8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |     9 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |    88 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c       |  1237 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h       |    41 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c      |    66 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c      |    58 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |     5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   151 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c         |     3 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |    65 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.h        |     1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c       |  1329 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h       |    28 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        |    48 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |    40 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |     1 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |   378 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.h        |    30 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |    46 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c        |   232 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h        |    28 +
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c      |   121 +
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.h      |    30 +
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   128 +-
 drivers/gpu/drm/amd/amdgpu/soc15.h            |    12 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |    48 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |    99 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h         |     1 +
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |    32 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |    49 +-
 .../gpu/drm/amd/amdkfd/cik_event_interrupt.c  |     5 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    |   492 +
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm |     1 +
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm |   204 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |    17 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |    25 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |    18 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |     1 +
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |     5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |     1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |     8 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |     8 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |     8 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |     8 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |     5 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |     1 +
 .../gpu/drm/amd/include/aldebaran_ip_offset.h |  1738 +
 .../amd/include/asic_reg/gc/gc_9_4_2_offset.h |  7683 ++++
 .../include/asic_reg/gc/gc_9_4_2_sh_mask.h    | 32949 ++++++++++++++++
 .../include/asic_reg/mmhub/mmhub_1_7_offset.h |  5125 +++
 .../asic_reg/mmhub/mmhub_1_7_sh_mask.h        | 32178 +++++++++++++++
 .../include/asic_reg/mp/mp_13_0_2_offset.h    |   361 +
 .../include/asic_reg/mp/mp_13_0_2_sh_mask.h   |   531 +
 .../include/asic_reg/sdma/sdma_4_4_0_offset.h |  5224 +++
 .../asic_reg/sdma/sdma_4_4_0_sh_mask.h        | 13922 +++++++
 .../asic_reg/smuio/smuio_13_0_2_offset.h      |   516 +
 .../asic_reg/smuio/smuio_13_0_2_sh_mask.h     |  1163 +
 .../include/asic_reg/thm/thm_13_0_2_offset.h  |   346 +
 .../include/asic_reg/thm/thm_13_0_2_sh_mask.h |  1297 +
 .../include/asic_reg/umc/umc_6_7_0_offset.h   |  2620 ++
 .../include/asic_reg/umc/umc_6_7_0_sh_mask.h  | 10796 +++++
 .../include/asic_reg/vcn/vcn_2_6_0_offset.h   |  1462 +
 .../include/asic_reg/vcn/vcn_2_6_0_sh_mask.h  |  4535 +++
 drivers/gpu/drm/amd/include/atomfirmware.h    |   116 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |    12 +
 .../gpu/drm/amd/include/soc15_ih_clientid.h   |     9 +-
 drivers/gpu/drm/amd/include/vi_structs.h      |    32 +-
 drivers/gpu/drm/amd/pm/Makefile               |     1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |    88 +
 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h  |   126 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |     6 +
 .../amd/pm/inc/smu13_driver_if_aldebaran.h    |   512 +
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |    27 +-
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h        |   276 +
 .../gpu/drm/amd/pm/inc/smu_v13_0_pptable.h    |   165 +
 drivers/gpu/drm/amd/pm/swsmu/Makefile         |     2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |    42 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |    30 +
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1447 +
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.h    |    72 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  1834 +
 drivers/gpu/drm/ttm/ttm_bo_util.c             |     4 +
 include/drm/amd_asic_type.h                   |    15 +-
 include/uapi/linux/kfd_ioctl.h                |     1 +
 115 files changed, 132817 insertions(+), 379 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/aldebaran_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/include/aldebaran_ip_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_2_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_7_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_7_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_2_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/thm/thm_13_0_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/thm/thm_13_0_2_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_7_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_7_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_6_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_6_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c

-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
