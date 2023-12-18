Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075EBC35274
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Dec 2023 18:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786F310E29E;
	Mon, 18 Dec 2023 18:28:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C7410E29E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 18:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJrev96BhpHvLLQ0HOQWN2c0dRa/qFloPGhobori8nOcPWbaowgna/5N2TjqECvVwOUgzvXEr5k7YHB/PK51x8rcaMqKE2E9XPjGofVaRvRnvku/pCJU8546f2nJFV3mhx26Jz+1FQftaCYRXuk6a78dH8YHmZU1mkzue5STgmjHJ1hRJs30iEVDaKzSigWdpu168GR6joPv0Wc83q0LMT/Sh/hTURrJnaZhYZiNAuWu+VGu8j2/ZkxjzbZxh8IpT1rRlJR4gCcnibi0L5iR/R6D+kzvaks9APmTU2BMRu4c92zXeY+GIghc4OhNmyhnLIdnqPj3xLkzh4XLHo609g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzjNpaWn7v7cOVkpRCdvP7MBsuI6pJrekYEbLo2/Ki0=;
 b=Lrq2FlJs8FmXRE3IRmuf7eAyWQGzurn4CbxfkEzP6xFfX8lmlT9MNDWGvqNt/i3dccOWTObFKrZlf+xWwbN7Rw0gZ9xxuRpZ8TIB5Fq60aOxlHebmUO00pAJvKe4s43YVn8KbVlGJJNC3OcRiidP1pV8WK+h2o9r5ey3jXYsw0i1V0FyCwR6lau3SsXRalA151vC/k463rOxhNUqrF3VROwaRKdGIRjoSpye+nAwPciOpGiukxdn7q29mQMe6E3EXxSuU8eCkpw1wkGW2Cx6V/CwBqzTHWg2MCR5IxylW2YxT/PgQdwTbfgInw6RpMLNqhF9lf1PqcuW1DYEUeksLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzjNpaWn7v7cOVkpRCdvP7MBsuI6pJrekYEbLo2/Ki0=;
 b=B1mfzkS3WqLPwvsL4A37CFG68oiyvBp+X/x3rokYzvV0ujq3KsensU5GY1gRT8SJVPTSOTON8OAVImSxXFy9aA1c0PluoLOYIS0vDumYm4Wf4TSsuIQZ0eDpbW9w5eIEx/Nnjxs0NRQUGvQsqqtoGkvHQUQhpeZaFSYdlY72IF4=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4cc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 09:30:10 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::7092:c19b:bd71:3b0c]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::7092:c19b:bd71:3b0c%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 09:30:10 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable unpaired
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable
 unpaired
Thread-Index: AQHaL3bNMVaSv6swNUS7uM8CuTxRhLCuoaUAgAAhQZA=
Date: Mon, 18 Dec 2023 09:30:10 +0000
Message-ID: <PH7PR12MB798809C2517604E5CADE7D889A90A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20231215164952.449464-1-Stanley.Yang@amd.com>
 <BN9PR12MB525719E4C88CFB696CEC22BDFC90A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525719E4C88CFB696CEC22BDFC90A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fda94616-97d2-4cd6-b9ee-05b1d8b817e4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-18T07:02:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|SJ2PR12MB7917:EE_
x-ms-office365-filtering-correlation-id: 821622b3-67f6-4dd6-dd98-08dbffabee2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vzAnBzNH68AYUtTPNltmc1y+5TX2qZv7FeTFWTJiDMh7VUZsRC+fV4saVFOQ0edLEhyY16tB+EGDV9pSC5cfDfCykpTttf6E+gvst7tGfgoifjTaUemb9r+SXeRzM643l4PReK/l0XX3zDFUUzK0MLOKnkxa5Ntuu4B7jm97qm+VJXMo3H7eaM9c4ZE9Tabp1MO9I7I0wSOPbLHSUXaPF3Dz70FvTs8JCcDxcu2vTcV9ONxPOvHRnzBwXC+JjkcAMkeehx8QM+/o4SRoguJwp+ZWiP68sQeLW2fN4FGguedZjfjW9mJzN5UBiEVoabN3g5Ze7nOuTQ4aySLUS+3UHjSjM4DU/rd6BNShqEHbZ/Wn7Tfe69Uxnwb2iHu5lRt2rY4Xdwu3vQL3ztx8DpZ8yAgCX3MMcRgs9PF4blkUCfbrJVlqWp6HBLQ7pxMwluEVD22bFl/3ZbVApElSAG1aS+bGFQcOHOKGybYbINVTc/7b0AdMHt6Yjpoxt5Z5CfyxmlgVvXS0Z7Pe/5Iq5Upzw4gOWbfLc1ZVsS0etnDlCo6MI+uHX+GqYRNh0bkJg1CCk/2q76OI+agekOZy7cwq+XhkT9iqSbctfRkeXyUe3UqxgKxUv804eOgXqHO0mV7JWu906WxNqLsICRvufx4qZukqY5+39DeFWatWIFBrc/c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38070700009)(55016003)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(38100700002)(122000001)(33656002)(86362001)(83380400001)(26005)(9686003)(53546011)(6506007)(7696005)(2906002)(316002)(8676002)(8936002)(110136005)(71200400001)(478600001)(5660300002)(41300700001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w+IRrgPfWeu7Mg/l1MfhONt7+R9h34gQucIN8Gm0/XIW1LTSmDl3aIbXcRml?=
 =?us-ascii?Q?P/c38gRbwTxTjxKH63vVkZpLwch1ZewQyKEKqTviCTT4bjfi9sOwdWffPb4X?=
 =?us-ascii?Q?KOz8Bc/GP7lEfUcp7GhTfEICXwv6Ao4eAlbChLdTqv8GXnaXIYCATjNftuXW?=
 =?us-ascii?Q?sW754KhLqzXrXk1q99ggrI6lS1TGc28IdYOycXeSlYmWYFZaRZ/ivjhWuv9p?=
 =?us-ascii?Q?gcu7fG5lwZKwDGiVUfqLhAajnPSzovh69fN3/vCoZhJU8BpzWPrjGVAc7+qX?=
 =?us-ascii?Q?OeM3N0rII+kEAgmNHJ0nYgoqqSWmMxoEe5OphHLoCswKTrhhr5RPg2K1Q89o?=
 =?us-ascii?Q?Tlk6CbQFfGbxj7ZU/77+l5zK6jVh4UXOaDtWHDbmtUFcIOhJ9o6NHFzbM31k?=
 =?us-ascii?Q?ZDTYEpV1T25pW+2koARG0FFjDDkPwkijOz0wgkFezGKK7UCZMLWMezCpdIWB?=
 =?us-ascii?Q?h9/btdyxqqcHxZJfOF6MFgO0biX957FS0SXP92lwfY1sECgq2tqumTH8+rHp?=
 =?us-ascii?Q?cSqdoYsOmMmUHaml1YIsK6/VFIByGUZuizmYtUpSLJ1dJyoHFpRWHjBA8GRV?=
 =?us-ascii?Q?JyM/7CfjIiPeZ8T/q6D8DVprqJ4w4R6+Du/fQNFYclGT3pmsPqdY9UmDXtco?=
 =?us-ascii?Q?00iYsYNIIhcD7nVq1r13bSniTOG4gfTOE4aScKm2hLKJfE2c2oXjhYC9KKIp?=
 =?us-ascii?Q?u3iZL5pNYpqpSXS2wAz3TMn8LXRjiQaINWgnz1ewnHQhP+KvSqa1G1TJhe+E?=
 =?us-ascii?Q?v8K9hidp221Di+tJV1l6mcR/sknrXP3ToJlGS5622JSzqD4KHKsAyjrNE7Ac?=
 =?us-ascii?Q?bMnSXtGLBj4t3f8pK+1yErt/ne5ukCJpji0ThO2hgTh6ZI27K6Pc6UzQdL04?=
 =?us-ascii?Q?KcDJ6vfloFyGyQS60yW9rxUfuR7fPGDXy29Pe2ynvynfjaYWBxmjIfHz/uMx?=
 =?us-ascii?Q?p9ePItzjgbMZIWw+l2GRBro8j2WoDKR8yht26nL1DVrge90EUzGZiNEeC9Vg?=
 =?us-ascii?Q?t2++C7l3/FBFHDtnOJ2y033e6TMlXF8TgG9e3+uBVSlXrI2dGMfueCzLDp7p?=
 =?us-ascii?Q?O4u+zGl/ILsdjjYyliPC61uVLcZfjmNPGcbKm/2NHq1zqKht1pcCbYu+flmq?=
 =?us-ascii?Q?+Cm9dXBiWClPfB5lZHNPJ4/6xZKO/rpqG+UlxcHdro0auQw9RXu73OTUFM0O?=
 =?us-ascii?Q?KA4x9i+VCiznRzfr55iBD6NmlC7v3p4nMR9KarHJk5TiqOLQwVNtpMLM8b9m?=
 =?us-ascii?Q?k9ja5xGccUxf61nXTM3Y9uamIhJU+Hqy4rWZy8mK8NMjcgOnqQKhG804l+3A?=
 =?us-ascii?Q?Qvrjm6thHW6+cu1jgBJmm4H1hItKwbAiWzfv8GbOBmIXMnbqV5csQPb6An75?=
 =?us-ascii?Q?FBUyQRNAeZ+qWGp7zuExaN+hbCP/bXczY06u1GnHJz5Rh1Xe3+BXOU60/vwO?=
 =?us-ascii?Q?W3DqVo+sdiPrTM5neBcr0fsSLPL+7Hxz4ROPFnGs1dTSAX8cYhDitrjkVEXM?=
 =?us-ascii?Q?R2cN2nqAg19bWtK0DS+O8pAjzixRu8iv0FgWSClZFCpbl6aCxCYvEl3Mba2j?=
 =?us-ascii?Q?KDn9Thf9NYk09rYQeas=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821622b3-67f6-4dd6-dd98-08dbffabee2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 09:30:10.3050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQgqYvB812LBQXOamcqwB+P1zh0RILb9zdqjqZ8+cY488d618x1VMLGDCB9aqgEx93ZG10xH1WDndP8xvudjjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
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

[AMD Official Use Only - General]

For mode2 reset, only call SDMA/GFX suspend to disable SDMA/GFX ecc_irq, dr=
iver just need enable SDMA/GFX ecc_irq during resume process.
Think about below scenario on aqua vanjaram, user modprobe amdgpu with rese=
t_method=3D3, driver will do GPU recovery if the SDMA uncorrectable error i=
s triggered,
It's difficult to distinguish whether need resume gmc ecc_irq, nbio ras_con=
troller_irq, nbio ras_err_event_athub_irq since driver do full gpu reset.

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, December 18, 2023 3:03 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable
> unpaired
>
> [AMD Official Use Only - General]
>
> Can we put the irq resume in amdgpu_ras_resume?
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Saturday, December 16, 2023 00:50
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable unpair=
ed
>
> The ecc_irq is disabled while GPU mode2 reset suspending process, but not=
 be
> enabled during GPU mode2 reset resume process.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c  |  6 ++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37
> +++++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
> drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 ++
> drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  4 +++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  3 ++
>  6 files changed, 54 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index 02f4c6f9d4f6..ba9238a93064 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -358,6 +358,12 @@ aldebaran_mode2_restore_hwcontext(struct
> amdgpu_reset_control *reset_ctl,
>                 /* Resume RAS */
>                 amdgpu_ras_resume(tmp_adev);
>
> +               r =3D amdgpu_ras_late_resume(tmp_adev);
> +               if (r) {
> +                       dev_err(tmp_adev->dev, "amdgpu_ras_late_resume
> failed %d\n", r);
> +                       goto end;
> +               }
> +
>                 /* Update PSP FW topology after reset */
>                 if (reset_context->hive &&
>                     tmp_adev->gmc.xgmi.num_physical_nodes > 1) diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8a04fb6c7c1f..318e77c493f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3164,6 +3164,43 @@ int amdgpu_ras_late_init(struct amdgpu_device
> *adev)
>         return 0;
>  }
>
> +/* Handle mode 2 reset, resume ecc irq state */ int
> +amdgpu_ras_late_resume(struct amdgpu_device *adev) {
> +       struct amdgpu_ras_block_list *node, *tmp;
> +       struct amdgpu_ras_block_object *obj;
> +       int r;
> +
> +       /* Guest side doesn't need init ras feature */
> +       if (amdgpu_sriov_vf(adev))
> +               return 0;
> +
> +       list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
> +               if (!node->ras_obj) {
> +                       dev_warn(adev->dev, "Warning: abnormal ras list n=
ode.\n");
> +                       continue;
> +               }
> +
> +               obj =3D node->ras_obj;
> +
> +               if (!(obj->ras_comm.block =3D=3D AMDGPU_RAS_BLOCK__SDMA |=
|
> +                         obj->ras_comm.block =3D=3D AMDGPU_RAS_BLOCK__GF=
X))
> +                       continue;
> +
> +               if (obj->ras_late_init) {
> +                       r =3D obj->ras_late_init(adev, &obj->ras_comm);
> +                       if (r) {
> +                               dev_err(adev->dev, "%s failed to execute =
ras_late_init!
> ret:%d\n",
> +                                       obj->ras_comm.name, r);
> +                               return r;
> +                       }
> +               } else
> +                       amdgpu_ras_block_late_init_default(adev, &obj->ra=
s_comm);
> +       }
> +
> +       return 0;
> +}
> +
>  /* do some fini work before IP fini as dependence */  int
> amdgpu_ras_pre_fini(struct amdgpu_device *adev)  { diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 6a941eb8fb8f..5c1ffc5a6899 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -693,6 +693,7 @@ amdgpu_ras_error_to_ta(enum
> amdgpu_ras_error_type error) {
>  /* called in ip_init and ip_fini */
>  int amdgpu_ras_init(struct amdgpu_device *adev);  int
> amdgpu_ras_late_init(struct amdgpu_device *adev);
> +int amdgpu_ras_late_resume(struct amdgpu_device *adev);
>  int amdgpu_ras_fini(struct amdgpu_device *adev);  int
> amdgpu_ras_pre_fini(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 09cbca596bb5..b93a0baeb2d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1043,6 +1043,9 @@ static int gmc_v10_0_hw_fini(void *handle)
>
>         amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>
> +       if (adev->gmc.ecc_irq.funcs)
> +               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 416f3e4f0438..e633e60850b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -941,6 +941,10 @@ static int gmc_v11_0_hw_fini(void *handle)
>         }
>
>         amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> +
> +       if (adev->gmc.ecc_irq.funcs)
> +               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>         gmc_v11_0_gart_disable(adev);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 205db28a9803..8ac4d5b7fb37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2388,6 +2388,9 @@ static int gmc_v9_0_hw_fini(void *handle)
>
>         amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>
> +       if (adev->gmc.ecc_irq.funcs)
> +               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>         return 0;
>  }
>
> --
> 2.25.1
>

