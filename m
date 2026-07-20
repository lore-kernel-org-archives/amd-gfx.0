Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0766CC44520
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 17:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E73B10E9DD;
	Mon, 20 Jul 2026 17:28:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l5JYLhGA";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4B110E9DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 17:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=as33zaKuiXItk25/xqAHgAEvF+EDNjoPJJq16jaCrfXyxhCFcTPF6kA+xoGbpd/XsVGy6wfqIyRL7xQpaURq31o7Zxu+PXpdLvEmUIc31T4n2mFWOi5y3b07G3IXZISuNvnoTiyGSWPsggP0b1WVfqhFABE7Ls8RuACoSBtcDTV3AFln7xMb3OjZrxXpATSoH9GyCe1fMNERvCd4pdAIKcfS7946t5ThTB/ZSiNbKeVSJdOAUFjGEGAfHsSzcTVryyRNIUlt4Yljx4RT4um8l5rjaOnOWSp2bTFbuEwt1MDk6nh6AneSUmps3nMT28cCpB78hJ/sKNHwUQm9gflBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga7kjd2NShChguP2OyutJswHzZjMh8REQj3VMHJWg5k=;
 b=GuIA+ZJWEFktLOJgMUvo9creB5cE/4Z+gPGtg3fQ9KbipvY89Yk9bxpdOLL9j6oRG6mBiLpohT6zgQH5VKtSZiSTMSpYGdn+XIuU8p3zdsaqvrrl9OX9ed3WwL27gMefr+XEqTX14OiUkGwXgU+9QK58O1XiJYCe7c9YdpIpWDrk2Zd2T9VYUXIbHOXFvhwt9uHMsDvWstuJ9MLe4Q5v2eGhExWQWPDfNJUVi5FZzC0cfbWkyRHrnZR+zCoVIZ4N543AmqZ9Npo1yTpVZrG9RnCEfhZJdEUzEUEYvMYThkW6mm+E7Pkb1uslWhW3GT8HG5IJ27TnPN8HEf6b4BWs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga7kjd2NShChguP2OyutJswHzZjMh8REQj3VMHJWg5k=;
 b=l5JYLhGA49blj/iKJPMp2cDz7lr/+BMA2o+tXoahp4f618T3y41IolUMtoq2Pfo3bPjUgUMNM2HjcqG8AMHdl6Z3+TiKaX08JNin1fq9tu96sKfB8+LebaR1UESZ2GSzqR8Uq7UqbazFIMAdw3IefRRS8tTGqwfhCoePfqmbOjo=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 17:28:44 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 17:28:44 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Ba, Gang" <Gang.Ba@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix missing authorization check in
 KFD_IOC_DBG_TRAP_DISABLE
Thread-Topic: [PATCH] drm/amdkfd: Fix missing authorization check in
 KFD_IOC_DBG_TRAP_DISABLE
Thread-Index: AQHdGFzYlb1xj9cu9UC2EkbjP5s2pLZ2qaOQ
Date: Mon, 20 Jul 2026 17:28:43 +0000
Message-ID: <BL1PR12MB58984ED153E63A5C8C68BB9385C32@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260720153112.53712-1-Gang.Ba@amd.com>
In-Reply-To: <20260720153112.53712-1-Gang.Ba@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-20T17:28:30.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|IA0PR12MB7697:EE_
x-ms-office365-filtering-correlation-id: 22fcbbc8-4c02-43ea-3c1d-08dee6845939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: Sz5AAyIO+ZAP8FloWYzU56QNxKv6tY+EOK70t1XGjGe3sHUI719ia8WiPBXE5yw/w3n62lh7OdtBMTClMQWH9VdFpQ+HmE3N54GC/0wCUCXfh5Os1DAYCtKDA54iYEMnZpohQzrG7RauhB/cvC9t86L5Cu2gx6dRQG4MvLkiO/dHyxBo1NCcT+xWPUcXLXmbRqQ7QE7++TLkgaFueGu3WNqBbY1EUCjO/Kibzuj8DmKh0nyXFxpTn+vu9aB9P+QGVv0tSzE9klzt7vMmqeA5EZPR9jih+sj5w3aWf1JK1ZHmKaI2q1LjgRH+WxNUQSliuHHnsebj12tPN+rIe195dsb5hqwpB7Od2wnI2BWdAAVSHbQpYuwFXvrge2HStB+IggId8F178vesEhWCGRPIetSYIP6gUIBttC4sgYMh0Kd4O6wQBoxHRrUUPsFbWMN7KjWOE9zSq1O8buWcaG9G4jkC02EtJ88ENUkLkkhXtfKuWOvLE+r2y3rpqpkzYReD1c0Ajx8kWqV+bk+WxFM/XS4uBGDpb2/QLyAuocRCF9J9A8TU5go47ZwGvahJeza0ghWdxrKFYfeZ0dzukhMRad1on3QCcV5px7RxUlfGVrklqOUE33svilOm74RtCbXMvjlTVY7sPmNkMIMppwtD2qrLV2+Tq70i1gWGjxhTfHMGyBQr5MEGwebX6qeptlOwecpWpuG4LuvSgDUC0OpkmQq7K55bghJeHhU1v84X7dk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QJrQposPZ8PPj68uWHg5vNV4pCOwXe8vmrSrGQtKffxjjxWVbxLpnBEPHgN+?=
 =?us-ascii?Q?mzOPvjET3Q02SZOUrprnzmFJmxNkadNgZ4EEocW1UrQwdvGi07tVI7aWflQh?=
 =?us-ascii?Q?IWTdJ7s5xB+Bojmm9d+siNgHy1obSXTSSfOKCLu3pmvDAyJAi7aWSN4+T0ZD?=
 =?us-ascii?Q?m1OHnMgMEEVt3sZPzEMXyLKqBKzv09uwhl2OApwX9CtpWfKjEluCXTwxZzTl?=
 =?us-ascii?Q?ferDg6MIgbppxZ7knRR8w2y+Xi3n8E8WxcN0fHJ8+JjGGwRO/mN1Nh7Qql7L?=
 =?us-ascii?Q?fs+m6JLOPemDk/kLBAylVaVo/SWi/l7L/Uu//Z3PkBPld7iAdp2Li/P2uv8M?=
 =?us-ascii?Q?lhE9y9WH8LJG03Lz3nQNFPkWJYMOWRjrsdMhrJYG/kBSawrxYxZ5wq1OB6i0?=
 =?us-ascii?Q?0fGozfWIaRUBQkzLAJhnpIINlsRSEABGdVYSMuygwD7426zdljFE+m7Bb+jn?=
 =?us-ascii?Q?Xqfyqsg9Bp5WzggnhBAShG6qX9ObxE0GTSzsWA3leLS+S6ka48mnVN2KNEH7?=
 =?us-ascii?Q?4Pfh8j1+DPmvnC868/+xCGmdYD2eA4lYtUEadcJ+mVHkWhHx24lnQNLNa2hO?=
 =?us-ascii?Q?uy2LYAVKTAeQp8CWWc4jP/ukSGQwBJu5JGoAhyun1mCj34ZV8m3AgfosSOei?=
 =?us-ascii?Q?Q5OKvFvTFvJS5apOOdrTtsamiMsBNlZ32jpDjVDILxGyvw9C9tHw4mFc1yRX?=
 =?us-ascii?Q?q1n/fq2bmSF9EDjq8vXN1KcjpEkG28nUUY2LZeTkarCBe5C6wpE7Rs2C1aHS?=
 =?us-ascii?Q?lWFa4YfkTLmkPEeiMMdD/y+oHWFn0vlxSea2q8RwQVp9lWLt3kNQXYPzP2yU?=
 =?us-ascii?Q?bdLHd0eXHOmc9tWuWSgVrYH0YoIczoldw9shzo92gNZDdNSSiw82C+D0E615?=
 =?us-ascii?Q?uBSno53P4GUeaekxnmrdV/l82zdFgqXwgQnL1O11eecSKADyst6hq7XcyxZM?=
 =?us-ascii?Q?pKHD8xExltMIoNKnNGm+1RTA7XUNAtMV1TLyYtsmlce9v2KUuK/V+/WMuGPg?=
 =?us-ascii?Q?12U6PzOtdHzFpOv86xZKCp/jqMElUJv6dMx7dxQGFbxNu8nwa9LyMpHjiuDX?=
 =?us-ascii?Q?CZFoHpEAKXRTmWkSp9w2UXb6s27oIJbyw+0VZgSX/Rc3ejsiE2rQn0ijSvDa?=
 =?us-ascii?Q?dm9RETVGbtcxfmhr9svizb3A8XDNF7Ph2RbOkXfhA81OFgB2BdDBw9Pw1G/1?=
 =?us-ascii?Q?FYe7wMcikAwkfSD9t4xZKdxQBdGXfcNd/5Pflyeo5y5OT4dIXaETYUE6TSyN?=
 =?us-ascii?Q?oGwno2Vuy4HhqBFqDhgqRJxgL2jfiLwOnuuUNIiQ2oQYm2T178vEI1tRWO7q?=
 =?us-ascii?Q?Y3kHQkv4AKv545FQa0qW+RbGQtQJk7hOgzj5qcubAtgCRG0Jw8Xb4uVtbTaV?=
 =?us-ascii?Q?g8Rwwfb6Y4JIUuYwD+wVeYOhUL2Tj0c0YdsD2QHT/HwZplUloXbz+8yGi4W8?=
 =?us-ascii?Q?gmGdnGAS539b1WCqAVii3n/anIDWR3sQKyVCsk+9fwows1PHNJ4k8EQF0Dr0?=
 =?us-ascii?Q?ROhymC+hlE7buf5W4Bj08sPNRFSiRqcoqGgGGYW+bhZcaa7zVT6FSjbSiDZt?=
 =?us-ascii?Q?0Cded2ykZYTNMQiePgwKd1pWslu+nkfCUics78YrzMldOkFYqcFAYNOA/okH?=
 =?us-ascii?Q?zENGHT8NqiQRoJQIfPzGF3ke8i40+WKgy0xTkWLfKYnlscx9D2EEjle6ywgF?=
 =?us-ascii?Q?5S0ASuRM2C7dtvdToCvyxQLG7y7uu43Okr+QAG59Sgr4D4it?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fcbbc8-4c02-43ea-3c1d-08dee6845939
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 17:28:44.0154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veJBHbfXiTAkRtZKi+s+Kjsd+WtXQq9qfWGrn1KXQQU/UIL1m7+lxmKPWb65KjEq5wAP5bGH+zBj07ALlwNo0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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

AMD General

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gang B=
a
> Sent: July 20, 2026 11:31 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: --cc=3DKent.Russell@amd.com
> Subject: [PATCH] drm/amdkfd: Fix missing authorization check in
> KFD_IOC_DBG_TRAP_DISABLE
>
> Prevent unauthorized termination of active GPU debug sessions.
> Previously, users with /dev/kfd access could terminate another process's
> debug session without proper ownership or ptrace authorization.
>
> Signed-off-by: Gang Ba <Gang.Ba@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 7d058d93e219..05dd0b6a87f0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3112,10 +3112,14 @@ static int kfd_ioctl_set_debug_trap(struct file *=
filep,
> struct kfd_process *p, v
>               goto out;
>       }
>
> -     /* Check if target is still PTRACED. */
> +     /*
> +      * Verify debugger has permission to debug target process.
> +      * For cross-process debugging, require active ptrace relationship.
> +      * This applies to ALL operations to prevent unauthorized interfere=
nce.
> +      */
>       rcu_read_lock();
> -     if (target !=3D p && args->op !=3D KFD_IOC_DBG_TRAP_DISABLE
> -                             && ptrace_parent(target->lead_thread) !=3D
> current) {
> +     if (target !=3D p && ptrace_parent(target->lead_thread) !=3D curren=
t
> +                     && target->debugger_process !=3D p) {
>               pr_err("PID %i is not PTRACED and cannot be debugged\n", ar=
gs-
> >pid);
>               r =3D -EPERM;
>       }
> --
> 2.54.0

