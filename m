Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F25C47096
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7039761C2E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7039761C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F7A6ED84;
	Wed,  2 Jun 2021 16:49:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF526ED26
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsB2jFVbFl9QRDZy/TYLFsH33bCQJhQa7RjpHeilqLE6/H5g0q6X2CK8z7ikrWsMXcr5O1FHpNJVk7yZ8+iaQEVw1Q6YgRdTXYZklu4XhGM7U/tGK17MC31xTv+MRIyqvwKqmGLzDYaJ2lfsH7YtZmM750SJPB0Z561s0VewObSWWqHEHEFlIQrySzFIzwTL+ieBEgXXSVdydXBG0KcxW+J4pYSFMZGaiiDRuquE4VOex4nt3W8WRekClcDw0FxZu5D2Nk0RRQYHxMcrKzFJyuftloE3oq6qlluhbfwPSEhHZla64+DTXe3hSQZA1Q76Di21iVagPZqDxSqYrR08Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmUfF3OuZj6x4gzFKSJDnk+xm7KTkjjIq1Q378/Hdl0=;
 b=SrOX/TTPHWQR1GLtnkALyaIBAMaJVMd1sNP76+HgFWyNUcyXlCm5MpnwbweeOyWr1xDs+pr74Fm4MPSFom+n/dm1LNhDdu4NkuWlwVMTnEX8INBrX7aPcclwlMBRkg73mLVlKh7P/QAnj7+U0q//xm4Y38hcO9cnKlx9qGGsTX/jhzVI633+jxU7gcycsN0Oy7hFqFO1nAyWuffba+HEbrVVDKlRridGO5GvtJK79E/+DluYl2p3AIgG6yJ52qNqI49in2r/qowarQwFmGvBaGvXLtKINB/SY0wtrJpfCGlvHo8cLSqR7eOFK997sSJDc+zLt/qlTvzdQDLJ8lH0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmUfF3OuZj6x4gzFKSJDnk+xm7KTkjjIq1Q378/Hdl0=;
 b=KVDwu7rnajvxPFk1BBWancjPAqNxTMpdvg5KoSpT7l/0Y/lGIEml30XqtIY+kdtp2ufLeBpFzsEempDItEOYKxZ7bUSPnTLLQPYWn1aPSHkFGXQHCCAKTVwDEZWMWYWJ+nVtF3Bxv3R3Cd7cjMJqQrPmH8RSu6yIUxrhz3jyTww=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:49:29 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:29 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/89] Add initial support for Yellow Carp
Date: Wed,  2 Jun 2021 12:47:40 -0400
Message-Id: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a060842c-bea0-4df2-7bbc-08d925e66354
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB46757ACF75E698B7305ED067F73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jupUhA0Dci4pWJmpwGfM2iz16gfCpffx9RnF4fo4mhpZpx4JP7IRLZPvkf5TFuHxkon6rDSMUIthsUu8GMVFNHS97+ne9ul6X1AretmT2W/4EWK/276GnDQsp99TPxuun6EjXJcYYHFl0UuxycDbLTHdB5NzNBwlRiwhsgj2TdzMIpES+VMPos/LXZ9vbmNMVPmneLi0hnUfhOI1O5/gGwogcBP7z7lnRD8FsmbAOPCq9TJRMTCLiBhAuyKlDfFHfta4nJHRpXrDP4CW8JKsBba2sji49ywZ94sB1Gbs7nYAsCh1ahFeY+cuQAYqgKL7QEsMBkACEzeoI+M1aADx9NxhgrtUM5EFBWlfcIdCDeoEkZ7lubSnfWvFbgCAwjupfgtRbBFMs9TWfmKFHwesbb50gMaErWmum1/WMtvQSkNJHWPC/6MTuthr0bPfseWPa2icCASnHIVDy41yIcXDhNxahz10YmbPVLMrg4rWYY1BbzT9CGnyDBS9E7EYMIEwcYoA7JZK2JJn4zo2MvJrKZHpZgJvo3AoZgeJs7PxoZhJi18qay6u7gb4b+CWzMkrXoYQ61kkm+xoQm23w1eLYU9mJw8p6YU/l7X05q+MipxByNJTPFzfdKaSmPmW24+CiB6lgVFAErvsQQnWxpNxlKDQip4W6j0YUpo9ANjux78UuhEfF25IgyQyy+6/MYvoX/lFpz4fwKYAAXoJBVbWvxivIH041VSm3b3Qi5dVZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(30864003)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(6512007)(478600001)(38350700002)(66476007)(966005)(66556008)(83380400001)(8676002)(2906002)(4326008)(86362001)(1076003)(19627235002)(16526019)(316002)(186003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oe73x1cRHmP+4XDasD19rOxypNYZmG1PjBscxftr/fbtS6KYY9hqBMxRnWSJ?=
 =?us-ascii?Q?zPKrCHTFYuk+W19j1Px0cBQOsas8aHfMHsbT6iXB9ZdHPsSjW4FFpZlSv4Kf?=
 =?us-ascii?Q?aFxYei0+oNQVpT6VzEElJxwgWMm7weH1kfZF97VO6fKwy/igjpuhOt2la6IA?=
 =?us-ascii?Q?d1DHs1+8MNDAQgxg4vUEyhTVLH0il83C10swdF43/RHrBRz283ay7zrOzHin?=
 =?us-ascii?Q?RvIp1rf0AZ++GbV6fagXJoQVYHX1Fp9wJgkKkhFlW8MLDexkrWv7pNB1WV4f?=
 =?us-ascii?Q?NRFeuT6Q9g8oJnghHaHTQ66J11h+HlZqeYrde9B6JlfloBrpaM6dpIMCd40F?=
 =?us-ascii?Q?Ng6qWYchvSt9iefaUD8UuwVuTdCIu//oJ2p4HNy3TQpYE7HAcay8lKczv9J2?=
 =?us-ascii?Q?/IqSGSE4ghgH6+ybG1y0NJVVDk/n4ENIP4uRwh9SuA3qnUmcRAqLv+wZQWzs?=
 =?us-ascii?Q?qbX2Xqm+ve9xvmiZk9kQ79eVDpKObO6Me9s+Rxwlvvz8fdMB1BqPEHbOvmQm?=
 =?us-ascii?Q?UcxVJ/OB1hRsV89FqWAOhJmc9dtTzPmUUyWG5jlHJmAahwLUR+NhtAVB13Wz?=
 =?us-ascii?Q?rsIjUQVKoDx7xuXJvG84kATusxC2t/Fj6M81LAn4LWdwxgZN1qoeO6A0XDkq?=
 =?us-ascii?Q?jxIPjfmlMVL4bZwVE+OEFgw9tfNRBV1BvwelrD+rMPRVRVqf2bZInYQtAxwU?=
 =?us-ascii?Q?WBRcCkAa5/jHdM/PHmYZY1glDMDatOXq3LeNuafHK4dZ7cEIy6Gay03o2O+d?=
 =?us-ascii?Q?n7w1khmmKt5rZNbSbtd+aC1Lhm0OZ8K/iXQG2zSY7MjYstBpsaglQbm997Tr?=
 =?us-ascii?Q?2QZKy5Qr6JPcFqf/9Jvw0DrRzCzn8H3VkWxqFOKb3zBuHzmiHVWXHZ7RuwJs?=
 =?us-ascii?Q?Cf3N5TAMONwGO+3QCf/gx0LMsCvjSnJG3r/QQOj0JZJp1islhmyMrJoIV2B8?=
 =?us-ascii?Q?Ft2PxYy1cyj1nNYoxGsn3HX8nWy5Zn+wRFxZK/heh06vq/x5R4lrwUtbV8T9?=
 =?us-ascii?Q?33vDuz/6t1JnJsBXw88gSI6v92pYs1fkQUDE1kMCrO6rDCca9DHsny8i9B55?=
 =?us-ascii?Q?n1Hcoo7zKu9xR3DNBwjbM/w8JY3cjJzTROegVSKz5TWVhrK2A7dE732oM8Y+?=
 =?us-ascii?Q?MQbHycgwpGN/LNTxds5GT212o/wqMyEDDYxXKbNjYoWzRXHl8iLiihI1jB+c?=
 =?us-ascii?Q?Xy9RLx6I4RdCF4ds3d2YfCdHqEZ7YKwY7nei2vjC6sV029o2E7skfA8x524i?=
 =?us-ascii?Q?DLo43PtdXEGh9etSexuhJrEeFnqkyuyrhekTgqfBX4dffywjcw1M7aC+IZIm?=
 =?us-ascii?Q?4xEy1N6QUMXTix75kCRxlyt4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a060842c-bea0-4df2-7bbc-08d925e66354
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:29.0694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7fnJ+a1DxhA6rmG9wBowO1J3EeoSSdS/lgvJti0Ck9Tbn9j7+12QP1Cy/ws0dRaHruEQm+5VlyxF24xAQfjnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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

This patch set adds initial support for Yellow Carp, a new
GPU from AMD.

I did not send out patch 1 due to its size (new register headers),
but you can view the entire patch set here:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/yellow_carp



Aaron Liu (42):
  drm/amdgpu: add yellow carp asic header files (v3)
  drm/amdgpu: add yellow carp asic_type enum
  drm/amdgpu: add uapi to define yellow carp series
  drm/amdgpu: add yellow carp support for gpu_info and ip block setting
  drm/amdgpu: add nv common ip block support for yellow carp
  drm/amdgpu: add yellow carp support for ih block
  drm/amdgpu: add gmc v10 supports for yellow carp
  drm/amdgpu: support fw load type for yellow carp
  drm/amdgpu: add gfx support for yellow carp
  drm/amdgpu: add sdma support for yellow carp
  drm/amdgpu: set ip blocks for yellow carp
  drm/amdkfd: add yellow carp KFD support
  drm/amdgpu: support nbio_7_2_1 for yellow carp
  drm/admgpu/pm: add smu v13 driver interface header for yellow carp
    (v3)
  drm/amdgpu/pm: add smu v13.0.1 firmware header for yellow carp (V4)
  drm/amdgpu/pm: add smu v13.0.1 smc header for yellow carp (v2)
  drm/amd/pm: add smu13 ip support for moment(V3)
  drm/amd/pm: add yellow_carp_ppt implementation(V3)
  drm/amd/pm: partially enable swsmu for yellow carp(V2)
  drm/amdgpu: add smu ip block for yellow carp(V3)
  drm/amdgpu: add gfx golden settings for yellow carp (v3)
  drm/amdgpu: reserved buffer is not needed with ip discovery enabled
  drm/amdgpu: add psp_v13 support for yellow carp
  drm/amdgpu: enable psp_v13 for yellow carp
  drm/amdgpu/pm: set_pp_feature is unsupport for yellow carp
  drm/amdgpu/pm: add set_driver_table_location implementation for yellow
    carp
  drm/amdgpu: add GFX Clock Gating support for yellow carp
  drm/amdgpu: add MMHUB Clock Gating support for yellow carp
  drm/amdgpu: add GFX Power Gating support for yellow carp
  drm/amdgpu/pm: enable smu_hw_init for yellow carp
  drm/amdgpu/pm: add gfx_off_control for yellow carp
  drm/amdgpu/pm: enable gfx_off in yellow carp smu post init
  drm/amdgpu: add SDMA Clock Gating support for yellow carp
  drm/amdgpu: add HDP Clock Gating support for yellow carp
  drm/amdgpu: add ATHUB Clock Gating support for yellow carp
  drm/amdgpu: add IH Clock Gating support for yellow carp
  drm/amdgpu: enable VCN PG and CG for yellow carp
  drm/amdgpu/pm: support smu_post_init for yellow carp
  drm/amdgpu: add RLC_PG_DELAY_3 for yellow carp
  drm/amdgpu: add timestamp counter query support for yellow carp
  drm/amd/pm: add PrepareMp1ForUnload support for yellow carp
  drm/amdgpu: add mode2 reset support for yellow carp

Alex Deucher (2):
  drm/amdgpu: add yellow_carp_reg_base_init function for yellow carp
    (v2)
  drm/amdgpu: add mmhub client support for yellow carp

Huang Rui (2):
  drm/amdgpu: introduce a stolen reserved buffer to protect specific
    buffer region (v2)
  drm/amd/pm: add vcn/jepg enable functions for yellow carp

James Zhu (5):
  drm/amdgpu/jpeg: Remove harvest checking on CHIP_YELLOW_CARP
  drm/amdgpu/vcn: add vcn support for yellow carp
  drm/amdgpu: enable vcn/jpeg on yellow carp
  drm/amdgpu: enable vcn dpg mode on yellow carp
  drm/amdgpu: add video_codecs query support for yellow carp

Nicholas Kazlauskas (22):
  drm/amdgpu: Load TA firmware for yellow carp
  drm/amdgpu: Update atomfirmware for DCN3.1 phy tuning and eDP caps
  drm/amd/display: Add DCN3.1 yellow carp asic family IDs
  drm/amd/display: Add DCN3.1 clock manager support
  drm/amd/display: Add DCN3.1 DCCG
  drm/amd/display: Add DCN3.1 DIO
  drm/amd/display: Add DCN3.1 OPTC
  drm/amd/display: Add DCN3.1 DCHHUB
  drm/amd/display: Add DCN3.1 DML calculation support
  drm/amd/display: Add DCN3.1 IRQ manager
  drm/amd/display: Add DCN3.1 GPIO support
  drm/amd/display: Add DCN3.1 DMCUB
  drm/amd/display: Add DCN3.1 PANEL
  drm/amd/display: Add DCN3.1 HDCP support
  drm/amd/display: Add DCN3.1 BIOS parser support
  drm/amd/display: Add DCN3.1 HWSEQ
  drm/amd/display: Add z10 restore checks for DC interfaces
  drm/amd/display: Add DCN3.1 Resource
  drm/amd/display: Add DCN3.1 blocks to the DC Makefile
  drm/amd/display: Add DCN3.1 Yellow Carp support to DM
  drm/amd/display: Add DC DCN3.1 support to Kconfig
  drm/amdgpu: Add DC support and display block for Yellow Carp

Xiaomeng Hou (16):
  drm/amd/pm: add read_sensor function for yellow carp
  drm/amd/pm: add set_watermarks_table function for yellow carp
  drm/amd/pm: add the fine grain tuning function for yellow carp
  drm/amd/pm: add support to get dpm clock value for yellow carp
  drm/amd/pm: add feature map for yellow carp
  drm/amd/pm: implement is_dpm_running() callback for yellow carp
  drm/amd/pm: initialize feature_enabled/feature_support bitmap for
    yellow carp
  drm/amd/pm: add callback force_clk_levels for yellow carp
  drm/amd/pm: add callback to get bootup values for yellow carp
  drm/amd/pm: add callback get_dpm_ultimate_freq for yellow carp
  drm/amd/pm: add callbacks to read/write sysfs file
    pp_power_profile_mode
  drm/amd/pm: add the interface to dump smu metrics table for yellow
    carp
  drm/amdgpu: add gpu harvest support for yellow carp (v2)
  drm/amdgpu: correct the cu and rb info for yellow carp
  drm/amd/pm: add set_performance_level function for yellow carp
  drm/amd/pm: disable manually setting MCLK power level on yellow carp

 drivers/gpu/drm/amd/amdgpu/Makefile           |      2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |      9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h    |      1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |     19 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |      1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |      4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |     10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |      4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |      1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |      8 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |     83 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      |     40 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |     17 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |      9 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c       |      1 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |      1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c        |    142 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |     51 +
 drivers/gpu/drm/amd/amdgpu/nv.h               |      2 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |     37 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |      7 +
 .../gpu/drm/amd/amdgpu/yellow_carp_reg_init.c |     51 +
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |     52 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |     19 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |      1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |      1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |      1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |      1 +
 drivers/gpu/drm/amd/display/Kconfig           |      7 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |     44 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |     13 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |      6 +
 drivers/gpu/drm/amd/display/dc/Makefile       |      3 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |    113 +
 .../display/dc/bios/command_table_helper2.c   |      5 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |     11 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |     30 +
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |      4 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |    673 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h  |    103 +
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |    333 +
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.h  |    271 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |     17 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |     18 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |     26 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |      6 +
 drivers/gpu/drm/amd/display/dc/dc.h           |     28 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |     23 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |      3 +
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |     21 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |     23 +
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |     48 +
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |     20 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |     11 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |      2 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |     54 +
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.h   |      9 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h |     16 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |     37 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |     39 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |      5 +
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |     35 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |    279 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |    147 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |    412 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.h |    246 +
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |    956 +
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.h   |    122 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c |    103 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hubp.h |    246 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |    598 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.h    |     56 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |    151 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.h |     33 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |    287 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h |    259 +
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |    157 +
 .../amd/display/dc/dcn31/dcn31_panel_cntl.h   |     40 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2180 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.h |     42 +
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |      5 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |      6 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |     11 +
 .../dc/dml/dcn31/display_mode_vba_31.c        |   7506 ++
 .../dc/dml/dcn31/display_mode_vba_31.h        |     43 +
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |   1727 +
 .../dc/dml/dcn31/display_rq_dlg_calc_31.h     |     69 +
 .../drm/amd/display/dc/dml/display_mode_lib.c |     18 +
 .../drm/amd/display/dc/dml/display_mode_lib.h |      4 +
 .../amd/display/dc/dml/display_mode_structs.h |     12 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |     42 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |     52 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |      3 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |      3 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |     10 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |      3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |     56 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |      5 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |     14 +
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |      4 +
 .../amd/display/dc/inc/hw/timing_generator.h  |      4 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |      4 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |     11 +
 .../display/dc/irq/dcn31/irq_service_dcn31.c  |    432 +
 .../display/dc/irq/dcn31/irq_service_dcn31.h  |     37 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |     12 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    118 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |      3 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |    354 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |    230 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |     37 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |     13 +
 .../gpu/drm/amd/display/include/dal_types.h   |      3 +
 .../drm/amd/display/modules/hdcp/hdcp_log.c   |      4 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |    135 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.h   |     38 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |     23 +-
 .../include/asic_reg/dcn/dcn_3_1_2_offset.h   |  15083 +++
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |  60747 +++++++++
 .../include/asic_reg/dpcs/dpcs_4_2_0_offset.h |  11936 ++
 .../asic_reg/dpcs/dpcs_4_2_0_sh_mask.h        | 103385 +++++++++++++++
 .../include/asic_reg/mp/mp_13_0_1_offset.h    |    355 +
 .../include/asic_reg/mp/mp_13_0_1_sh_mask.h   |    531 +
 drivers/gpu/drm/amd/include/atomfirmware.h    |     56 +-
 .../gpu/drm/amd/include/yellow_carp_offset.h  |   1366 +
 .../amd/pm/inc/smu13_driver_if_yellow_carp.h  |    222 +
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h      |     57 +
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h |    139 +
 .../gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h    |     97 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |      7 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |      2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c  |    311 +
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |   1210 +
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h  |     28 +
 include/drm/amd_asic_type.h                   |      1 +
 include/uapi/drm/amdgpu_drm.h                 |      1 +
 136 files changed, 215465 insertions(+), 66 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/yellow_carp_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_1_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/yellow_carp_offset.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h

-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
