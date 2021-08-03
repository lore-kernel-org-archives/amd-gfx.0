Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44C7C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 06:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4F960EBB
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 06:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A4F960EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22EB889F27;
	Tue,  3 Aug 2021 06:28:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4749489F27
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 06:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdJz1N1nighY83yU/kugco3eHPxlSZL8thVnC2OOdSQqu9S3cV/Vv8Ae81BpgM7xh72lxL54XLJZES1OMGFdspqO4NcQ/e6AYAy388NO8bwxr1Tk6cQEGCODchgMifME5vOwYtM28RnvHb5CA7SPC0xxpKY8QYNgJ9xxGMX5YuZJ0HvxCEH9b9sDlZudBHqlnTugZ1WcPYNIiEkXZuqM5Vrg0Gn15ecKWcVN4wDg85yfOvL3/loOYb/eN16zAahewdYJdAr/LUVupnaSpo974GtT6sHZjOWdFtUdINwUmngrexS2CqmRCevLU7GDa0pNbpbhdmTOqAMzA9WYmgdPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JA1W2kyMT35XxMUTHZFtFMe0zz3tbukzQt/8LI7eAM=;
 b=NfdU3BORNRUDzbRJc3ezvBbtiA13qpiRKw0UxQgFBeIAbILGucAhPy5tuL891UX+flqTAknjlPZOnSoVglkJyzjazfi1E0JH9gqLzQRfqniMEb6y20WTu7PSIowCKFTDQfyeIdwGaVBRuQ3eApJHHoiUXttWrJOIUhApkoUs1h7j+NbsUpNkNYavCdB2MrA2oZ8cvUrg1sw3rwLlHDpr4JdNWNMIMzw4+TeVQIc6i0Dfzvo0faUanGoolBs085uSbDBG/NgWQUKJOi4X74SbjVTpF1Tjfv0zGGTvJciZz5HFpz5U8wnVbI3V1IfbKqmxR8UbIN4W33984oa/NeDq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JA1W2kyMT35XxMUTHZFtFMe0zz3tbukzQt/8LI7eAM=;
 b=hyvEwINSyieWgF75h2mtzS2TPDtacpmA9To5VvkFzbubvbygF7w/f2hP3OcTkS4NFuJmojpjnp7JL4Td0oNR7p2UztPv29SIkQOKYRSwFxzDcmbTfDE9JydHjHVns1uGI5ATx9TduyhAW4E7c6S3mTyIzomesbvs5Gl0R7g3Jf4=
Received: from DM6PR12MB4649.namprd12.prod.outlook.com (2603:10b6:5:1d1::32)
 by DM5PR1201MB0251.namprd12.prod.outlook.com (2603:10b6:4:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 06:28:11 +0000
Received: from DM6PR12MB4649.namprd12.prod.outlook.com
 ([fe80::31bf:2432:585a:be9a]) by DM6PR12MB4649.namprd12.prod.outlook.com
 ([fe80::31bf:2432:585a:be9a%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 06:28:11 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: remove redundant host to psp cmd buf
Thread-Topic: [PATCH] drm/amd/amdgpu: remove redundant host to psp cmd buf
Thread-Index: AdeIE69In8ALCgfnTcG4u06LTYuZEAAGWyEAAACCh7A=
Date: Tue, 3 Aug 2021 06:28:11 +0000
Message-ID: <DM6PR12MB46494CC8F9A5F049654D0B6991F09@DM6PR12MB4649.namprd12.prod.outlook.com>
References: <DM6PR12MB46495DFBA7AA7E20614B7CC591F09@DM6PR12MB4649.namprd12.prod.outlook.com>
 <DM5PR12MB2469DA2FC7FE7576FBC0AB5CF1F09@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469DA2FC7FE7576FBC0AB5CF1F09@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Guchun.Chen@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-03T06:28:09Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e386c02f-6f25-46bb-ae05-b67ba6a456c9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ee40697-748f-4a8d-e552-08d95647de09
x-ms-traffictypediagnostic: DM5PR1201MB0251:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0251F736AC38F14446965C5C91F09@DM5PR1201MB0251.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9wQQKcOdoacIyGDERNJ1C4orn1v473wS9Lf1fKba0SfWu5pb8xm8HBt54Xj4gu62imsxiUPzPf7mXQ6cGuNQOoQNpExPxNf0wqdYBadp/t2MqSuMWbxPn2lqbEYXVkvmaKVsLzgbGaK7ZJu9uZQUEU7dRELoi0J8j3a4Oazv+q8eeYcM0r3VsuAbamOwtugl/P4Gkbv92j1+NqEbg4noDWxC5UqoVMmK3YWyzwvQJyGUiyDVrgBKoLkUd/u4v6DWtJOnjJCr0k0rBtpU6J9Tlb4S81UcEXy9+ACvcYvuNYtg2Nuse3rM6BENI6YYYHKPz1gGa765J7BOK87Q4qb1XGQRabD5URC2kICC6ccVpssTYYRMKUzn2Rq3pGzOA4+XyLQApg++CivOxtDdlWZ+lE7zOpnPRtvUDO4+MAqq2/qe4qkOa53IrdgGyo795kkcMtr1+SgSw9rY09BUkWOugo65GEG+CXNPumC+gpEK51EaKz9y/iEIWquvTFbegIpUy+kKwCviGBKf92xBkk9a6q1DLnz+TqzfO391XASW2GD96yhVsSWI+6gf4Y45fVIz2qLY73IZqUPffO1bNy8OMitfQ78E9Ee2HJz9FpxxSv7AFgI9kJet6MxIQbmg+S57uwCQQj+lfY2NTnGQkIyOfPNExgeDCV/jy/jitTnIR9DlARcixLtPJv5rUjAH9L/SeODj4Na7pB/STS9hu1zVFg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4649.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(7696005)(64756008)(30864003)(66946007)(66556008)(66476007)(316002)(8936002)(38070700005)(52536014)(76116006)(2906002)(66446008)(86362001)(6506007)(110136005)(53546011)(8676002)(33656002)(9686003)(55016002)(186003)(122000001)(83380400001)(4326008)(5660300002)(38100700002)(71200400001)(26005)(478600001)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kn09bbgunL7aTb7/yXYtV01N/oCg8TWb8a7h5TAYHrgU142kBVIroFKUko/8?=
 =?us-ascii?Q?w+FxONUOaxo4x1bgA19PT9th4hZ+Qp+9eI/Ab8wbIX601+4zY3Bf7+VFdrVm?=
 =?us-ascii?Q?YwjkVKJ/diQlnUshCOOqMLOCWRZ1ZyeYZdt9b7hik3oYKSphTlg3/CuhOvfB?=
 =?us-ascii?Q?gYYWz6N/TykeZ5cBo05FNhCg2ANzT4AV4nj3yK1NnzBuIn0hbzToMK3sxaAh?=
 =?us-ascii?Q?eBvUw574SXYRgzCsTvCRNdAOb4p7zxYbIrLho9zt/+xKhp2pGSgEysQ47wM3?=
 =?us-ascii?Q?/Jgdb0qi3DcmL4BdlHKsyyGlfT8DkC+ZcEW4vB2mg8U0pN+CC9udJ3Vc7m2L?=
 =?us-ascii?Q?+U27eZmlyxClfQsf9am/bffWvOsqwIZo/eE8N0KcdYVDxLCk9J4A62DWTU+o?=
 =?us-ascii?Q?QboVgFi/LR/SlGaoj9XAN6Y2cTwjVlg5Zs4PuE9t4x6yxpV9Vrw0jeJqmSh2?=
 =?us-ascii?Q?kADn24rVRCfaMiH0YY7mIMThOLibRf9GrPWQIy0PvdUTXi0piQ8JK6WSzys2?=
 =?us-ascii?Q?44gNDCLhBmdupgkHu8lGJTmosX5rWO6l0Tw20son3KAVFgOM0Qw+xf7I96G+?=
 =?us-ascii?Q?whCQgqnBQ8Zh5v8DGakcGc6WSuXmg+f3eAisiQU9yy2cqCGDNQAlxdi7S3eM?=
 =?us-ascii?Q?e3Cz80/n2eYvRzsQVs8v0cI8fkymHYI4jdbtYLwvD8DRt/T4ZPJyzEA2T2/n?=
 =?us-ascii?Q?fZkU8OSef4bXIYRez1228KT4eAB/GbvM+h3e7PDaQzEa4cWryFwD8+TEIa/0?=
 =?us-ascii?Q?C3adW1oDFHUt9b/rgRBsvg8InA8xbITjeXE4Wg1rVTUI4bo0L45zJg4zgabP?=
 =?us-ascii?Q?aE47g8WU61HRWaw2hfHs6GDH6IhOaPh1VgRbRmdun4SfDoh24uW744aY3Swo?=
 =?us-ascii?Q?6wPcWeHgMoMUZhkJ9ktlTMM9/ExlxNNs+TuSkqfkHwLIIHQW1cGuztFwLm0f?=
 =?us-ascii?Q?p9tKUUl8MhoaRti/2Z9b14v80EdhptlZYbqgsv4CBBnGfw/4KWsuJ2EqY4jY?=
 =?us-ascii?Q?ULwnuDgppDwXqVYSBXdCxW83JNr00wkUXYKHY14QjCWqZvF0dKCYUFaNCitM?=
 =?us-ascii?Q?8lDkU5PQdTRpR48dztJkLi8MXJp2nPud+pWjZ9AgP2IcVu0C4qPbk4FI0CYi?=
 =?us-ascii?Q?GCv/vzjcGV6O0hn8CbRuWNY9kr7++NDRim6c4RVyC5IE+Ox7BwK4QqEv+11J?=
 =?us-ascii?Q?1tajV5y96pP3L0arwFgc+vgK4F4i/YC9IBQ39m8Lhxr45LBY5e8UTUjxjuwb?=
 =?us-ascii?Q?eq0nXzY4OR25+QitxOViOv9SofpWWK5wQkQUziiEZb5lbEEswM5rnfEUL5xl?=
 =?us-ascii?Q?ryX9nfnMx7xiIT33tL4QpJXY?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB46494CC8F9A5F049654D0B6991F09DM6PR12MB4649namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4649.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee40697-748f-4a8d-e552-08d95647de09
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 06:28:11.5374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWu2RUHc3n/BjhTutuXRanml5LghKIb81f+9sqquLab9UPe+AstBhxE+Hm6m1RbU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0251
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

--_000_DM6PR12MB46494CC8F9A5F049654D0B6991F09DM6PR12MB4649namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Exactly, I forgot to change it accordingly. Thanks @Chen, Guchun<mailto:Guc=
hun.Chen@amd.com>



Thanks,
Candice

From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Tuesday, August 3, 2021 2:04 PM
To: Li, Candice <Candice.Li@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>; Li, Candice <Candice.Li@amd.com=
>
Subject: RE: [PATCH] drm/amd/amdgpu: remove redundant host to psp cmd buf


[Public]

+            if (psp->asd_fw) {
+                           release_firmware(psp->asd_fw);
                            adev->psp.asd_fw =3D NULL;
             }

Use "psp->asd_fw =3D NULL" should be more simple?

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Li, Candice
Sent: Tuesday, August 3, 2021 11:06 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>; L=
i, Candice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>
Subject: [PATCH] drm/amd/amdgpu: remove redundant host to psp cmd buf


[Public]

Signed-off-by: Candice Li candice.li@amd.com<mailto:candice.li@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 253 ++++++++----------------
1 file changed, 78 insertions(+), 175 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index ed731144ca7f..9c18558e3bc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -253,6 +253,12 @@ static int psp_sw_init(void *handle)
             struct psp_runtime_boot_cfg_entry boot_cfg_entry;
             struct psp_memory_training_context *mem_training_ctx =3D &psp-=
>mem_train_ctx;

+            psp->cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERN=
EL);
+            if (!psp->cmd) {
+                           DRM_ERROR("Failed to allocate memory to command=
 buffer!\n");
+                           ret =3D -ENOMEM;
+            }
+
             if (!amdgpu_sriov_vf(adev)) {
                            ret =3D psp_init_microcode(psp);
                            if (ret) {
@@ -315,25 +321,30 @@ static int psp_sw_init(void *handle)
static int psp_sw_fini(void *handle)
{
             struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+            struct psp_context *psp =3D &adev->psp;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

-             psp_memory_training_fini(&adev->psp);
-             if (adev->psp.sos_fw) {
-                           release_firmware(adev->psp.sos_fw);
-                           adev->psp.sos_fw =3D NULL;
+            psp_memory_training_fini(psp);
+            if (psp->sos_fw) {
+                           release_firmware(psp->sos_fw);
+                           psp->sos_fw =3D NULL;
             }
-             if (adev->psp.asd_fw) {
-                           release_firmware(adev->psp.asd_fw);
+            if (psp->asd_fw) {
+                           release_firmware(psp->asd_fw);
                            adev->psp.asd_fw =3D NULL;
             }
-             if (adev->psp.ta_fw) {
-                           release_firmware(adev->psp.ta_fw);
-                           adev->psp.ta_fw =3D NULL;
+            if (psp->ta_fw) {
+                           release_firmware(psp->ta_fw);
+                           psp->ta_fw =3D NULL;
             }

              if (adev->asic_type =3D=3D CHIP_NAVI10 ||
                 adev->asic_type =3D=3D CHIP_SIENNA_CICHLID)
                            psp_sysfs_fini(adev);

+            kfree(cmd);
+            cmd =3D NULL;
+
             return 0;
}

@@ -491,6 +502,8 @@ static void psp_prep_tmr_cmd_buf(struct psp_context *ps=
p,
             uint32_t size =3D amdgpu_bo_size(tmr_bo);
             uint64_t tmr_pa =3D amdgpu_gmc_vram_pa(adev, tmr_bo);

+            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
+
             if (amdgpu_sriov_vf(psp->adev))
                            cmd->cmd_id =3D GFX_CMD_ID_SETUP_VMR;
             else
@@ -506,6 +519,8 @@ static void psp_prep_tmr_cmd_buf(struct psp_context *ps=
p,
static void psp_prep_load_toc_cmd_buf(struct psp_gfx_cmd_resp *cmd,
                                                               uint64_t pri=
_buf_mc, uint32_t size)
{
+            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
+
             cmd->cmd_id =3D GFX_CMD_ID_LOAD_TOC;
             cmd->cmd.cmd_load_toc.toc_phy_addr_lo =3D lower_32_bits(pri_bu=
f_mc);
             cmd->cmd.cmd_load_toc.toc_phy_addr_hi =3D upper_32_bits(pri_bu=
f_mc);
@@ -517,11 +532,8 @@ static int psp_load_toc(struct psp_context *psp,
                                          uint32_t *tmr_size)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
             /* Copy toc to psp firmware private buffer */
             psp_copy_fw(psp, psp->toc.start_addr, psp->toc.size_bytes);

@@ -531,7 +543,7 @@ static int psp_load_toc(struct psp_context *psp,
                                                          psp->fence_buf_mc=
_addr);
             if (!ret)
                            *tmr_size =3D psp->cmd_buf_mem->resp.tmr_size;
-             kfree(cmd);
+
             return ret;
}

@@ -588,7 +600,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
static int psp_tmr_load(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              /* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TM=
R.
              * Already set up by host driver.
@@ -596,10 +608,6 @@ static int psp_tmr_load(struct psp_context *psp)
             if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
                            return 0;

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
-
             psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr, psp->tmr_bo);
             DRM_INFO("reserve 0x%lx from 0x%llx for PSP TMR\n",
                             amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr)=
;
@@ -607,14 +615,14 @@ static int psp_tmr_load(struct psp_context *psp)
             ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
                                                          psp->fence_buf_mc=
_addr);

-             kfree(cmd);
-
             return ret;
}

 static void psp_prep_tmr_unload_cmd_buf(struct psp_context *psp,
-                                                                       str=
uct psp_gfx_cmd_resp *cmd)
+                                                               struct psp_=
gfx_cmd_resp *cmd)
{
+            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
+
             if (amdgpu_sriov_vf(psp->adev))
                            cmd->cmd_id =3D GFX_CMD_ID_DESTROY_VMR;
             else
@@ -624,11 +632,7 @@ static void psp_prep_tmr_unload_cmd_buf(struct psp_con=
text *psp,
static int psp_tmr_unload(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
-
-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              psp_prep_tmr_unload_cmd_buf(psp, cmd);
             DRM_INFO("free PSP TMR buffer\n");
@@ -636,8 +640,6 @@ static int psp_tmr_unload(struct psp_context *psp)
             ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
                                                          psp->fence_buf_mc=
_addr);

-             kfree(cmd);
-
             return ret;
}

@@ -662,7 +664,9 @@ int psp_get_fw_attestation_records_addr(struct psp_cont=
ext *psp,
                                                                       uint=
64_t *output_ptr)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;
+
+            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));

              if (!output_ptr)
                            return -EINVAL;
@@ -670,10 +674,6 @@ int psp_get_fw_attestation_records_addr(struct psp_con=
text *psp,
             if (amdgpu_sriov_vf(psp->adev))
                            return 0;

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
-
             cmd->cmd_id =3D GFX_CMD_ID_GET_FW_ATTESTATION;

              ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
@@ -684,29 +684,26 @@ int psp_get_fw_attestation_records_addr(struct psp_co=
ntext *psp,
                                                ((uint64_t)cmd->resp.uresp.=
fwar_db_info.fwar_db_addr_hi << 32);
             }

-             kfree(cmd);
-
             return ret;
}

 static int psp_boot_config_get(struct amdgpu_device *adev, uint32_t *boot_=
cfg)
{
             struct psp_context *psp =3D &adev->psp;
-             struct psp_gfx_cmd_resp *cmd =3D psp->cmd;
             int ret;

+            memset(psp->cmd, 0, sizeof(struct psp_gfx_cmd_resp));
+
             if (amdgpu_sriov_vf(adev))
                            return 0;

-             memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
-
-             cmd->cmd_id =3D GFX_CMD_ID_BOOT_CFG;
-             cmd->cmd.boot_cfg.sub_cmd =3D BOOTCFG_CMD_GET;
+            psp->cmd->cmd_id =3D GFX_CMD_ID_BOOT_CFG;
+            psp->cmd->cmd.boot_cfg.sub_cmd =3D BOOTCFG_CMD_GET;

-             ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_=
addr);
+            ret =3D psp_cmd_submit_buf(psp, NULL, psp->cmd, psp->fence_buf=
_mc_addr);
             if (!ret) {
                            *boot_cfg =3D
-                                          (cmd->resp.uresp.boot_cfg.boot_c=
fg & BOOT_CONFIG_GECC) ? 1 : 0;
+                                         (psp->cmd->resp.uresp.boot_cfg.bo=
ot_cfg & BOOT_CONFIG_GECC) ? 1 : 0;
             }

              return ret;
@@ -715,19 +712,18 @@ static int psp_boot_config_get(struct amdgpu_device *=
adev, uint32_t *boot_cfg)
static int psp_boot_config_set(struct amdgpu_device *adev, uint32_t boot_cf=
g)
{
             struct psp_context *psp =3D &adev->psp;
-             struct psp_gfx_cmd_resp *cmd =3D psp->cmd;
+
+            memset(psp->cmd, 0, sizeof(struct psp_gfx_cmd_resp));

              if (amdgpu_sriov_vf(adev))
                            return 0;

-             memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
-
-             cmd->cmd_id =3D GFX_CMD_ID_BOOT_CFG;
-             cmd->cmd.boot_cfg.sub_cmd =3D BOOTCFG_CMD_SET;
-             cmd->cmd.boot_cfg.boot_config =3D boot_cfg;
-             cmd->cmd.boot_cfg.boot_config_valid =3D boot_cfg;
+            psp->cmd->cmd_id =3D GFX_CMD_ID_BOOT_CFG;
+            psp->cmd->cmd.boot_cfg.sub_cmd =3D BOOTCFG_CMD_SET;
+            psp->cmd->cmd.boot_cfg.boot_config =3D boot_cfg;
+            psp->cmd->cmd.boot_cfg.boot_config_valid =3D boot_cfg;

-             return psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_a=
ddr);
+            return psp_cmd_submit_buf(psp, NULL, psp->cmd, psp->fence_buf_=
mc_addr);
}

 static int psp_rl_load(struct amdgpu_device *adev)
@@ -735,14 +731,14 @@ static int psp_rl_load(struct amdgpu_device *adev)
             struct psp_context *psp =3D &adev->psp;
             struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

+            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
+
             if (!is_psp_fw_valid(psp->rl))
                            return 0;

              memset(psp->fw_pri_buf, 0, PSP_1_MEG);
             memcpy(psp->fw_pri_buf, psp->rl.start_addr, psp->rl.size_bytes=
);

-             memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
-
             cmd->cmd_id =3D GFX_CMD_ID_LOAD_IP_FW;
             cmd->cmd.cmd_load_ip_fw.fw_phy_addr_lo =3D lower_32_bits(psp->=
fw_pri_mc_addr);
             cmd->cmd.cmd_load_ip_fw.fw_phy_addr_hi =3D upper_32_bits(psp->=
fw_pri_mc_addr);
@@ -755,6 +751,8 @@ static int psp_rl_load(struct amdgpu_device *adev)
static void psp_prep_asd_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
                                                         uint64_t asd_mc, u=
int32_t size)
{
+            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
+
             cmd->cmd_id =3D GFX_CMD_ID_LOAD_ASD;
             cmd->cmd.cmd_load_ta.app_phy_addr_lo =3D lower_32_bits(asd_mc)=
;
             cmd->cmd.cmd_load_ta.app_phy_addr_hi =3D upper_32_bits(asd_mc)=
;
@@ -768,7 +766,7 @@ static void psp_prep_asd_load_cmd_buf(struct psp_gfx_cm=
d_resp *cmd,
static int psp_asd_load(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              /* If PSP version doesn't match ASD version, asd loading will=
 be failed.
              * add workaround to bypass it for sriov now.
@@ -777,10 +775,6 @@ static int psp_asd_load(struct psp_context *psp)
             if (amdgpu_sriov_vf(psp->adev) || !psp->asd_ucode_size)
                            return 0;

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
-
             psp_copy_fw(psp, psp->asd_start_addr, psp->asd_ucode_size);

              psp_prep_asd_load_cmd_buf(cmd, psp->fw_pri_mc_addr,
@@ -793,14 +787,14 @@ static int psp_asd_load(struct psp_context *psp)
                            psp->asd_context.session_id =3D cmd->resp.sessi=
on_id;
             }

-             kfree(cmd);
-
             return ret;
}

 static void psp_prep_ta_unload_cmd_buf(struct psp_gfx_cmd_resp *cmd,
                                                                uint32_t se=
ssion_id)
{
+            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
+
             cmd->cmd_id =3D GFX_CMD_ID_UNLOAD_TA;
             cmd->cmd.cmd_unload_ta.session_id =3D session_id;
}
@@ -808,7 +802,7 @@ static void psp_prep_ta_unload_cmd_buf(struct psp_gfx_c=
md_resp *cmd,
static int psp_asd_unload(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              if (amdgpu_sriov_vf(psp->adev))
                            return 0;
@@ -816,10 +810,6 @@ static int psp_asd_unload(struct psp_context *psp)
             if (!psp->asd_context.asd_initialized)
                            return 0;

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
-
             psp_prep_ta_unload_cmd_buf(cmd, psp->asd_context.session_id);

              ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
@@ -827,14 +817,14 @@ static int psp_asd_unload(struct psp_context *psp)
             if (!ret)
                            psp->asd_context.asd_initialized =3D false;

-             kfree(cmd);
-
             return ret;
}

 static void psp_prep_reg_prog_cmd_buf(struct psp_gfx_cmd_resp *cmd,
                            uint32_t id, uint32_t value)
{
+            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
+
             cmd->cmd_id =3D GFX_CMD_ID_PROG_REG;
             cmd->cmd.cmd_setup_reg_prog.reg_value =3D value;
             cmd->cmd.cmd_setup_reg_prog.reg_id =3D id;
@@ -843,22 +833,17 @@ static void psp_prep_reg_prog_cmd_buf(struct psp_gfx_=
cmd_resp *cmd,
int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
                            uint32_t value)
{
-             struct psp_gfx_cmd_resp *cmd =3D NULL;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;
             int ret =3D 0;

              if (reg >=3D PSP_REG_LAST)
                            return -EINVAL;

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
-
             psp_prep_reg_prog_cmd_buf(cmd, reg, value);
             ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_a=
ddr);
             if (ret)
                            DRM_ERROR("PSP failed to program reg id %d", re=
g);

-             kfree(cmd);
             return ret;
}

@@ -868,6 +853,8 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd=
_resp *cmd,
                                                              uint64_t ta_s=
hared_mc,
                                                              uint32_t ta_s=
hared_size)
{
+            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
+
             cmd->cmd_id                                               =3D =
GFX_CMD_ID_LOAD_TA;
             cmd->cmd.cmd_load_ta.app_phy_addr_lo          =3D lower_32_bit=
s(ta_bin_mc);
             cmd->cmd.cmd_load_ta.app_phy_addr_hi          =3D upper_32_bit=
s(ta_bin_mc);
@@ -899,6 +886,8 @@ static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_c=
md_resp *cmd,
                                                                uint32_t ta=
_cmd_id,
                                                                uint32_t se=
ssion_id)
{
+            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
+
             cmd->cmd_id                                               =3D =
GFX_CMD_ID_INVOKE_CMD;
             cmd->cmd.cmd_invoke_cmd.session_id =3D session_id;
             cmd->cmd.cmd_invoke_cmd.ta_cmd_id =3D ta_cmd_id;
@@ -909,35 +898,25 @@ static int psp_ta_invoke(struct psp_context *psp,
                              uint32_t session_id)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
-
-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              psp_prep_ta_invoke_cmd_buf(cmd, ta_cmd_id, session_id);

              ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
                                                          psp->fence_buf_mc=
_addr);

-             kfree(cmd);
-
             return ret;
}

 static int psp_xgmi_load(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              /*
              * TODO: bypass the loading in sriov for now
              */

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
-
             psp_copy_fw(psp, psp->ta_xgmi_start_addr, psp->ta_xgmi_ucode_s=
ize);

              psp_prep_ta_load_cmd_buf(cmd,
@@ -954,15 +933,13 @@ static int psp_xgmi_load(struct psp_context *psp)
                            psp->xgmi_context.session_id =3D cmd->resp.sess=
ion_id;
             }

-             kfree(cmd);
-
             return ret;
}

 static int psp_xgmi_unload(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;
             struct amdgpu_device *adev =3D psp->adev;

              /* XGMI TA unload currently is not supported on Arcturus/Alde=
baran A+A */
@@ -974,17 +951,11 @@ static int psp_xgmi_unload(struct psp_context *psp)
              * TODO: bypass the unloading in sriov for now
              */

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
-
             psp_prep_ta_unload_cmd_buf(cmd, psp->xgmi_context.session_id);

              ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
                                                          psp->fence_buf_mc=
_addr);

-             kfree(cmd);
-
             return ret;
}

@@ -1204,7 +1175,7 @@ static int psp_ras_init_shared_buf(struct psp_context=
 *psp)
static int psp_ras_load(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;
             struct ta_ras_shared_memory *ras_cmd;

              /*
@@ -1213,10 +1184,6 @@ static int psp_ras_load(struct psp_context *psp)
             if (amdgpu_sriov_vf(psp->adev))
                            return 0;

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
-
             psp_copy_fw(psp, psp->ta_ras_start_addr, psp->ta_ras_ucode_siz=
e);

              ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras.ras_share=
d_buf;
@@ -1247,15 +1214,13 @@ static int psp_ras_load(struct psp_context *psp)
             if (ret || ras_cmd->ras_status)
                            amdgpu_ras_fini(psp->adev);

-             kfree(cmd);
-
             return ret;
}

 static int psp_ras_unload(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              /*
              * TODO: bypass the unloading in sriov for now
@@ -1263,17 +1228,11 @@ static int psp_ras_unload(struct psp_context *psp)
             if (amdgpu_sriov_vf(psp->adev))
                            return 0;

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
-
             psp_prep_ta_unload_cmd_buf(cmd, psp->ras.session_id);

              ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
                                          psp->fence_buf_mc_addr);

-             kfree(cmd);
-
             return ret;
}

@@ -1514,7 +1473,7 @@ static int psp_hdcp_init_shared_buf(struct psp_contex=
t *psp)
static int psp_hdcp_load(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              /*
              * TODO: bypass the loading in sriov for now
@@ -1522,10 +1481,6 @@ static int psp_hdcp_load(struct psp_context *psp)
             if (amdgpu_sriov_vf(psp->adev))
                            return 0;

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
-
             psp_copy_fw(psp, psp->ta_hdcp_start_addr,
                                psp->ta_hdcp_ucode_size);

@@ -1543,8 +1498,6 @@ static int psp_hdcp_load(struct psp_context *psp)
                            mutex_init(&psp->hdcp_context.mutex);
             }

-             kfree(cmd);
-
             return ret;
}
static int psp_hdcp_initialize(struct psp_context *psp)
@@ -1579,7 +1532,7 @@ static int psp_hdcp_initialize(struct psp_context *ps=
p)
static int psp_hdcp_unload(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              /*
              * TODO: bypass the unloading in sriov for now
@@ -1587,16 +1540,10 @@ static int psp_hdcp_unload(struct psp_context *psp)
             if (amdgpu_sriov_vf(psp->adev))
                            return 0;

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
-
             psp_prep_ta_unload_cmd_buf(cmd, psp->hdcp_context.session_id);

              ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_=
addr);

-             kfree(cmd);
-
             return ret;
}

@@ -1665,7 +1612,7 @@ static int psp_dtm_init_shared_buf(struct psp_context=
 *psp)
static int psp_dtm_load(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              /*
              * TODO: bypass the loading in sriov for now
@@ -1673,10 +1620,6 @@ static int psp_dtm_load(struct psp_context *psp)
             if (amdgpu_sriov_vf(psp->adev))
                            return 0;

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
-
             psp_copy_fw(psp, psp->ta_dtm_start_addr, psp->ta_dtm_ucode_siz=
e);

              psp_prep_ta_load_cmd_buf(cmd,
@@ -1693,8 +1636,6 @@ static int psp_dtm_load(struct psp_context *psp)
                            mutex_init(&psp->dtm_context.mutex);
             }

-             kfree(cmd);
-
             return ret;
}

@@ -1730,7 +1671,7 @@ static int psp_dtm_initialize(struct psp_context *psp=
)
static int psp_dtm_unload(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              /*
              * TODO: bypass the unloading in sriov for now
@@ -1738,16 +1679,10 @@ static int psp_dtm_unload(struct psp_context *psp)
             if (amdgpu_sriov_vf(psp->adev))
                            return 0;

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
-
             psp_prep_ta_unload_cmd_buf(cmd, psp->dtm_context.session_id);

              ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_=
addr);

-             kfree(cmd);
-
             return ret;
}

@@ -1816,11 +1751,7 @@ static int psp_rap_init_shared_buf(struct psp_contex=
t *psp)
static int psp_rap_load(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
-
-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              psp_copy_fw(psp, psp->ta_rap_start_addr, psp->ta_rap_ucode_si=
ze);

@@ -1838,26 +1769,18 @@ static int psp_rap_load(struct psp_context *psp)
                            mutex_init(&psp->rap_context.mutex);
             }

-             kfree(cmd);
-
             return ret;
}

 static int psp_rap_unload(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
-
-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              psp_prep_ta_unload_cmd_buf(cmd, psp->rap_context.session_id);

              ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_=
addr);

-             kfree(cmd);
-
             return ret;
}

@@ -1982,11 +1905,7 @@ static int psp_securedisplay_init_shared_buf(struct =
psp_context *psp)
static int psp_securedisplay_load(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
-
-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              memset(psp->fw_pri_buf, 0, PSP_1_MEG);
             memcpy(psp->fw_pri_buf, psp->ta_securedisplay_start_addr, psp-=
>ta_securedisplay_ucode_size);
@@ -2007,25 +1926,18 @@ static int psp_securedisplay_load(struct psp_contex=
t *psp)
             mutex_init(&psp->securedisplay_context.mutex);

 failed:
-             kfree(cmd);
             return ret;
}

 static int psp_securedisplay_unload(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
-
-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

              psp_prep_ta_unload_cmd_buf(cmd, psp->securedisplay_context.se=
ssion_id);

              ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_=
addr);

-             kfree(cmd);
-
             return ret;
}

@@ -2552,10 +2464,6 @@ static int psp_load_fw(struct amdgpu_device *adev)
                            goto skip_memalloc;
             }

-             psp->cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KER=
NEL);
-             if (!psp->cmd)
-                           return -ENOMEM;
-
             if (amdgpu_sriov_vf(adev)) {
                            ret =3D amdgpu_bo_create_kernel(adev, PSP_1_MEG=
, PSP_1_MEG,
                                                                           =
          AMDGPU_GEM_DOMAIN_VRAM,
@@ -2709,9 +2617,6 @@ static int psp_hw_fini(void *handle)
             amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
                                                (void **)&psp->cmd_buf_mem)=
;

-             kfree(psp->cmd);
-             psp->cmd =3D NULL;
-
             return 0;
}

@@ -2875,17 +2780,15 @@ int psp_gpu_reset(struct amdgpu_device *adev)
int psp_rlc_autoload_start(struct psp_context *psp)
{
             int ret;
-             struct psp_gfx_cmd_resp *cmd;
+            struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

-             cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-             if (!cmd)
-                           return -ENOMEM;
+            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));

              cmd->cmd_id =3D GFX_CMD_ID_AUTOLOAD_RLC;

              ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
                                                          psp->fence_buf_mc=
_addr);
-             kfree(cmd);
+
             return ret;
}

--
2.17.1



Thanks,
Candice


--_000_DM6PR12MB46494CC8F9A5F049654D0B6991F09DM6PR12MB4649namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader23c54b6f, li.msipheader23c54b6f, div.msipheader23c54b6f
	{mso-style-name:msipheader23c54b6f;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Exactly, I forgot to change it accordingly. Thanks <=
a id=3D"OWAAMAD724D3237E5446080A2F7F3ECE2EF59" href=3D"mailto:Guchun.Chen@a=
md.com">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@Chen, Guchun</span></a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#44546A">Thanks,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#44546A">Candice<o:p></o:p></sp=
an></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt=
; <br>
<b>Sent:</b> Tuesday, August 3, 2021 2:04 PM<br>
<b>To:</b> Li, Candice &lt;Candice.Li@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
<b>Cc:</b> Clements, John &lt;John.Clements@amd.com&gt;; Li, Candice &lt;Ca=
ndice.Li@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/amdgpu: remove redundant host to psp cm=
d buf<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader23c54b6f" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (psp-&gt;asd_fw) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(psp-&gt;asd_fw);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.asd_fw =3D NULL;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Use &#8220;psp-&gt;asd_fw =3D NULL&#8221; should be =
more simple?<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Li, Candice<br>
<b>Sent:</b> Tuesday, August 3, 2021 11:06 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">John=
.Clements@amd.com</a>&gt;; Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd=
.com">Candice.Li@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: remove redundant host to psp cmd bu=
f<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Candice Li <a href=3D"mailto:candice.=
li@amd.com">
candice.li@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 253 ++++++=
++----------------<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 78 insertions(+), 175 deletions(-)<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<o:p></o:p></p>
<p class=3D"MsoNormal">index ed731144ca7f..9c18558e3bc0 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -253,6 +253,12 @@ static int psp_sw_init(void *ha=
ndle)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; struct psp_runtime_boot_cfg_entry boot_cfg_entry;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; struct psp_memory_training_context *mem_training_ctx =
=3D &amp;psp-&gt;mem_train_ctx;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; psp-&gt;cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GF=
P_KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!psp-&gt;cmd) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to allocate memory to=
 command buffer!\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_init_microcode(psp);<o:p></=
o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -315,25 +321,30 @@ static int psp_sw_init(void *h=
andle)<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_sw_fini(void *handle)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct amdgpu_device *=
)handle;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_context *psp =3D &amp;adev-&gt;psp;<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp_memory_training_fini(&amp;adev-&gt;psp);<o:p></o:=
p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;psp.sos_fw) {<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(adev-&gt;psp.sos_fw);<o:p><=
/o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.sos_fw =3D NULL;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; psp_memory_training_fini(psp);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (psp-&gt;sos_fw) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(psp-&gt;sos_fw);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;sos_fw =3D NULL;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;psp.asd_fw) {<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(adev-&gt;psp.asd_fw);<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (psp-&gt;asd_fw) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(psp-&gt;asd_fw);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.asd_fw =3D NULL;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;psp.ta_fw) {<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(adev-&gt;psp.ta_fw);<o:p></=
o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_fw =3D NULL;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (psp-&gt;ta_fw) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(psp-&gt;ta_fw);<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;ta_fw =3D NULL;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_NAVI10 ||<o:p=
></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;adev-&gt;asic_type =3D=3D CHIP=
_SIENNA_CICHLID)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_sysfs_fini(adev);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; cmd =3D NULL;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -491,6 +502,8 @@ static void psp_prep_tmr_cmd_buf=
(struct psp_context *psp,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; uint32_t size =3D amdgpu_bo_size(tmr_bo);<o:p></o:p></=
p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; uint64_t tmr_pa =3D amdgpu_gmc_vram_pa(adev, tmr_bo);<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_SETUP_VMR=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -506,6 +519,8 @@ static void psp_prep_tmr_cmd_buf=
(struct psp_context *psp,<o:p></o:p></p>
<p class=3D"MsoNormal">static void psp_prep_load_toc_cmd_buf(struct psp_gfx=
_cmd_resp *cmd,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;uint64_t pri_buf_mc, uint32_t size)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_LOAD_TOC;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_toc.toc_phy_addr_lo =3D lower_32_=
bits(pri_buf_mc);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_toc.toc_phy_addr_hi =3D upper_32_=
bits(pri_buf_mc);<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -517,11 +532,8 @@ static int psp_load_toc(struct =
psp_context *psp,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *tmr_size)<o:p></o:p>=
</p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; /* Copy toc to psp firmware private buffer */<o:p></o:=
p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; psp_copy_fw(psp, psp-&gt;toc.start_addr, psp-&gt;toc.s=
ize_bytes);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -531,7 +543,7 @@ static int psp_load_toc(struct p=
sp_context *psp,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;psp-&gt;f=
ence_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (!ret)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *tmr_size =3D psp-&gt;cmd_buf_mem-&gt;r=
esp.tmr_size;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -588,7 +600,7 @@ static bool psp_skip_tmr(struct =
psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_tmr_load(struct psp_context *psp)<o:p=
></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; /* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do =
not set up TMR.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;* Already set up by host driver.<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -596,10 +608,6 @@ static int psp_tmr_load(struct =
psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev) &amp;&amp; psp_skip_=
tmr(psp))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; psp_prep_tmr_cmd_buf(psp, cmd, psp-&gt;tmr_mc_addr, ps=
p-&gt;tmr_bo);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;reserve 0x%lx from 0x%llx for PSP TMR\n=
&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;amdgpu_bo_size(psp-&gt;tmr_bo), p=
sp-&gt;tmr_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -607,14 +615,14 @@ static int psp_tmr_load(struct=
 psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd,<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;psp-&gt;f=
ence_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;static void psp_prep_tmr_unload_cmd_buf(struct=
 psp_context *psp,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t psp_gfx_cmd_resp *cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_DESTROY_V=
MR;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -624,11 +632,7 @@ static void psp_prep_tmr_unload=
_cmd_buf(struct psp_context *psp,<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_tmr_unload(struct psp_context *psp)<o=
:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_tmr_unload_cmd_buf(psp, cmd);<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;free PSP TMR buffer\n&quot;);<o:p></o:p=
></p>
<p class=3D"MsoNormal">@@ -636,8 +640,6 @@ static int psp_tmr_unload(struct=
 psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd,<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;psp-&gt;f=
ence_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -662,7 +664,9 @@ int psp_get_fw_attestation_recor=
ds_addr(struct psp_context *psp,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64=
_t *output_ptr)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; if (!output_ptr)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -670,10 +674,6 @@ int psp_get_fw_attestation_reco=
rds_addr(struct psp_context *psp,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_GET_FW_ATTESTATION;<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">@@ -684,29 +684,26 @@ int psp_get_fw_attestation_rec=
ords_addr(struct psp_context *psp,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;((uint64_t)cmd-&gt;resp.uresp.fwar_db_info.fwar_db_addr_hi &lt;&lt; 3=
2);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;static int psp_boot_config_get(struct amdgpu_d=
evice *adev, uint32_t *boot_cfg)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; struct psp_context *psp =3D &amp;adev-&gt;psp;<o:p></o=
:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o=
:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(psp-&gt;cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:=
p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:p>=
</o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_BOOT_CFG;<o:p></o:p></p=
>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.boot_cfg.sub_cmd =3D BOOTCFG_CMD_GET;<o:p=
></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; psp-&gt;cmd-&gt;cmd_id =3D GFX_CMD_ID_BOOT_CFG;<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; psp-&gt;cmd-&gt;cmd.boot_cfg.sub_cmd =3D BOOTCFG_CMD_GET;<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp-&gt;fe=
nce_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, psp-&gt;cmd, psp-&gt;=
fence_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (!ret) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *boot_cfg =3D<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (cmd-&gt;resp.uresp.boot_cfg.=
boot_cfg &amp; BOOT_CONFIG_GECC) ? 1 : 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (psp-&gt;cmd-&gt;resp.uresp.boot_cf=
g.boot_cfg &amp; BOOT_CONFIG_GECC) ? 1 : 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -715,19 +712,18 @@ static int psp_boot_config_get=
(struct amdgpu_device *adev, uint32_t *boot_cfg)<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_boot_config_set(struct amdgpu_device =
*adev, uint32_t boot_cfg)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; struct psp_context *psp =3D &amp;adev-&gt;psp;<o:p></o=
:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(psp-&gt;cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:p>=
</o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_BOOT_CFG;<o:p></o:p></p=
>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.boot_cfg.sub_cmd =3D BOOTCFG_CMD_SET;<o:p=
></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.boot_cfg.boot_config =3D boot_cfg;<o:p></=
o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.boot_cfg.boot_config_valid =3D boot_cfg;<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; psp-&gt;cmd-&gt;cmd_id =3D GFX_CMD_ID_BOOT_CFG;<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; psp-&gt;cmd-&gt;cmd.boot_cfg.sub_cmd =3D BOOTCFG_CMD_SET;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; psp-&gt;cmd-&gt;cmd.boot_cfg.boot_config =3D boot_cfg;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; psp-&gt;cmd-&gt;cmd.boot_cfg.boot_config_valid =3D boot_cfg=
;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return psp_cmd_submit_buf(psp, NULL, cmd, psp-&gt;fen=
ce_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return psp_cmd_submit_buf(psp, NULL, psp-&gt;cmd, psp-&gt;f=
ence_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;static int psp_rl_load(struct amdgpu_device *a=
dev)<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -735,14 +731,14 @@ static int psp_rl_load(struct =
amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; struct psp_context *psp =3D &amp;adev-&gt;psp;<o:p></o=
:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (!is_psp_fw_valid(psp-&gt;rl))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; memset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);<o:p></=
o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; memcpy(psp-&gt;fw_pri_buf, psp-&gt;rl.start_addr, psp-=
&gt;rl.size_bytes);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:p>=
</o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_LOAD_IP_FW;<o:p></o:p></=
p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ip_fw.fw_phy_addr_lo =3D lower_32=
_bits(psp-&gt;fw_pri_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ip_fw.fw_phy_addr_hi =3D upper_32=
_bits(psp-&gt;fw_pri_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -755,6 +751,8 @@ static int psp_rl_load(struct am=
dgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">static void psp_prep_asd_load_cmd_buf(struct psp_gfx=
_cmd_resp *cmd,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t asd_mc=
, uint32_t size)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_LOAD_ASD;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.app_phy_addr_lo =3D lower_32_b=
its(asd_mc);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.app_phy_addr_hi =3D upper_32_b=
its(asd_mc);<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -768,7 +766,7 @@ static void psp_prep_asd_load_cm=
d_buf(struct psp_gfx_cmd_resp *cmd,<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_asd_load(struct psp_context *psp)<o:p=
></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; /* If PSP version doesn't match ASD version, asd=
 loading will be failed.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;* add workaround to bypass it for sriov now.<o:p=
></o:p></p>
<p class=3D"MsoNormal">@@ -777,10 +775,6 @@ static int psp_asd_load(struct =
psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev) || !psp-&gt;asd_ucod=
e_size)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; psp_copy_fw(psp, psp-&gt;asd_start_addr, psp-&gt;asd_u=
code_size);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_asd_load_cmd_buf(cmd, psp-&gt;fw_pri_mc=
_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -793,14 +787,14 @@ static int psp_asd_load(struct=
 psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;asd_context.session_id =3D cmd-=
&gt;resp.session_id;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;static void psp_prep_ta_unload_cmd_buf(struct =
psp_gfx_cmd_resp *cmd,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;uint32_t session_id)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_UNLOAD_TA;<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_unload_ta.session_id =3D session_id;<o=
:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -808,7 +802,7 @@ static void psp_prep_ta_unload_c=
md_buf(struct psp_gfx_cmd_resp *cmd,<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_asd_unload(struct psp_context *psp)<o=
:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev))<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -816,10 +810,6 @@ static int psp_asd_unload(struc=
t psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (!psp-&gt;asd_context.asd_initialized)<o:p></o:p></=
p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; psp_prep_ta_unload_cmd_buf(cmd, psp-&gt;asd_context.se=
ssion_id);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">@@ -827,14 +817,14 @@ static int psp_asd_unload(stru=
ct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (!ret)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;asd_context.asd_initialized =3D=
 false;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;static void psp_prep_reg_prog_cmd_buf(struct p=
sp_gfx_cmd_resp *cmd,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t id, uint32_t value)<o:p></o:p>=
</p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_PROG_REG;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_setup_reg_prog.reg_value =3D value;<o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_setup_reg_prog.reg_id =3D id;<o:p></o:=
p></p>
<p class=3D"MsoNormal">@@ -843,22 +833,17 @@ static void psp_prep_reg_prog_=
cmd_buf(struct psp_gfx_cmd_resp *cmd,<o:p></o:p></p>
<p class=3D"MsoNormal">int psp_reg_program(struct psp_context *psp, enum ps=
p_reg_prog_id reg,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D NULL;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; if (reg &gt;=3D PSP_REG_LAST)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; psp_prep_reg_prog_cmd_buf(cmd, reg, value);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp-&gt;fen=
ce_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PSP failed to program r=
eg id %d&quot;, reg);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -868,6 +853,8 @@ static void psp_prep_ta_load_cmd=
_buf(struct psp_gfx_cmd_resp *cmd,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;uint64_t ta_shared_mc,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;uint32_t ta_shared_size)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =3D GFX_CMD_ID_LOAD_TA;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.app_phy_addr_lo &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D lower_32_bits(ta_bin_mc);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.app_phy_addr_hi&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D upper_32_bits(ta_bin_mc);<o:p><=
/o:p></p>
<p class=3D"MsoNormal">@@ -899,6 +886,8 @@ static void psp_prep_ta_invoke_c=
md_buf(struct psp_gfx_cmd_resp *cmd,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;uint32_t ta_cmd_id,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;uint32_t session_id)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =3D GFX_CMD_ID_INVOKE_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_invoke_cmd.session_id =3D session_id;<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_invoke_cmd.ta_cmd_id =3D ta_cmd_id;<o:=
p></o:p></p>
<p class=3D"MsoNormal">@@ -909,35 +898,25 @@ static int psp_ta_invoke(struc=
t psp_context *psp,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;uint32_t session_id)<o:p></=
o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_ta_invoke_cmd_buf(cmd, ta_cmd_id, sessi=
on_id);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;psp-&gt;f=
ence_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;static int psp_xgmi_load(struct psp_context *p=
sp)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;* TODO: bypass the loading in sriov for now<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;*/<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; psp_copy_fw(psp, psp-&gt;ta_xgmi_start_addr, psp-&gt;t=
a_xgmi_ucode_size);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_ta_load_cmd_buf(cmd,<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -954,15 +933,13 @@ static int psp_xgmi_load(struc=
t psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;xgmi_context.session_id =3D cmd=
-&gt;resp.session_id;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;static int psp_xgmi_unload(struct psp_context =
*psp)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D psp-&gt;adev;<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; /* XGMI TA unload currently is not supported on =
Arcturus/Aldebaran A+A */<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -974,17 +951,11 @@ static int psp_xgmi_unload(str=
uct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;* TODO: bypass the unloading in sriov for now<o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;*/<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; psp_prep_ta_unload_cmd_buf(cmd, psp-&gt;xgmi_context.s=
ession_id);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;psp-&gt;f=
ence_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -1204,7 +1175,7 @@ static int psp_ras_init_shared=
_buf(struct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_ras_load(struct psp_context *psp)<o:p=
></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; struct ta_ras_shared_memory *ras_cmd;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1213,10 +1184,6 @@ static int psp_ras_load(struc=
t psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; psp_copy_fw(psp, psp-&gt;ta_ras_start_addr, psp-&gt;ta=
_ras_ucode_size);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ras_cmd =3D (struct ta_ras_shared_memory *)psp-&=
gt;ras.ras_shared_buf;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1247,15 +1214,13 @@ static int psp_ras_load(stru=
ct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (ret || ras_cmd-&gt;ras_status)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_fini(psp-&gt;adev);<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;static int psp_ras_unload(struct psp_context *=
psp)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;* TODO: bypass the unloading in sriov for now<o:=
p></o:p></p>
<p class=3D"MsoNormal">@@ -1263,17 +1228,11 @@ static int psp_ras_unload(st=
ruct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; psp_prep_ta_unload_cmd_buf(cmd, psp-&gt;ras.session_id=
);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;fence_buf_mc_addr);<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -1514,7 +1473,7 @@ static int psp_hdcp_init_share=
d_buf(struct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_hdcp_load(struct psp_context *psp)<o:=
p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;* TODO: bypass the loading in sriov for now<o:p>=
</o:p></p>
<p class=3D"MsoNormal">@@ -1522,10 +1481,6 @@ static int psp_hdcp_load(stru=
ct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; psp_copy_fw(psp, psp-&gt;ta_hdcp_start_addr,<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;psp-&gt;ta_hdcp=
_ucode_size);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -1543,8 +1498,6 @@ static int psp_hdcp_load(struc=
t psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;psp-&gt;hdcp_context.mu=
tex);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_hdcp_initialize(struct psp_context *p=
sp)<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1579,7 +1532,7 @@ static int psp_hdcp_initialize=
(struct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_hdcp_unload(struct psp_context *psp)<=
o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;* TODO: bypass the unloading in sriov for now<o:=
p></o:p></p>
<p class=3D"MsoNormal">@@ -1587,16 +1540,10 @@ static int psp_hdcp_unload(s=
truct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; psp_prep_ta_unload_cmd_buf(cmd, psp-&gt;hdcp_context.s=
ession_id);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp-&=
gt;fence_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -1665,7 +1612,7 @@ static int psp_dtm_init_shared=
_buf(struct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_dtm_load(struct psp_context *psp)<o:p=
></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;* TODO: bypass the loading in sriov for now<o:p>=
</o:p></p>
<p class=3D"MsoNormal">@@ -1673,10 +1620,6 @@ static int psp_dtm_load(struc=
t psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; psp_copy_fw(psp, psp-&gt;ta_dtm_start_addr, psp-&gt;ta=
_dtm_ucode_size);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_ta_load_cmd_buf(cmd,<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1693,8 +1636,6 @@ static int psp_dtm_load(struct=
 psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;psp-&gt;dtm_context.mut=
ex);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -1730,7 +1671,7 @@ static int psp_dtm_initialize(=
struct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_dtm_unload(struct psp_context *psp)<o=
:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;* TODO: bypass the unloading in sriov for now<o:=
p></o:p></p>
<p class=3D"MsoNormal">@@ -1738,16 +1679,10 @@ static int psp_dtm_unload(st=
ruct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; psp_prep_ta_unload_cmd_buf(cmd, psp-&gt;dtm_context.se=
ssion_id);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp-&=
gt;fence_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -1816,11 +1751,7 @@ static int psp_rap_init_share=
d_buf(struct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_rap_load(struct psp_context *psp)<o:p=
></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; psp_copy_fw(psp, psp-&gt;ta_rap_start_addr, psp-=
&gt;ta_rap_ucode_size);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -1838,26 +1769,18 @@ static int psp_rap_load(stru=
ct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;psp-&gt;rap_context.mut=
ex);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;static int psp_rap_unload(struct psp_context *=
psp)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_ta_unload_cmd_buf(cmd, psp-&gt;rap_cont=
ext.session_id);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp-&=
gt;fence_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -1982,11 +1905,7 @@ static int psp_securedisplay_=
init_shared_buf(struct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_securedisplay_load(struct psp_context=
 *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; memset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);<o:p></=
o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; memcpy(psp-&gt;fw_pri_buf, psp-&gt;ta_securedisplay_st=
art_addr, psp-&gt;ta_securedisplay_ucode_size);<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2007,25 +1926,18 @@ static int psp_securedisplay=
_load(struct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; mutex_init(&amp;psp-&gt;securedisplay_context.mutex);<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;failed:<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;static int psp_securedisplay_unload(struct psp=
_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_ta_unload_cmd_buf(cmd, psp-&gt;securedi=
splay_context.session_id);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp-&=
gt;fence_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -2552,10 +2464,6 @@ static int psp_load_fw(struct=
 amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto skip_memalloc;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_res=
p), GFP_KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(adev, P=
SP_1_MEG, PSP_1_MEG,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AM=
DGPU_GEM_DOMAIN_VRAM,<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2709,9 +2617,6 @@ static int psp_hw_fini(void *h=
andle)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;cmd_buf_bo, &amp;ps=
p-&gt;cmd_buf_mc_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;(void **)&amp;psp-&gt;cmd_buf_mem);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(psp-&gt;cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;cmd =3D NULL;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -2875,17 +2780,15 @@ int psp_gpu_reset(struct amd=
gpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">int psp_rlc_autoload_start(struct psp_context *psp)<=
o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_=
KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!cmd)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_AUTOLOAD_RLC;<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;psp-&gt;f=
ence_buf_mc_addr);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#44546A">Thanks,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#44546A">Candice<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB46494CC8F9A5F049654D0B6991F09DM6PR12MB4649namp_--
