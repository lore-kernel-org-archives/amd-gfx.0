Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5000C54FB3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 May 2025 17:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 322D910E351;
	Mon, 26 May 2025 17:48:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jpj1xgVt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D1F10E071
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 May 2025 17:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLblDHEcMDUPdmweciFGAawsTL6SjX4tNBgsePhYk8qR5WhVm7tao/KTFYcaEIYLhKGoI1jOGzIm8R3vhv2xNPMn15KaWr7ZukFrcZ+p5UGQXDvzyQSGH5hHuGtR0wlYJzuIMbj0Jk1cSIobEOL4EqZetOAdbMGTHa0jp6C3q6CmU5Zq3AZzmXls+fUS7KjBTTHLJwMeYp3sYyD9fVB5DziUx2uhlDKqaAiQymp96Ji2qInyio5BoAGQlrbmJtCHHVd2WhJTAS/NBbUbXjv/qS0NsR10HtKvgTGMGyzYIWi41mmNlf4h0vPkm4PaEImDLeBl/McBLnGRBoAe8UrPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGBPVt3ErQoDS7jk8I8r46xeQUZmC5p3We6vf8njBsc=;
 b=XbKiPd9rZtfJk/hK9siFNLVHO0szLLQH+WGYLBCoRbkaEeLYOYN1V9T1GrXa9hgQoKDrxuOlAxWI+Kpg37VUWlIErkT5sjUjYw1nJCby/ZCoyKZSIWN3bFNNABX9x+3QzcQ+9F5NBeixh03VxgGM9At63HrHp8E6OljRG/SSFZAB4UY/kr/fFN2cjBBYAnWpeTJqzPJHdxaD7l2rp38cT6pu23bHQF7J+tP/f6zZrV8L6sqlOnRD8cO3QoDKo+MWoujW/22mC49PAGGrgTD1143SkcpuFd4aBlrSW+nBYKzaISWp6bzRTO/KHbqlCnw/fCSgBP0WMtXOTKQGqRZYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGBPVt3ErQoDS7jk8I8r46xeQUZmC5p3We6vf8njBsc=;
 b=Jpj1xgVtyadrbqXt6WZIL8fM/lLMKuYrcje8skn3O7jFKiixb0zXaqKPT2K8l90YEvckINsoLv4e0/H+FOBv/hjxRjKvvwJublGQJAhNU8K20jaMVj1WxoDKN5Dt6sTimTcG1U/LxnRP5Pbz5acXyYg5tYgEB4b83JZOs1krf/c=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Mon, 26 May
 2025 17:48:29 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%5]) with mapi id 15.20.8722.031; Mon, 26 May 2025
 17:48:29 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Clement, Sunday" <Sunday.Clement@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Tudor, Alexandru" <Alexandru.Tudor@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Identical code for different branches
Thread-Topic: [PATCH] drm/amdkfd: Identical code for different branches
Thread-Index: AQHbzD5SvxqjWhNpykOsWWIkdNW4a7PlM86Q
Date: Mon, 26 May 2025 17:48:29 +0000
Message-ID: <CY8PR12MB7099F2C5D967A48E80A3AED98C65A@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250523235339.828608-1-Sunday.Clement@amd.com>
In-Reply-To: <20250523235339.828608-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=e53ece10-336f-4a2c-8c67-d541e19c9805;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-26T17:46:59Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|PH7PR12MB5784:EE_
x-ms-office365-filtering-correlation-id: eeb28430-2c71-4bf7-67b7-08dd9c7d862e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Z3n8VJ4qSj+i70tpJW2jtOdpn+sQ3LkES8BidzzeQs9sMCtjXMfchRE2oU8z?=
 =?us-ascii?Q?rOYspsd5AZSZHsyPBWiewKC7z6BXEs2f803tjdTYhHgpikev3gtNHfhrpFDr?=
 =?us-ascii?Q?pf0MO397PsCK2sY6NQKVkwjcaREkRSgd0d0Xw0VoEE9NtaPBE5Zu5P3LVFQO?=
 =?us-ascii?Q?3B9RS1OTyqMRdRLtAUQ1uvRHFXT6igmyswW53TMwCArx4Fx1FWDhSjMf/8/j?=
 =?us-ascii?Q?YRBCHhhMyykH2ep5gax8XF9teT6BTudBi5kpx0ShNPrfxO+DH2YAsbEmlcef?=
 =?us-ascii?Q?vn8M/YHiaWmbbVgN7glkNPUrpl7rlXjsLx10XAfC9ku0cgaW7dQaJOnL5GPT?=
 =?us-ascii?Q?z34JN87CheOPiP7OJoJVU21au8ayX8XxFI6v6Cj4Y/Qq1owXZgIA6ysbyyqX?=
 =?us-ascii?Q?RjyZy7NqGqYUVjKKXR89cIw3lzcZN11keyBg24Z9UJt1q57cyJtMcc2i3EIp?=
 =?us-ascii?Q?0yGaKX1iUAN4aq4MhfXdPSf7BEBYUUfb9BITY0B2YkqG9iMhMF6qtCtav1wQ?=
 =?us-ascii?Q?CmXMcFQdbtenLK1nSPk1ok61F/mEKI/0T91o1si/tcJAaOnxVvdg+DHEXF+Y?=
 =?us-ascii?Q?SF7kkiXjRaiuVJyD5RdxqfS0moXXKpJ2TW8cLN58oVOFWCPRuIYsQq27/MT1?=
 =?us-ascii?Q?taY3FefczsVpQ2Ynu1UYHrXND3nXD28AbfYKaQn69uIwh+3MOwCwMVyGmiud?=
 =?us-ascii?Q?AvswaQ1QaZMrpiFSLSOo3YYIw9GXNdT/Y9REUmnBIP30+Ovf+gmrwXKVnXy2?=
 =?us-ascii?Q?ri68sCj/6Kn4edCU3lmhkLVPqgEDnB0mwYLD7jxt/X7dc9jlmAwjZ2/Fn0Do?=
 =?us-ascii?Q?C1UM5vPPmNmlYW4TyZg/gRjJ2yAt8aOq9nKBVDPB+DSnYdrNAlimNhzuSVaM?=
 =?us-ascii?Q?FrTFMviQMOckeweyHEn8X+Fcl2lL2QuqEl5JIWIeislaJLNJzn2LOMO7Qa24?=
 =?us-ascii?Q?3zYHHeqPkiT9wUC5vbPHLCpwp27u1XV2kQxLEJ3XJ3Ykvbucf/qHNYrq/1G1?=
 =?us-ascii?Q?oFjXdRPqx0BCxCDfs+GtfRQ+dNgGdfD7wi4vf0/C1A2kluvmPGTi1VcomyaD?=
 =?us-ascii?Q?e0LfB7FN4D08ZZP1XIme4E76CDTQq8161iZcouNEmUp+ZAt4NMmeQBAX5nwE?=
 =?us-ascii?Q?VjtVy9DYPg7hwuVgPLQknienMmUwyx9nGXeg60PWd170ieRm9tskrpofy4I/?=
 =?us-ascii?Q?03dzgUw/5RdKJ1jP4Bl1am3Q+bdUR+w6GxfNHSPGOPBphT6QNkqu7GlDc3eb?=
 =?us-ascii?Q?UyBBVlwOMcjvBFzRNWasU0asbg4OyFIftXHY8Bzdvci+pko70nlmVCYUbxoq?=
 =?us-ascii?Q?UniL1FXy8pKJXcyTdxwls00govD2CIrcN9y5tW/OvYspE/w0fAGEMb8OhkKC?=
 =?us-ascii?Q?vIeNNG5QACMzQ9lHYqZB9ALqJdGRlJ1EtCjPDV1bObR8E72YC8+qixuNbgKo?=
 =?us-ascii?Q?nr4m5UtXRqf1zsmUHvEH4Rlkl9ANn63xiJTki83Qe46COppiuzWunOkmQd15?=
 =?us-ascii?Q?SX6B0dkAeTYndPw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pU2XsQhLqGqgxFCck4cK/pX0hmKCDZgN0X/eFVjEVB23LEEXCa+LIjvTHIWS?=
 =?us-ascii?Q?BjC3OP1QwhTbtAaRSCOVef1U/QAVmt8GjpepZOUrvcTcn53u4+HcWQvb2gAf?=
 =?us-ascii?Q?23w/kACb1z9gnB/MK5Aq+aD8gbMftf7eeNVpGEkAo89Et7Oj1swCzc+FvAop?=
 =?us-ascii?Q?PU2zUXRS65VW+xggNWOEBbQje4eh6MYdQIDk+Hk7StgZEOvKAJuqnRYAxXC/?=
 =?us-ascii?Q?yMWlcRxuggG9/8nhWXeZns/s4wHBFQEuiPHYZnI4UKt0+juq8zwXzEbZNmuB?=
 =?us-ascii?Q?ldDEzgqW7oQ2lIxuh+mAYN33vqABGeHJ8iXPfFtkowpJ+5O70Pn0IexRYpDN?=
 =?us-ascii?Q?Z8EdcAMTD5F6041gQu0fotylUpfJDSF+Vg0LlvROFXNQtLBnKfDUU3ZODDYn?=
 =?us-ascii?Q?8yBFC3f0bcKGw1cTDo3PbhoS7j4HIv4FdcKM5RHmCojac2e8g8tEA6sPofnq?=
 =?us-ascii?Q?hLtyyazdksk9ctnZnRItrukxwFj3x8IuwyUVxM2kHyWPWG5w+mGtdWlfta1b?=
 =?us-ascii?Q?e97wvCc7kAmwWJS8B5fzGEE8M0mzSYdEC6F10XgeBF9++E4yW26VxQ3utP98?=
 =?us-ascii?Q?XDxpD7UzjvxjdEkx1gLtkGlZS8t5uTZ3U2g/K/LR/PjAQTxDL+CVeai3xwoG?=
 =?us-ascii?Q?m1MKG3IakRgctzahFH3FohxwLKI4s7N/f+6Di9ifUgIcO7eUOAgHyQqcs6U+?=
 =?us-ascii?Q?ojQLhaL9G8lHgxvkSi/ZmC31W1QlDQhtZw28AibfkndcpwJEGK6cZncNtBCn?=
 =?us-ascii?Q?WMIrmlg+ehxyEKYdccQOJ8bS5jaBABYc3ltM2YQH+a6yHwpb+SEcbs4C8RBF?=
 =?us-ascii?Q?bA78piPeyyq9uOG4OsHdqNKDH3sLiA/YuGrDuWH+dp2/npnCJCYfzyUggTk/?=
 =?us-ascii?Q?hnJTA8EP8f7sXO4NR/e/rdW5oSAkGNh4lXxKygbDBMQx5zpw3u68aTR38bLy?=
 =?us-ascii?Q?tgJ6Pe9+HSRjfY44UVcvGqtNnIm6qifWQnvS/qMlYUop81FRGF8lKlQRwjwC?=
 =?us-ascii?Q?GFAjQL5xEjTEO+Ls+aZ/uKARpKcf+L7lI1uLpZQjZQPA7mddjISWqzJGZ5MI?=
 =?us-ascii?Q?22xuBT/28mAcfXg7cba6eB9lHZR18IOLUxG3b1AYydR4MpX3bDXBGeOorJp2?=
 =?us-ascii?Q?Frfnr9AOw/cPny0XKtYrtZ8pyLGwJNbrhW4Fr6fgYie+lW2eqcC5ceh7b+Fu?=
 =?us-ascii?Q?Q4X7PI35q0CtIL9zFCgZ0Pt4ShyzWAj01Tsz+/vWsCAEqMHksPt6LyfRSX2F?=
 =?us-ascii?Q?5FtmX5rug8DX1/H9jTlaKeGAXy4Z+fkqiMEfUrsqYKR1hT6mppDfJn3cyMTC?=
 =?us-ascii?Q?otQihl3pm9JcSUdqNP9ax6WIfmagpJYu4XoH5c/zM6FHn9n0N3DnbsVC99U6?=
 =?us-ascii?Q?UfK8mSp7z7l2qkC76CuuqBb1eJfM8m0QTCgc2PiHc7yJCkcjD7anZf8585cj?=
 =?us-ascii?Q?VEvgwLAm/JA4b9WkXQZXacJRltIEGQMDgUpsgd9+QkBvR0eV5qQ3++qnkL4y?=
 =?us-ascii?Q?6up+c7J0ghnZwHEu5Ltd2olq3cQ4DEz/XkhhGe26hTSFy/eEW+yD0Ks98zZ2?=
 =?us-ascii?Q?BsxzcTHN9F2WK55qBTs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb28430-2c71-4bf7-67b7-08dd9c7d862e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 17:48:29.2439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMpqHyAV0HQ14x0B8ktnuBF3rwznuEYF/qWEv2DfzZDcjHWB5mFAHNqAyCnoUN4a+rjChhnFuuPaRSirfbO99Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
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

[Public]

You can remove BUG:SWDEV-534537 from commit message as it doesn't provide a=
ny information to public. With that this patch is

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com.



-----Original Message-----
From: Clement, Sunday <Sunday.Clement@amd.com>
Sent: Friday, May 23, 2025 7:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Tudor, Alexandru <Alexandru.Tudor@amd.com>; Kasiviswanathan, Harish <Ha=
rish.Kasiviswanathan@amd.com>; Clement, Sunday <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Identical code for different branches

This patch removes the if/else statement in the
cik_event_interrupt_wq function because it is redundant
with both branches resulting in identical outcomes,
this improves code readibility.

BUG:SWDEV-534537

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu=
/drm/amd/amdkfd/cik_event_interrupt.c
index 981d9adcc5e1..25f32771b228 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -125,11 +125,7 @@ static void cik_event_interrupt_wq(struct kfd_node *de=
v,
                        return;
                }

-               if (info.vmid =3D=3D vmid)
-                       kfd_signal_vm_fault_event(pdd, &info, NULL);
-               else
-                       kfd_signal_vm_fault_event(pdd, &info, NULL);
-
+               kfd_signal_vm_fault_event(pdd, &info, NULL);
                kfd_unref_process(p);
        }
 }
--
2.43.0

