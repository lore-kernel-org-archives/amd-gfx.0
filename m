Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A48CCDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 05:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6379C10E0AE;
	Thu, 19 Oct 2023 05:27:17 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB6F10E0AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 05:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFLV2kUkLQyOIzg3OABdvn1Jcfb5IYCc5b+sAp+pB+EruJKbYv87gnAAg5XB651hUWiisZhjgtSXUV+0EOKF9/GZqkWp4smeTDIeQmJ8RDDpm890+SevZLcKA+PbKqFcdB3J3XGhQq4Jq+r3BQwyph4GWj1k2ue2EMHA5fLl40sLjfxeSMsH1PwORdxSmwSnJ6xsCfW+6y5ijGu/rQYzI8T+K7UVJUFvF4j2KuPXB8I/tBK1oZzEEKaDknfUb6Ug2OuXS+H3jXoBemBZbNs1Hr1LodeTrfsYdR/BwyJNJqJvFDwPG/R64NI+4RZk1wNqwZNLpvd+vY32PsC/Q5h9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dM09l5AjP2fYCpiqwrQVus11GQDJ0t5NWMjSH5FRe7s=;
 b=L+IPYbNwYNNLh7D+2o3iDAuX54lOFB3rmLBBweYdpo9q0jgxQ5EMTsinpDborB1jjnmZDG7ZRv8+sCVAzaUr8ultJHvsi/B1Dhji534NMOOOlLo9YMZ0zC7UALTP1xhqbv0u/eDjQIP0OcPFAegTLbX+9pNDUQN3LnXC0N9VTfIqZ+dRTf72CDsLHuxOLCUJ7sYR0sceujIztz21EuFGahx4DtlOXwOxuxWt9/FrPHxUO8rkGFbzlNV0t88dlyNhMRcQmNY2StfHfTt7i8FmU9OABMlOD58xhZmtNLoEmS8pT2129DywfQQgW8zZBdRNB4etUC3xlJGMik6GPJmUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dM09l5AjP2fYCpiqwrQVus11GQDJ0t5NWMjSH5FRe7s=;
 b=i0Oqz4n/SvUjzDWyrTSGZJq2DapBv6JTQUCP6y6VNMqTiN3BwSw3cQKqSLvHO5s1rmjjJMPoGiaK+aFCF3E+hJ7uy6rLf4ueZHG5m0Jr+X12CXsO8MwRmmhnGQbDaqpgDT2BCgUZQoe0/fvnaghLmP7yJ1cc+v/5rrZdwGhSWN4=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 05:27:12 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%5]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 05:27:12 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix shift out-of-bounds issue and remove
 unused code.
Thread-Topic: [PATCH] drm/amdkfd: Fix shift out-of-bounds issue and remove
 unused code.
Thread-Index: AQHaAi9+UoXbzuBkfEuuQ6TnFxdDCLBQlEzg
Date: Thu, 19 Oct 2023 05:27:12 +0000
Message-ID: <CY5PR12MB63695D17ED893BCD120BAA83C1D4A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231019015609.299859-1-jesse.zhang@amd.com>
In-Reply-To: <20231019015609.299859-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b2444bce-9491-4efb-aa76-be625879fd74;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-19T05:23:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|MN0PR12MB5739:EE_
x-ms-office365-filtering-correlation-id: 370f4d52-cd2b-46ad-491c-08dbd0640c35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++r3X4jceuZ8cmVYWOCfgMdEVWzWEjQIMdUFRWhxnp0MYW0pRxWe53qCY8VAzZmrh3+1f3CkMzmfuaNX8fNhD5CEcQyLLvvGIZWlQ8PsUcunjRTjHR892rdx7IGuP+bsiziaL3ljx26qxUjxzSKtCn0aCDug3Z0bT4frBZXObbB2tJMnHMrnheKoPJyYwSQGuDJayFXsPjc4ceGa3Ag2dd47XBYbrz+GEJFdR3gIPXdcAG24WdFC5CbSqOH/JJHsCbhk0opyrfQQsipCOOUf6/3E0WKSHoWx7kFD7P7HHIR6niZYD/E4MjSIiwO3GCauWjScKrXh0KKETvBflm+Qx0vd8G7ax0mJlA7s4o16b/foPJE9N+kpn2ckyiB7GJCOcMXh8thEXDTg7x7rdxme0GocpDFkgnnRbZ5dHKUyhcnpmePMUpAH/qLoBwdvZdLvPdcsaGc8jk1s+IfmumdeIR2lDO261vfOJBEDcYniZrk7dprCNRQduh4OlzvFU9W4TDPby9Yp4CeNPEHu7+G3a3IHnbelywBiSGPZwuqwq8J8xRYlXgpAUkGvgb2BLBgspiyx95Lx6m3BI6MNDetQ2Uauhsllc8os8pCxdmOC6ntPbzRfO+RBnH8vrj6nJxrL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(55016003)(8936002)(38100700002)(52536014)(5660300002)(478600001)(76116006)(110136005)(8676002)(54906003)(86362001)(41300700001)(66946007)(2906002)(71200400001)(316002)(6506007)(38070700005)(7696005)(64756008)(66446008)(66476007)(66556008)(53546011)(9686003)(26005)(122000001)(4326008)(83380400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6k3kZGmpAZabI2ihQopcgm95gSm/gg/xg4liahWn0AdGPqEb/DcE4zA49rvW?=
 =?us-ascii?Q?OLAJD5WU4lfIXsSUyFkKxC2f7sWAl9wKqJoVkj+FEnIVLh8bZYUszJnP+4Ah?=
 =?us-ascii?Q?nuEm/zXBhh2ZNmSfLZtOvne4NKMsn7Jusns7un212Pmzqf1B7heAFxMyIUOH?=
 =?us-ascii?Q?jBrNmWPXT/T1C5/XcjnW2vCZzoEw/5PL8I032h2dO512raSBDTOcrtK8R9pm?=
 =?us-ascii?Q?PpazE31kwainlqiMH2+6F9sIURm4vnZlW5R5JYo4/TPV7LRenp5iro7ouY0h?=
 =?us-ascii?Q?1o2zVQ9mSPv4Jmv5JzJhZbMsCeZgdb5ax6hz5Q8QStvaq6PTp4ZpSkLgYSIw?=
 =?us-ascii?Q?KPJPlRPIUNBU7Kp6au3/xHZ4Mq0m08h2sc8qV+UraLGTMF1PcPqKH9Ddxozl?=
 =?us-ascii?Q?5y0QEOZiDiUTOOAIcaZvKwtSVgpJDbXFQzQwuvYCpfTjIL/ilxVtzfcIp5Xx?=
 =?us-ascii?Q?+Q9naBU7n+bdAkEL5WTngu/QNMa5V2Q90F4K6VSmhsB/TELWUaBtLtW+n+Lb?=
 =?us-ascii?Q?DU3+08r2K06z8s2o7rS3GWA9syH2Fundxz9ZJNuH043KvtY2f7EK0Jc8rr8r?=
 =?us-ascii?Q?8R48B8jUJU6dUCO8RtmQ6OyxjxRK4MyCCJgDynlDuuIVv/3Im3Fvv7I99rYX?=
 =?us-ascii?Q?YkJ5rr4KWpzet7rrn22+mst3BW8wKkleUpwE/UTaT5+Rv+eh+4k1M6vOYAaO?=
 =?us-ascii?Q?PY1TMhaswh/BRbEtfgYAKFzYnUDrW3ooM63O/D2FxlC9WU5ZUDHs/hAzKs2Q?=
 =?us-ascii?Q?Hky8akW8o+HpxPLnCQV6TumQF72fDsFzYOSebgs1K3gNHuadOgqMxxdsuq2b?=
 =?us-ascii?Q?Yb3ghEJN0V/VKENeDgX05yXjRc/RNiZEkNOMWw+mp6HrofFhFdKnsftiSED0?=
 =?us-ascii?Q?cyJOglCAzEMCzMqCRRFB90tg8aU6eZ0u5pWzOlH3dKTa3r9cfDlXL3pOBGOE?=
 =?us-ascii?Q?sZDl3xkSiW3DDN9SeuuF2rvQrxF8KCNbxeE+tHfP7JdSGOQHzp1nVIBI8M+1?=
 =?us-ascii?Q?sz/dqsAC1plEseZAmTMtv5qtyp6jcL+4WCuXwHnxQlwtH6Lf4wtGHbNuSfWP?=
 =?us-ascii?Q?aModOMNrMEP9KkKDZlYFORQN360tpR7Ya5zK7yd01uMFGu2AqDOASvz1Hkld?=
 =?us-ascii?Q?fAlFmuJn5PIzE/j5a0rm2zoHquStnTtl/SvqjKhJaoXXY2MqF+IIHtaMTQNX?=
 =?us-ascii?Q?ykjfrwX24zKxlEnOcElcFFQAYupKceKiM9Rx3dEFP0DK3H6YZ3Z/nHyAtAVR?=
 =?us-ascii?Q?/7NRh9ZkiuQRjxfPFEUqUYEXv1unfvVmXP/0Ywye+9ujcsf4Ebn40cOjYAAv?=
 =?us-ascii?Q?uKvIwUB3LMNjEwf6ScPWX+wyOpAEbLmUbkynycVo7tIbzkZPrkrPaKvsJ2yb?=
 =?us-ascii?Q?ovDvqRQCzWFUIeFHRUc0MB5abomY/4CJmrB7o9ZHIrcwECV8+mdjbpGhA7RF?=
 =?us-ascii?Q?8vyy6pM120Umu2ml3yKMKfZzx5CtJCRQuNGyxVbUcC3Xgnm0fJvtxDw9XUbG?=
 =?us-ascii?Q?M+ERezMEz0Mbrs4BPyO/peIaa6nUklL4MtCurbzyLlFosIudo7EPukTddXUN?=
 =?us-ascii?Q?IEqjEadKohvPRgvkVxo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370f4d52-cd2b-46ad-491c-08dbd0640c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 05:27:12.2655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsNNJ1POjNokI0NaDJbL7L22YHwUs6fnMlYFCqtAftwZSbCC4obB09ihKRp155Z9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

I think it is better to separate it to two patches since it addresses diffe=
rent issues. With or without the change, this patch is

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Jesse Zhang <jesse.zhang@amd.com>
Sent: Thursday, October 19, 2023 9:56 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1=
.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)=
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: Fix shift out-of-bounds issue and remove unuse=
d code.

[  567.613292] shift exponent 255 is too large for 64-bit type 'long unsign=
ed int'
[  567.614498] CPU: 5 PID: 238 Comm: kworker/5:1 Tainted: G           OE   =
   6.2.0-34-generic #34~22.04.1-Ubuntu
[  567.614502] Hardware name: AMD Splinter/Splinter-RPL, BIOS WS43927N_871 =
09/25/2023 [  567.614504] Workqueue: events send_exception_work_handler [am=
dgpu] [  567.614748] Call Trace:
[  567.614750]  <TASK>
[  567.614753]  dump_stack_lvl+0x48/0x70 [  567.614761]  dump_stack+0x10/0x=
20 [  567.614763]  __ubsan_handle_shift_out_of_bounds+0x156/0x310
[  567.614769]  ? srso_alias_return_thunk+0x5/0x7f [  567.614773]  ? update=
_sd_lb_stats.constprop.0+0xf2/0x3c0
[  567.614780]  svm_range_split_by_granularity.cold+0x2b/0x34 [amdgpu] [  5=
67.615047]  ? srso_alias_return_thunk+0x5/0x7f [  567.615052]  svm_migrate_=
to_ram+0x185/0x4d0 [amdgpu] [  567.615286]  do_swap_page+0x7b6/0xa30 [  567=
.615291]  ? srso_alias_return_thunk+0x5/0x7f [  567.615294]  ? __free_pages=
+0x119/0x130 [  567.615299]  handle_pte_fault+0x227/0x280 [  567.615303]  _=
_handle_mm_fault+0x3c0/0x720 [  567.615311]  handle_mm_fault+0x119/0x330 [ =
 567.615314]  ? lock_mm_and_find_vma+0x44/0x250 [  567.615318]  do_user_add=
r_fault+0x1a9/0x640 [  567.615323]  exc_page_fault+0x81/0x1b0 [  567.615328=
]  asm_exc_page_fault+0x27/0x30 [  567.615332] RIP: 0010:__get_user_8+0x1c/=
0x30

Suggested-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 62 +---------------------------  dr=
ivers/gpu/drm/amd/amdkfd/kfd_svm.h |  3 --
 2 files changed, 1 insertion(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 54af7a2b29f8..ccaf86a4c02a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -781,7 +781,7 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm=
_range *prange,
                        prange->flags &=3D ~attrs[i].value;
                        break;
                case KFD_IOCTL_SVM_ATTR_GRANULARITY:
-                       prange->granularity =3D attrs[i].value;
+                       prange->granularity =3D attrs[i].value & 0x3F;
                        break;
                default:
                        WARN_ONCE(1, "svm_range_check_attrs wasn't called?"=
); @@ -1139,66 +1139,6 @@ svm_range_add_child(struct svm_range *prange, str=
uct mm_struct *mm,
        list_add_tail(&pchild->child_list, &prange->child_list);  }

-/**
- * svm_range_split_by_granularity - collect ranges within granularity boun=
dary
- *
- * @p: the process with svms list
- * @mm: mm structure
- * @addr: the vm fault address in pages, to split the prange
- * @parent: parent range if prange is from child list
- * @prange: prange to split
- *
- * Trims @prange to be a single aligned block of prange->granularity if
- * possible. The head and tail are added to the child_list in @parent.
- *
- * Context: caller must hold mmap_read_lock and prange->lock
- *
- * Return:
- * 0 - OK, otherwise error code
- */
-int
-svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm=
,
-                              unsigned long addr, struct svm_range *parent=
,
-                              struct svm_range *prange)
-{
-       struct svm_range *head, *tail;
-       unsigned long start, last, size;
-       int r;
-
-       /* Align splited range start and size to granularity size, then a s=
ingle
-        * PTE will be used for whole range, this reduces the number of PTE
-        * updated and the L1 TLB space used for translation.
-        */
-       size =3D 1UL << prange->granularity;
-       start =3D ALIGN_DOWN(addr, size);
-       last =3D ALIGN(addr + 1, size) - 1;
-
-       pr_debug("svms 0x%p split [0x%lx 0x%lx] to [0x%lx 0x%lx] size 0x%lx=
\n",
-                prange->svms, prange->start, prange->last, start, last, si=
ze);
-
-       if (start > prange->start) {
-               r =3D svm_range_split(prange, start, prange->last, &head);
-               if (r)
-                       return r;
-               svm_range_add_child(parent, mm, head, SVM_OP_ADD_RANGE);
-       }
-
-       if (last < prange->last) {
-               r =3D svm_range_split(prange, prange->start, last, &tail);
-               if (r)
-                       return r;
-               svm_range_add_child(parent, mm, tail, SVM_OP_ADD_RANGE);
-       }
-
-       /* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
-       if (p->xnack_enabled && prange->work_item.op =3D=3D SVM_OP_ADD_RANG=
E) {
-               prange->work_item.op =3D SVM_OP_ADD_RANGE_AND_MAP;
-               pr_debug("change prange 0x%p [0x%lx 0x%lx] op %d\n",
-                        prange, prange->start, prange->last,
-                        SVM_OP_ADD_RANGE_AND_MAP);
-       }
-       return 0;
-}
 static bool
 svm_nodes_in_same_hive(struct kfd_node *node_a, struct kfd_node *node_b)  =
{ diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.h
index be11ba0c4289..026863a0abcd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -172,9 +172,6 @@ struct kfd_node *svm_range_get_node_by_id(struct svm_ra=
nge *prange,  int svm_range_vram_node_new(struct kfd_node *node, struct svm=
_range *prange,
                            bool clear);
 void svm_range_vram_node_free(struct svm_range *prange); -int svm_range_sp=
lit_by_granularity(struct kfd_process *p, struct mm_struct *mm,
-                              unsigned long addr, struct svm_range *parent=
,
-                              struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid=
,
                            uint32_t vmid, uint32_t node_id, uint64_t addr,
                            bool write_fault);
--
2.25.1

