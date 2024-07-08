Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DB2C3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 10:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0704010E131;
	Mon,  8 Jul 2024 10:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j/RWaiSW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC25F10E11F
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 10:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L06ZVDrq3YcNXHRMpL7DrOJXktR83NuGQoZVfLrpzmU5zvYpwPKlVm9HBb/mo7gFKSr4Cijs1OUA/Ll0qNPReEiVS6wx6CEoQXYKZ6TZIjp4Ewby2tJJyWSlT1gUu9GRkOxFANo+KYWTueQp2+j63eEfg6fOrvzapf0B8YCVkfKLVUn9Tr+heMbdopJdnDKSRMc+XIUoNfkLsnviCp3dvCSK8auUqprCBEnKZRJbcuRRRyn2j8RmnrHMXdYj8PZWO5hU6AE02Z1e/ClaLbh6lb1wyTByVDGggUpbqzHTBz2+XV+P+bDJHY3RvRmv3CNKY+dAHuSZiiV4uA5tkvogEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rfz7oAPofQ/rHVemRJHOMfINViImT+w65DltNiIdx+M=;
 b=YilWTBu1KSVU5x37Sp98lrxvUHaJFx4L0lm71wg26xsneXOr7xz6qG+xEMgMGJYi10Dsuva6DkqiV6jS/11iGa67pI/EYtqvMSUSPP91Oa7DGo/1bSPJZmCiVf8nvrm6hZ7frVNOjJdlgzjj3FaRJjW1h4DagyTjzTWRkzwGySShosivs83ZKhfYTNUZc830XlNFLT2yFsa/64AotACqELp9s4evdf85K6m9pKz+IqVhmrUuvd7PJZoUTibBRFQAiFP8fs7yu2cDWi/lnmPsZ1atuziZotJWhvxH7YVYMhPNKryPxwJSKqQ+NXGmaf/aOPvUUPJZvpThlJTm9XtoIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfz7oAPofQ/rHVemRJHOMfINViImT+w65DltNiIdx+M=;
 b=j/RWaiSW+R0WKjSJaAbZU1AlWcuDzQTJuDacFxbajZ0xJrleibW4UsqNONZgziAMA2epeRBC1U25WuxAaYUQHKkTyia5UQc9Aqz8UYXPlq0JS3+0svEaghVw/tpNlZJRjOYWN7CdDNeuE5rIoERnSlsElexJNhybtrdWghTYfRI=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 10:13:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 10:13:02 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Slivka, Danijel" <Danijel.Slivka@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Slivka, Danijel" <Danijel.Slivka@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Ignore initial value in smu response register
Thread-Topic: [PATCH] drm/amd/pm: Ignore initial value in smu response register
Thread-Index: AQHa0Q07eSOYq6+hCEyqClqLU3JWYLHsmR7w
Date: Mon, 8 Jul 2024 10:13:02 +0000
Message-ID: <DS0PR12MB78048A942EF3DC3BCA019D5C97DA2@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20240708080654.31640-1-danijel.slivka@amd.com>
In-Reply-To: <20240708080654.31640-1-danijel.slivka@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=4ef577ef-2586-43c6-8422-8217190d077e;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-08T10:00:18Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SA1PR12MB6798:EE_
x-ms-office365-filtering-correlation-id: 69527116-b0ad-4de2-3d03-08dc9f368d1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?baQCuvkfQDAMzPr6Nx3MHjDGPwO5QqL+PdeBYw6GIhwdaJXVj1id5+xbp7DK?=
 =?us-ascii?Q?LmJMeTVqt6O7e+QTCbm66YBytxWIxsu9avdBToCKE17MQfn9pGHSCwjp9kL4?=
 =?us-ascii?Q?sLfhtvPcFjM+6g/JZsZNk+opLgEMpnnGSLa5q1Q/X4SttsJFoOC2KBuOqGgS?=
 =?us-ascii?Q?yfK4zQK6REnGV9uFouIAdoK11O6xJuMzFStH5iA/j/Tdimwh8LdfSEr1Dy3M?=
 =?us-ascii?Q?Xqo73nMJSOg4TQtO5WiyXWcPpDsdEqmg5wJBpusu0/meYty9rvMcQzWlz0tK?=
 =?us-ascii?Q?divOU+0Om9VbwriHDzFm+Nx3aqRTZQLkZSWa9neKs+rNKEWoFLqKU6Letm5Q?=
 =?us-ascii?Q?plvGTycyL6KKzxaNjGXhk6L+M95/EKD+bjpqLyO0g+xNBHxsTlEleR56M7Aa?=
 =?us-ascii?Q?UAIxvTlomxJR82RuFvoyeUlt9O99QgZERCArEV9aEvr43yMoU1NsZOfFbVx+?=
 =?us-ascii?Q?ghnUAnbTyfTFHr0tv+nDugNQNu5cmY5+UvuYNd99N6cBv7szY/RNBDmbWELl?=
 =?us-ascii?Q?xYjfjgl3+yBKn0gDH17O3sBlH8f59fh0MDy1EQlFMYdwDrU6vAw6RvzvYp9c?=
 =?us-ascii?Q?sRA+x9uGSMJFlixKFPIySfgdmJgKikYU02kP4I+k4xDg3doyy1zCssjZ6ZSR?=
 =?us-ascii?Q?3ecJtS0ATodLRpXwCffojQNFmySH1ibUI8IemiljwkKgHwq72Bnw9lo+GNJu?=
 =?us-ascii?Q?qPvfFnUKU7xvDTATP4OR9zB6H1EBTuK/Yf/7GQKTM2luL6IjMhurjhcN5N6d?=
 =?us-ascii?Q?gGVCnx3ffkTA5RIAZTnu/H7+kZ7wubc5Qy07q/8cdieN1ZVuh64qttZbsYre?=
 =?us-ascii?Q?X76z7lJ/0na8JAoO7z6R84K5s0btjv+NzyZy7L/Cu0n372eGMPukS1QvVb65?=
 =?us-ascii?Q?gIjdQGw4OsUhBejdLNPbxCbR86/GANJWq9/U5fQQaJ8h3aCKEP//W2vL1H04?=
 =?us-ascii?Q?cjQZa1oEF/tvVJHn9IJtVOYgreIVNFZvb/CUfnwbxLh8owxfAW2MX9zQNRuI?=
 =?us-ascii?Q?lozK4UkTAGeM8+RkOzdLDlQ207+QyWqJCahnuXMsJ/Wh6MOn7LXXtH4G/wN9?=
 =?us-ascii?Q?e6Z9lZUELuUROWsRuye5WF1XVRHFYMloM+Ore/2Le3PHt/6/Ht3r3Z2WV6ra?=
 =?us-ascii?Q?jHzhJtq236xZrKp9eUHue2KN9cGg7JR2Qrz8Bfd8tiKydMOgFOXJf+BPQ5A1?=
 =?us-ascii?Q?lew8lsMVeZ+8tCcPZlX5CpKvA4Qji3lT8E2k0ktLnGfdE9XcdRZu13GQlYjD?=
 =?us-ascii?Q?g5dJz7141EcmJ/xNNp05WjSSiWDb1nHc0XfzFGjSUxScolJTkn69HHW17f1y?=
 =?us-ascii?Q?1h7wXQtKXir/8hcuMLe0J3RffyU6LrOWBNxrIU/iv7ZX7ZJoKWkBS8Bmei7K?=
 =?us-ascii?Q?7q5v6OQvB5Q1MJvfhrBarQau4Ox8U0s3Cis/Y7q9L1nfUqmm2Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k0jmFXkaHRqz3QXTxy9HVNmRoGbj24A5TvSEmK9tB+7fNzE3fgEl7k4OfX6N?=
 =?us-ascii?Q?x7W5RQv6HkclMJDYTpVV5LBkVH4pAoN5YsyPHWoQuDcZhp7zx+cxX8O/3cAx?=
 =?us-ascii?Q?3WuYx/3NSKCYc7DkmvHRnOtRKqAIqU9COY1YLaGB1gGzACehh6o5PTUOpT/h?=
 =?us-ascii?Q?1QfzZ/uuD61mUKZu9bK7dSvzsgGKYmetFh9pfA8GN6yGdZVuZQuiMQxTArBM?=
 =?us-ascii?Q?NKO9qFACED8TysQmO4q5GmL/+gbMT1AeWbnYPJdBpMtSS83L58fo5rP8dwiB?=
 =?us-ascii?Q?h36al5ADfb/4Bkjt8Sora1C02ZvA7qJ9a/7NA2We966ZwkdFp6bid5t505B8?=
 =?us-ascii?Q?hSiyhOk3pTDuO5VuFIAiRBL4lL7Z6jNcA4WF1EliQWhirwjYFKgNva7+iAWd?=
 =?us-ascii?Q?pnxNNLTCeNoGO6Qcra4I2N0B3CKjQXe1oxnvA2krNW1/rlWPhAMiQq9zw/O3?=
 =?us-ascii?Q?0faOibDvLJde/n11AQ0yzIv7kD4I1YKzaYud/3K/fRAbQOl9TuVnJ6aj2pIv?=
 =?us-ascii?Q?RitKcVaAsSBKwp4wpTH3CYHCU/ZVtn5AZ58wt/5cYk0pUwdTv4GUoUZf/mf6?=
 =?us-ascii?Q?B934vpbf3OJA/hoIx0d67mvJRtK8E1mDiRkxo6kkSbkKs6+ADVkuMJMqH/ft?=
 =?us-ascii?Q?58AuUkO7NkH/TJlM9Elveo2edyhHW5CGtoHxtBPfXeZNctErvxL18NW5i7IA?=
 =?us-ascii?Q?eS7k9CkYFKh9/h4O8StgbXl/m4S/bTvlPe0P07zuiSkLAbENJdtfJ4g+rlaF?=
 =?us-ascii?Q?xSh05y7XQVjsoxuJasRxc2Vix6VaXvgLblxoFkCwm5O7R1Po6P5Zw9B/FqOH?=
 =?us-ascii?Q?JeJ1fWVon2CJJt2HEpWBpo/2jd+vWJLTVjfkfPzTXZau49Vy9JcJouKdJ4tb?=
 =?us-ascii?Q?wq0QooHrHKxIEEupUMNXgGCdLq3nnbVScD9tBW5NnzO3fgykPXF7c8wUb5Ux?=
 =?us-ascii?Q?AN4LWmjjxQBBnJ90wND4MczprATG+22gw61BA6syPabSalhujOB1RteKJsIr?=
 =?us-ascii?Q?ymCLNAAOyBCV2YCdZ69Yb+lQ92SCZAnWLFkl2Ol4Fl6h9ajq/PnoTORhlM59?=
 =?us-ascii?Q?r3sGeOmXT9VLHOZ56ASPs4ts7fLRSiNdEK/8crOosI7RPW2xQcORi2FvFwpy?=
 =?us-ascii?Q?4Cho1NLL1U0MUuFgGW3wJXR+J52r6h4LJ0IlaJoXmvmHKzJI1c4kzVXtSp/x?=
 =?us-ascii?Q?Rcxl39fP3z1SE6MMavhGrplm0oNcbsUJ9loZB5WK80IHHgJC2dbatiRq59YB?=
 =?us-ascii?Q?hE3PTnzWQ4slQ+VU0zosrpFtQlN1vqESsn2mufsxIoxOtoVEpZt5fzWQ39C1?=
 =?us-ascii?Q?HT8TClhKA66u/v99vthCQDP89GS1qpOPuF2OFD44mvVqHGcBujEMSygV13sS?=
 =?us-ascii?Q?M3SS/sN/sVUYLx/rtukZ2Dg88DRoaTk0+9bomeTd9p5xrsX6SJDFteZl+fd+?=
 =?us-ascii?Q?35VYbjNA7K7EmmMHgRc8qSGpjQ9MRqKKYuukoC+/5soaZxBRIQIoa4ZClrOO?=
 =?us-ascii?Q?QmZ9fSPrMc6rMzflwPBsPcaMkGevQMxFG/seluKMwxo7RL8Z2fKH03pBQ/jj?=
 =?us-ascii?Q?PX7g/WOQw4Pc6wlLQ2k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69527116-b0ad-4de2-3d03-08dc9f368d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 10:13:02.3862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZBlwLgq7veL/H5AW38EP7IZetgzDkn+TIfg9qD8oMkDZJVzpXfDoa54fAhkxuwz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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

One problem is it's also bypassing a valid 0 response which usually means F=
W may not have completed processing the previous message.

What I thought was is it shouldn't even attempt sending a message if it ide=
ntified a FW hang.

Is there a possibility to have the same problem whenever there is SRIOV ful=
l access - as in before/after reset etc.?

If state =3D=3D FW_INIT, ignore response state before sending the message.
If there is no expected response to a message, make the state to FW_HANG. T=
his part is tricky as what qualifies as a FW hang could change based on the=
 specific SOC's message. Avoiding bool for this reason; to keep it open for=
 having other FW states.
If state =3D=3D FW_HANG don't even attempt to send the message.

Move FW state to FW_INIT whenever there is init/resume sequence - hw_init/h=
w_resume?

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Danijel =
Slivka
Sent: Monday, July 8, 2024 1:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Slivka, Danijel <Danijel.Slivka@amd.com>
Subject: [PATCH] drm/amd/pm: Ignore initial value in smu response register

Why:
If the reg mmMP1_SMN_C2PMSG_90 is being written to during amdgpu driver loa=
d or driver unload, subsequent amdgpu driver load will fail at smu_hw_init.=
 The default of mmMP1_SMN_C2PMSG_90 register at a clean environment is 0x1 =
and if value differs from expected, amdgpu driver load will fail.

How to fix:
Ignore the initial value in smu response register before the first smu mess=
age is sent, proceed further to send the message. If register holds
0x0 or an unexpected value after smu message was sent set fw_state_hang fla=
g and no further smu messages will be sent.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index a34c802f52be..bfe08fa0db6d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -562,6 +562,7 @@ struct smu_context {
        uint32_t smc_fw_if_version;
        uint32_t smc_fw_version;
        uint32_t smc_fw_caps;
+       bool smc_fw_state_hang;

        bool uploading_custom_pp_table;
        bool dc_controlled_by_gpio;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 5592fd825aa3..9e4e62dcbee7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -421,7 +421,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context =
*smu,
        if (poll) {
                reg =3D __smu_cmn_poll_stat(smu);
                res =3D __smu_cmn_reg2errno(smu, reg);
-               if (reg =3D=3D SMU_RESP_NONE || res =3D=3D -EREMOTEIO) {
+               if ((reg =3D=3D SMU_RESP_NONE || res =3D=3D -EREMOTEIO) &&
+smu->smc_fw_state_hang) {
                        __smu_cmn_reg_print_error(smu, reg, index, param, m=
sg);
                        goto Out;
                }
@@ -429,8 +429,11 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context=
 *smu,
        __smu_cmn_send_msg(smu, (uint16_t) index, param);
        reg =3D __smu_cmn_poll_stat(smu);
        res =3D __smu_cmn_reg2errno(smu, reg);
-       if (res !=3D 0)
+       if (res !=3D 0) {
+               if (reg =3D=3D SMU_RESP_NONE || res =3D=3D -EREMOTEIO)
+                       smu->smc_fw_state_hang =3D true;
                __smu_cmn_reg_print_error(smu, reg, index, param, msg);
+       }
        if (read_arg) {
                smu_cmn_read_arg(smu, read_arg);
                dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x,=
 resp: 0x%08x,\
--
2.34.1

