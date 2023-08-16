Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB228C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 05:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C7410E2C5;
	Wed, 16 Aug 2023 05:38:07 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55AF110E2C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 05:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hi3b7PgSiw9bn+OjNRIv9/vOHQN6IjzezTifdswCfXywZbQN8pC0I43XqTk7WtdSrTb14+FvNY7gKuK1wT1cs7BmB+Yu+Mwzd74ZjdMRxkUpX5L6sRkVCvHgrvYKyyTx2jZ5kW8wtAJm1kGBOiQW3T4GE6QHdoSYBv48bj56M1wYisKlTybd+MYnNxKnukKEHuC7182LwVsUDtp6OEwZAlmkQC5ia3eZhK10MBY4ewVgDuE7BPMYE+gWh0Ht7S2SDcvPoDFNpNYwng/2+8x2N6dOHlXhWXGiVPomv/B7Ljs6vhhu3KPxjXqa5718L6ZTnSNdziYm3/So6odJEicsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuidZbzKeXajiTUQjubbMwKYhKpbm8eBJSiKuo5Zm30=;
 b=fbdd10e/Q+ndGxSIjNpiOc3oA9GwNFOh5fY+FSXObOltru5Vv4Vq2trd9l9nM9ktmBEgCpr7hgo2nOEfYNFcjtr1JLEeFBlwCHZwXuko/ks9geOXcjpTBSorM5q0TJrKPAJ5fMDwoCgs8AqYpCyjNvgASKierEYbYZVdWufXi7E0UYTmiA+x+zJRW7AqJwmYP65bG09xEOB/cCnmWymVtNLbN4EeeBZTB8EpBB1uI4KlCQNI+lLgET6RjBpLvAhP8t9jtJh3NGuArJFIb5iUvs9fx71E626hagtv3JpzggcY22VGsCFDBAHlKft0Wv8O3o1LvnHPkyGl3GrbIDrw8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuidZbzKeXajiTUQjubbMwKYhKpbm8eBJSiKuo5Zm30=;
 b=4pFEUP4IZ7iMZezWgtDrsokXRJOujEJ6TlL+CUyv0pgOdd9++Zw0wj5PpKp3ZNWxc5qwNEHrVa+Pkawljg8XAqawD/jn9UV2rQUK2MdW9tnLLDxO17S+GFGqmiOu7rsE4XUFv6n0sUJ/tqUygJErpXP3mpWPPeOECXgKMktxwmw=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 05:38:02 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 05:38:01 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Keep reset handlers shared
Thread-Topic: [PATCH] drm/amdgpu: Keep reset handlers shared
Thread-Index: AQHZy4AYknBllX5s3U2nkohEeJBaOq/scI+Q
Date: Wed, 16 Aug 2023 05:38:01 +0000
Message-ID: <BYAPR12MB4614C6590B454B912A0E5EFC9715A@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230810114425.645209-1-lijo.lazar@amd.com>
In-Reply-To: <20230810114425.645209-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0c1d767d-2bf0-41ea-88e4-543ea418c306;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-16T05:37:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|LV3PR12MB9412:EE_
x-ms-office365-filtering-correlation-id: 76eb4acd-d2e2-453d-2fb1-08db9e1af4a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bWCVN0bDY2Aw07c+tAEQqp2WFRrS21N7S9mS2Sgv6ojI6CUX+oL+c7sAyBTCOGr2sf4IcWGuYGvZ4U6umkogFjfX1xsfRenA7I7TGUsZFFQpHG3UaYVnM/n2NkM6hZaW1FFYRIWByWzk75O0KCN9bdlLSaJCp+cC9Xs/1ofzhCaMIvcT2VE2PiE4287ios1EpOhyuXqIOj3uX/SYGUuXJDDRAdbrcFyf592WbzRRnV0M6a2tLrHvO4xOU/3x6NpAZEBkXwRFxq3dgiBThcpubqiSX3ssENOjrrnuLG62KzjxDdYLZHSWuzugVjYx3vU/Revvc8wpLb/2RVLO4ickyX6VX4lyqCoKgjZ1vUdbR407HhtmbU948zlGVUf4C/2u3oCkZCrnzj64ibkY07PfRSk1k9SgvsOMh6l6IaeTSSUvUtQDiXah3tz1l01Z5Lc5zX5MgfDrXt/8XwC6CUlnzytcKPeQA2hMSEQNmUPV0Yb9szxi7Zr53LufvkuP5/kN9aw9ygYzKfHrOHst0aqS8D7rOX6KjOWQiBrR+vPy/+mKPe327HN9cTGU+hj7vIoH364DysESUcQCwTrMAwlPA4XseRXqJTJCn85dFbRmZfFvMx84x+IEj5smdciv0JiY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(71200400001)(64756008)(54906003)(66446008)(76116006)(66476007)(66556008)(66946007)(7696005)(6506007)(30864003)(2906002)(478600001)(9686003)(110136005)(5660300002)(83380400001)(52536014)(41300700001)(316002)(53546011)(8936002)(4326008)(8676002)(122000001)(38100700002)(38070700005)(33656002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DZMfEUzr/n5ubyrWPtcLoVYunRRvMblFgzJI/97WYo5X7w53DKryOj3dFoDP?=
 =?us-ascii?Q?xhZBOrPCFZkj8u+gw4BiqlO2Sbk97pskzqYcZG3beh/Oo36QHGKStoxuENrR?=
 =?us-ascii?Q?ha5SS1oja4BE6K0zzllD1CJfYYlVgpgkFP9ramwY73v9rQOav59WagQBc981?=
 =?us-ascii?Q?mRFS8MR9HCN22kLwr9KfnTg/3zdGPbzCk5IS/aOGOE1EoIbGyug7jOnBsp4Y?=
 =?us-ascii?Q?K1M6y55POKeMrD2TakZD++CDe3bAmVLxBkNufbytsuB0T0eGXEET8kGyhBr8?=
 =?us-ascii?Q?EgCo+xaUvWe9iudTrRvls1HAU+83A91JKSqGAfVOUJxx95GTuTQlvk89Q7Wg?=
 =?us-ascii?Q?Nzk6ro/M31AU0tj6stmn3lp7KCF/rc3AgisyccXUvE0sVIKX00BNh98cCoN3?=
 =?us-ascii?Q?KqfMXDpQACkuM9wJXgJxuciK9ORbZs7AypN5eYzKMiBmodm0a9t7uudjx5ID?=
 =?us-ascii?Q?7OQr96xoAlKN9HVt03/rwlqs5Q3YWWk5VI/p6aargiB/+yFXDt68B5horwJr?=
 =?us-ascii?Q?ftDrH5gTTFwW8Mh/sbElOKEhTqtRbv2Rt7BVr67hBraIGhOHwjMnV+lehoAC?=
 =?us-ascii?Q?Zf2VKDAZ6jBKhTTblC6ASMe7dP6BI32Y1PeHP9RuaPhEsmyrXLwi4FGwch44?=
 =?us-ascii?Q?pSoirDPVQ7KH0MJ4EcNQa0L+RX+ss5bMjSQDxVwdgJNFL5AB1BdTrKWY40Rw?=
 =?us-ascii?Q?/GMbyp553sUfFOsjtCdG5mXvz7mr4nTiSojU4uxlbOOpboXycs9yp55zF0oq?=
 =?us-ascii?Q?ahl1nK9+9GUR8ZHeORmeQB9mS0Y4lXzZgEf9iH3D3WIx1kOn+5Xb4JKX3gWQ?=
 =?us-ascii?Q?ESRqJA1Dzm+zJRrVhME3WGIJmUNW1Soih+X02smvgmRbzEizypQvMMVbH6cy?=
 =?us-ascii?Q?u75NeWJWp9RS8UxbK90wffxtHaWNg0SYKMU/KIY7wfVwpihSN+quxLa/KEIa?=
 =?us-ascii?Q?1GmRdw0sSS79IyuA7Itycxpu59gRkwm7gB4JI/5DbtlrKMBrbT+5Jr9v6TWM?=
 =?us-ascii?Q?yveLHB2LDOQuMs3GoPLqSyrZayqo47QnWrqgBDLAo9lIz/qDSqFGLGyLuh+Q?=
 =?us-ascii?Q?VHspwiWEJ6JhjHfsO2aKej1RwqQvtvrMnXPngsSk3sTjO9psMF4bI0ZCVE0d?=
 =?us-ascii?Q?Hr0ahIUeD8vLy09Q6CKuKM1qlD9ph5U9WgHigHDxWPE7PrdIfsVsw/dLZuNl?=
 =?us-ascii?Q?/HCkO/Tqcv8GTxKniwl+Ngh57eudFT4UYaN6KsSi8G6IcMRDjckN0+GXehva?=
 =?us-ascii?Q?7rwJNp3FLFfNY9zVpmYe8MvP0UaThuF9XXM0sEuZDqgxMTbGzlaAM7V5oIRf?=
 =?us-ascii?Q?37XNidbd6o19qqWEZFepyZTGyXYTTkpQK+gdApepWDq86Kx/FJV2NacU7aFN?=
 =?us-ascii?Q?tGPvcA5f6L+rvUHP9qpOQEmVS/r5hSHn9GgfBNVfJTFJH3MKGSdazthHaC0i?=
 =?us-ascii?Q?eSMbjl5In4vdx+K/Zx2SW3Pt1GPMhzREnjjlH62fX8LdLFoWYIh/kBfD9SS3?=
 =?us-ascii?Q?yuF8W1UhBw35BG5bUcjDzh4y2rM6yR5QRetm20d+OqgQGBEUX3HSY2GZhg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76eb4acd-d2e2-453d-2fb1-08db9e1af4a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 05:38:01.3662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBYICTV/sn+lqh6qRo7Wc4/pN9/GhQYKhy5vBwED27fes/FTeNr5ycH787/YYqzo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

<ping>

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, August 10, 2023 5:14 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Keep reset handlers shared

Instead of maintaining a list per device, keep the reset handlers common pe=
r ASIC family. A pointer to the list of handlers is maintained in reset con=
trol.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 19 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  8 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h   | 16 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 20 +++++++++++---------
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 19 +++++++++++--------
 5 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index 2b97b8a96fb4..82e1c83a7ccc 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -48,20 +48,19 @@ aldebaran_get_reset_handler(struct amdgpu_reset_control=
 *reset_ctl,  {
        struct amdgpu_reset_handler *handler;
        struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl->h=
andle;
+       int i;

        if (reset_context->method !=3D AMD_RESET_METHOD_NONE) {
                dev_dbg(adev->dev, "Getting reset handler for method %d\n",
                        reset_context->method);
-               list_for_each_entry(handler, &reset_ctl->reset_handlers,
-                                    handler_list) {
+               for_each_handler(i, handler, reset_ctl) {
                        if (handler->reset_method =3D=3D reset_context->met=
hod)
                                return handler;
                }
        }

        if (aldebaran_is_mode2_default(reset_ctl)) {
-               list_for_each_entry(handler, &reset_ctl->reset_handlers,
-                                    handler_list) {
+               for_each_handler(i, handler, reset_ctl) {
                        if (handler->reset_method =3D=3D AMD_RESET_METHOD_M=
ODE2) {
                                reset_context->method =3D AMD_RESET_METHOD_=
MODE2;
                                return handler;
@@ -124,9 +123,9 @@ static void aldebaran_async_reset(struct work_struct *w=
ork)
        struct amdgpu_reset_control *reset_ctl =3D
                container_of(work, struct amdgpu_reset_control, reset_work)=
;
        struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl->h=
andle;
+       int i;

-       list_for_each_entry(handler, &reset_ctl->reset_handlers,
-                            handler_list) {
+       for_each_handler(i, handler, reset_ctl) {
                if (handler->reset_method =3D=3D reset_ctl->active_reset) {
                        dev_dbg(adev->dev, "Resetting device\n");
                        handler->do_reset(adev);
@@ -395,6 +394,11 @@ static struct amdgpu_reset_handler aldebaran_mode2_han=
dler =3D {
        .do_reset               =3D aldebaran_mode2_reset,
 };

+static struct amdgpu_reset_handler
+       *aldebaran_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] =3D {
+               &aldebaran_mode2_handler,
+       };
+
 int aldebaran_reset_init(struct amdgpu_device *adev)  {
        struct amdgpu_reset_control *reset_ctl; @@ -408,10 +412,9 @@ int al=
debaran_reset_init(struct amdgpu_device *adev)
        reset_ctl->active_reset =3D AMD_RESET_METHOD_NONE;
        reset_ctl->get_reset_handler =3D aldebaran_get_reset_handler;

-       INIT_LIST_HEAD(&reset_ctl->reset_handlers);
        INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
        /* Only mode2 is handled through reset control now */
-       amdgpu_reset_add_handler(reset_ctl, &aldebaran_mode2_handler);
+       reset_ctl->reset_handlers =3D &aldebaran_rst_handlers;

        adev->reset_cntl =3D reset_ctl;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.c
index 5fed06ffcc6b..02d874799c16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -26,14 +26,6 @@
 #include "sienna_cichlid.h"
 #include "smu_v13_0_10.h"

-int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
-                            struct amdgpu_reset_handler *handler)
-{
-       /* TODO: Check if handler exists? */
-       list_add_tail(&handler->handler_list, &reset_ctl->reset_handlers);
-       return 0;
-}
-
 int amdgpu_reset_init(struct amdgpu_device *adev)  {
        int ret =3D 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h
index f4a501ff87d9..471d789b33a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -26,6 +26,8 @@

 #include "amdgpu.h"

+#define AMDGPU_RESET_MAX_HANDLERS 5
+
 enum AMDGPU_RESET_FLAGS {

        AMDGPU_NEED_FULL_RESET =3D 0,
@@ -44,7 +46,6 @@ struct amdgpu_reset_context {

 struct amdgpu_reset_handler {
        enum amd_reset_method reset_method;
-       struct list_head handler_list;
        int (*prepare_env)(struct amdgpu_reset_control *reset_ctl,
                           struct amdgpu_reset_context *context);
        int (*prepare_hwcontext)(struct amdgpu_reset_control *reset_ctl, @@=
 -63,7 +64,8 @@ struct amdgpu_reset_control {
        void *handle;
        struct work_struct reset_work;
        struct mutex reset_lock;
-       struct list_head reset_handlers;
+       struct amdgpu_reset_handler *(
+               *reset_handlers)[AMDGPU_RESET_MAX_HANDLERS];
        atomic_t in_reset;
        enum amd_reset_method active_reset;
        struct amdgpu_reset_handler *(*get_reset_handler)( @@ -97,8 +99,10 =
@@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,  int amdg=
pu_reset_perform_reset(struct amdgpu_device *adev,
                               struct amdgpu_reset_context *reset_context);

-int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
-                            struct amdgpu_reset_handler *handler);
+int amdgpu_reset_prepare_env(struct amdgpu_device *adev,
+                            struct amdgpu_reset_context *reset_context); i=
nt
+amdgpu_reset_restore_env(struct amdgpu_device *adev,
+                            struct amdgpu_reset_context *reset_context);

 struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_r=
eset_domain_type type,
                                                             char *wq_name)=
;
@@ -126,4 +130,8 @@ void amdgpu_device_lock_reset_domain(struct amdgpu_rese=
t_domain *reset_domain);

 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_d=
omain);

+#define for_each_handler(i, handler, reset_ctl)                  \
+       for (i =3D 0; (i < AMDGPU_RESET_MAX_HANDLERS) &&           \
+                   (handler =3D (*reset_ctl->reset_handlers)[i]); \
+            ++i)
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/=
amd/amdgpu/sienna_cichlid.c
index 8b8086d5c864..07ded70f4df9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -48,18 +48,17 @@ sienna_cichlid_get_reset_handler(struct amdgpu_reset_co=
ntrol *reset_ctl,
                            struct amdgpu_reset_context *reset_context)  {
        struct amdgpu_reset_handler *handler;
+       int i;

        if (reset_context->method !=3D AMD_RESET_METHOD_NONE) {
-               list_for_each_entry(handler, &reset_ctl->reset_handlers,
-                                    handler_list) {
+               for_each_handler(i, handler, reset_ctl) {
                        if (handler->reset_method =3D=3D reset_context->met=
hod)
                                return handler;
                }
        }

        if (sienna_cichlid_is_mode2_default(reset_ctl)) {
-               list_for_each_entry (handler, &reset_ctl->reset_handlers,
-                                    handler_list) {
+               for_each_handler(i, handler, reset_ctl) {
                        if (handler->reset_method =3D=3D AMD_RESET_METHOD_M=
ODE2)
                                return handler;
                }
@@ -120,9 +119,9 @@ static void sienna_cichlid_async_reset(struct work_stru=
ct *work)
        struct amdgpu_reset_control *reset_ctl =3D
                container_of(work, struct amdgpu_reset_control, reset_work)=
;
        struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl->h=
andle;
+       int i;

-       list_for_each_entry(handler, &reset_ctl->reset_handlers,
-                            handler_list) {
+       for_each_handler(i, handler, reset_ctl) {
                if (handler->reset_method =3D=3D reset_ctl->active_reset) {
                        dev_dbg(adev->dev, "Resetting device\n");
                        handler->do_reset(adev);
@@ -281,6 +280,11 @@ static struct amdgpu_reset_handler sienna_cichlid_mode=
2_handler =3D {
        .do_reset               =3D sienna_cichlid_mode2_reset,
 };

+static struct amdgpu_reset_handler
+       *sienna_cichlid_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] =3D {
+               &sienna_cichlid_mode2_handler,
+       };
+
 int sienna_cichlid_reset_init(struct amdgpu_device *adev)  {
        struct amdgpu_reset_control *reset_ctl; @@ -294,11 +298,9 @@ int si=
enna_cichlid_reset_init(struct amdgpu_device *adev)
        reset_ctl->active_reset =3D AMD_RESET_METHOD_NONE;
        reset_ctl->get_reset_handler =3D sienna_cichlid_get_reset_handler;

-       INIT_LIST_HEAD(&reset_ctl->reset_handlers);
        INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
        /* Only mode2 is handled through reset control now */
-       amdgpu_reset_add_handler(reset_ctl, &sienna_cichlid_mode2_handler);
-
+       reset_ctl->reset_handlers =3D &sienna_cichlid_rst_handlers;
        adev->reset_cntl =3D reset_ctl;

        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/am=
d/amdgpu/smu_v13_0_10.c
index ae29620b1ea4..04c797d54511 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -44,10 +44,10 @@ smu_v13_0_10_get_reset_handler(struct amdgpu_reset_cont=
rol *reset_ctl,  {
        struct amdgpu_reset_handler *handler;
        struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl->h=
andle;
+       int i;

        if (reset_context->method !=3D AMD_RESET_METHOD_NONE) {
-               list_for_each_entry(handler, &reset_ctl->reset_handlers,
-                                    handler_list) {
+               for_each_handler(i, handler, reset_ctl) {
                        if (handler->reset_method =3D=3D reset_context->met=
hod)
                                return handler;
                }
@@ -55,8 +55,7 @@ smu_v13_0_10_get_reset_handler(struct amdgpu_reset_contro=
l *reset_ctl,

        if (smu_v13_0_10_is_mode2_default(reset_ctl) &&
                amdgpu_asic_reset_method(adev) =3D=3D AMD_RESET_METHOD_MODE=
2) {
-               list_for_each_entry (handler, &reset_ctl->reset_handlers,
-                                    handler_list) {
+               for_each_handler(i, handler, reset_ctl) {
                        if (handler->reset_method =3D=3D AMD_RESET_METHOD_M=
ODE2)
                                return handler;
                }
@@ -119,9 +118,9 @@ static void smu_v13_0_10_async_reset(struct work_struct=
 *work)
        struct amdgpu_reset_control *reset_ctl =3D
                container_of(work, struct amdgpu_reset_control, reset_work)=
;
        struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl->h=
andle;
+       int i;

-       list_for_each_entry(handler, &reset_ctl->reset_handlers,
-                            handler_list) {
+       for_each_handler(i, handler, reset_ctl) {
                if (handler->reset_method =3D=3D reset_ctl->active_reset) {
                        dev_dbg(adev->dev, "Resetting device\n");
                        handler->do_reset(adev);
@@ -272,6 +271,11 @@ static struct amdgpu_reset_handler smu_v13_0_10_mode2_=
handler =3D {
        .do_reset               =3D smu_v13_0_10_mode2_reset,
 };

+static struct amdgpu_reset_handler
+       *smu_v13_0_10_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] =3D {
+               &smu_v13_0_10_mode2_handler,
+       };
+
 int smu_v13_0_10_reset_init(struct amdgpu_device *adev)  {
        struct amdgpu_reset_control *reset_ctl; @@ -285,10 +289,9 @@ int sm=
u_v13_0_10_reset_init(struct amdgpu_device *adev)
        reset_ctl->active_reset =3D AMD_RESET_METHOD_NONE;
        reset_ctl->get_reset_handler =3D smu_v13_0_10_get_reset_handler;

-       INIT_LIST_HEAD(&reset_ctl->reset_handlers);
        INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
        /* Only mode2 is handled through reset control now */
-       amdgpu_reset_add_handler(reset_ctl, &smu_v13_0_10_mode2_handler);
+       reset_ctl->reset_handlers =3D &smu_v13_0_10_rst_handlers;

        adev->reset_cntl =3D reset_ctl;

--
2.25.1

