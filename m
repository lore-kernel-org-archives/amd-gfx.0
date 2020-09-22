Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89180C2D0E2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 10:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE6F208A9
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 10:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IAsTGsks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE6F208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2741F6E118;
	Tue, 22 Sep 2020 10:27:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2BA6E118
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 10:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ7Xyef4NNQH/HJGNp/iWjinBIx4H0PIH6XBm/G+ONgQqbNwCE4EY7HBDKoCO+jXeVL9E5TuP9oL68F/M1NuDXxJLQ7jsRDJUTyIZG4QleWO2m1erc8PQxnHsCXQD36/gP/bTDy8Quc6RghlWs67RcoqA+boPlcS8amXpsYnxzzYo79FIrGk1LF8EmEkycgTq0o26JvJEgVU22wPURYLgYn6xm+bwOB30pIDQbAYD08INR0C1zw/LG8FUillkYh/BBb6BcOpqbsdKtD1FMHR/M0XSm4zNQXH1L0YKy2RcQTyFYrEXNlX38UDkMaPlaMgKcuMRMxRL88/HpiLDcyhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW2N71Je/Dsb8FlBP1e1qqnwjhgIQyAHeci3qup7xG8=;
 b=BFpxnaNz4hq6G24hD9idyA65F0qFat41+FIMgjRIa+TR52C9SW4yHnwkcS3bUFHS0YBRL6cW5Cddez29uKTklmErOJw4URq4kjmNcet1v7C2F1CxBnj61uyqFqSB5hBxDPZIMlRJBur2AlJm8FT4aOBiRgah1xzpnck0CJiIWUMFsDNgH3Uykx1zPGMYnSO08Vz71LZlpCwhZ6efQMHx91q0Go82IfZFCT9bW3ZK800S50ZQUHOYG8OehVWqC3KqHd4pvTv6jWHGiqhp1XOwmtIwahmwERI7zOUbaFQvkR0s8+XYFIhg12M7eYq+fC0Ktbl9uMPBNmc9m/LwnaMaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW2N71Je/Dsb8FlBP1e1qqnwjhgIQyAHeci3qup7xG8=;
 b=IAsTGsks3HippNZMDCGH5sg9kQave1nfqOetGgDBNNoKHomnJjqj1Kc+y3J/Gi5bQQp9meKsnPH4EQkwbTBMrWArFShGIdqM7AX5T8yzeP/kb7T4QSh1GQnWD6bZgsAE2o+49qQDAfHo8Y8IR6Q0qePyILUXsX3+Yql6l6gY1Lo=
Received: from BY5PR12MB3841.namprd12.prod.outlook.com (2603:10b6:a03:194::27)
 by BYAPR12MB3318.namprd12.prod.outlook.com (2603:10b6:a03:df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Tue, 22 Sep
 2020 10:27:21 +0000
Received: from BY5PR12MB3841.namprd12.prod.outlook.com
 ([fe80::b46d:4fb5:514c:11c4]) by BY5PR12MB3841.namprd12.prod.outlook.com
 ([fe80::b46d:4fb5:514c:11c4%3]) with mapi id 15.20.3391.027; Tue, 22 Sep 2020
 10:27:21 +0000
From: "Chen, JingWen" <JingWen.Chen2@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "Wang, Kevin(Yang)"
 <Kevin1.Wang@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV
Thread-Topic: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV
Thread-Index: AQHWkK9NpCMyAklYSUa9QVKtAeCweal0QZkAgAADh4CAAC4JgIAAADjg
Date: Tue, 22 Sep 2020 10:27:21 +0000
Message-ID: <BY5PR12MB384184A38E47945F8C5977CEB73B0@BY5PR12MB3841.namprd12.prod.outlook.com>
References: <20200922070842.366545-1-Jingwen.Chen2@amd.com>
 <20200922070842.366545-2-Jingwen.Chen2@amd.com>,
 <DM6PR12MB40754DDA2888F313D7C18005FC3B0@DM6PR12MB4075.namprd12.prod.outlook.com>
 <MN2PR12MB3022F4100A13D2127B8BFC15A23B0@MN2PR12MB3022.namprd12.prod.outlook.com>
 <BY5PR12MB4115EF7F980F6CEE08480F9E8F3B0@BY5PR12MB4115.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4115EF7F980F6CEE08480F9E8F3B0@BY5PR12MB4115.namprd12.prod.outlook.com>
Accept-Language: en-150, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-22T07:37:38.464Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD Public;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-22T10:27:17Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Standard
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 4e603055-ba43-4d47-bae8-0000e4f9ca49
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69542342-1b23-43ad-aac2-08d85ee216fb
x-ms-traffictypediagnostic: BYAPR12MB3318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3318B47E505E7D9FC11FF76DB73B0@BYAPR12MB3318.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 40OlmG70Rv3aIx/R5G5GcQds0m4XlfIe1l+5oUj4ngVF5CKIgglgwEFHBP4ghhOxX+u1h5rkDHqdRM8AAQMinqdYhBb0UU4Q/zZ8eqLImOdZnJIDSXwYGkmdPN03kyCdgtWTIec5FP7ovxc7uBEDCR1dZthchnHbcdkN3tvboeooAACTPErWq7Ktdx90X4hKml8OCp55wbTjr1FnP8AIBcx1Lgy++mHCzUGgtej/WauhiZ/cw481ateIUhkq9Bk2FjnCiBIX2nDnC6BdUb41f2C+qkqG7MrxqyT4amKC4JxAxOSTd1ImREL95zy2dU+HkXLr9VWN3LLjg8cRsDt4lqX6KcHswDVdRlPvyps2ZOf8qz8W3HY83Nl8l9c5A1tOhLNDurCHweMA/vtudHlFC9aplHk6AfrP/7P0CK0l4Yg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3841.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(316002)(5660300002)(52536014)(66476007)(66446008)(76116006)(66556008)(83380400001)(110136005)(966005)(166002)(64756008)(66946007)(2906002)(9686003)(55016002)(186003)(33656002)(7696005)(86362001)(53546011)(6506007)(8936002)(45080400002)(478600001)(26005)(8676002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 3vyhQ2rr+JYHM+7KzdyuHAPP1izHpmTYAW4nb8bDOZ/YTgsYZCd3OoBu305I8F2wqKNICV5CEqST9qfWJviHxWflJVtfkwavpnUcL1tcL81WS3SG7AFy+O5ja6Pm5dHAxfXES9RtwaWj9qvROJuBmqCcawb9LN7jiSl7DMqQHUNaX4KCI3+apYXNp0kqjJA25eEkYmFg4sliJ+51XzF6q5BSdYSI4lw6k58b++kecAGiYr78wRx8+BCpQdSc4spPr/c88iZTmh+EZAhLzFeIwIG3IvbSN8mjwlryUXdpJjAvP6uXf2FvCPfK3jLz5MVkmlizzHDq/rStIi+wzNcel2J1IEYAMkgzF1N0YISx6OQtLUVzPPcwiq4gF4NjMIkvMgxta3qRzxlSbFNAk3UvMtgw96m6RroCHQ7FlnuM6ieipQKF33P8mxQkm1N86Zkzmy4dSg0AZS/CIi68MpN27mRnLxw7xTGaZjLOAseKbI3lRG0v6MgCSkJh57SJ4CwDi5cxVrt8QCZAGThSXWEp3PgbHAi1xe71Ar6ieLNqYYTXvR+Tf8DnCxjBiOyfKThqhJyLEBLHU9+Hkcv1Lt1LeUkd0EoVhU7Xhei2wcxbPZ6ktkpaExGIFusjmFlSyPmsp9T8sqmP1FkS19Aw3vi4hA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3841.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69542342-1b23-43ad-aac2-08d85ee216fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 10:27:21.2068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZBjRaBDORGXWg9YUiV2DvYxXF4ROK5aZf/bmWcW/B0VuaQJi2EulpWznTm/XuhJDpT7ty3u2El8jHuqr6QF/VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3318
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
Content-Type: multipart/mixed; boundary="===============1703854402=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1703854402==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB384184A38E47945F8C5977CEB73B0BY5PR12MB3841namp_"

--_000_BY5PR12MB384184A38E47945F8C5977CEB73B0BY5PR12MB3841namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]


[AMD Public Use]

Hi Hawking,

We may need other features in PSP in the future, e.g. load cap fw. So we ca=
n't skip the whole psp_init_microcode.

Best Regards,
JingWen Chen

From: Deng, Emily <Emily.Deng@amd.com>
Sent: Tuesday, September 22, 2020 6:22 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Zhang, Hawking <Hawking.Zhang@=
amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; amd-gfx@lists.freedesktop.=
org
Subject: RE: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV


[AMD Public Use]

Hi Kevin and Hawking,
I think both you are right. But currently we haven't good method to handle =
this. It seems need to re-arch the whole driver, not only refer to this pat=
ch. Only refer to this patch, I think it is OK.

Best wishes
Emily Deng
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Wang, Kevin(Yang)
Sent: Tuesday, September 22, 2020 3:38 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; C=
hen, JingWen <JingWen.Chen2@amd.com<mailto:JingWen.Chen2@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV


[AMD Public Use]


[AMD Public Use]

Embedding these SRIOV check into the underlying functions is in many places=
, which is not conducive to subsequent code optimization and maintenance.
It took a long time to clean up the SMU code before, but now some new check=
s have been introduced into the SMU code.
I think a new method should be adopted to solve this problem unless there's=
 a special reason.

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Zhang, Hawking <Hawking.Zhang@amd.com=
<mailto:Hawking.Zhang@amd.com>>
Sent: Tuesday, September 22, 2020 3:25 PM
To: Chen, JingWen <JingWen.Chen2@amd.com<mailto:JingWen.Chen2@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@=
lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Chen, JingWen <JingWen.Chen2@amd.com<mailto:JingWen.Chen2@amd.com>>
Subject: RE: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV

[AMD Public Use]

1. Please do not add the amdgpu_sriov_vf check in every psp fw init_microco=
de function. psp_init_microcode is the entry point for all kinds of psp fw =
microcode initialization.
2. I'd like to get a whole picture on all the sequence you want to skip fro=
m guest side so that we can have more organized/reasonable approach to excl=
ude those programing sequence for SRIOV, instead of having the amdgpu_sriov=
_vf patched case by case...

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Jingwen Chen
Sent: Tuesday, September 22, 2020 15:09
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Chen, JingWen <JingWen.Chen2@amd.com<mailto:JingWen.Chen2@amd.com>>
Subject: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV

smc, sdma, sos, ta and asd fw is not used in SRIOV. Skip them to accelerate=
 sw_init for navi12.

v2: skip above fw in SRIOV for vega10 and sienna_cichlid
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com<mailto:Jingwen.Chen2@amd=
.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c              |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c               |  3 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c               |  3 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c               |  3 +++
 .../gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c  | 12 +++++++-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 11 +++++++----
 6 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 2c66e20b2ed9..9e2038de6ea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2385,6 +2385,9 @@ int psp_init_asd_microcode(struct psp_context *psp,
         const struct psp_firmware_header_v1_0 *asd_hdr;
         int err =3D 0;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
         if (!chip_name) {
                 dev_err(adev->dev, "invalid chip name for asd microcode\n"=
);
                 return -EINVAL;
@@ -2424,6 +2427,9 @@ int psp_init_sos_microcode(struct psp_context *psp,
         const struct psp_firmware_header_v1_3 *sos_hdr_v1_3;
         int err =3D 0;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
         if (!chip_name) {
                 dev_err(adev->dev, "invalid chip name for sos microcode\n"=
);
                 return -EINVAL;
@@ -2558,6 +2564,9 @@ int psp_init_ta_microcode(struct psp_context *psp,
         int err =3D 0;
         int ta_index =3D 0;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
         if (!chip_name) {
                 dev_err(adev->dev, "invalid chip name for ta microcode\n")=
;
                 return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index 810635cbf4c1..86fb1eddf5a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -592,6 +592,9 @@ static int sdma_v4_0_init_microcode(struct amdgpu_devic=
e *adev)
         struct amdgpu_firmware_info *info =3D NULL;
         const struct common_firmware_header *header =3D NULL;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
         DRM_DEBUG("\n");

         switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 48c95a78a173..9c72b95b7463 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -203,6 +203,9 @@ static int sdma_v5_0_init_microcode(struct amdgpu_devic=
e *adev)
         const struct common_firmware_header *header =3D NULL;
         const struct sdma_firmware_header_v1_0 *hdr;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
         DRM_DEBUG("\n");

         switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index 34ccf376ee45..9f3952723c63 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -148,6 +148,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_devic=
e *adev)
         struct amdgpu_firmware_info *info =3D NULL;
         const struct common_firmware_header *header =3D NULL;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
         DRM_DEBUG("\n");

         switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index 1e222c5d91a4..daf122f24f23 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -209,11 +209,13 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
         int ret;
         struct cgs_firmware_info info =3D {0};

-       ret =3D cgs_get_firmware_info(hwmgr->device,
-                                   CGS_UCODE_ID_SMU,
-                                   &info);
-       if (ret || !info.kptr)
-               return -EINVAL;
+       if (!amdgpu_sriov_vf((struct amdgpu_device *)hwmgr->adev)) {
+               ret =3D cgs_get_firmware_info(hwmgr->device,
+                                               CGS_UCODE_ID_SMU,
+                                               &info);
+               if (ret || !info.kptr)
+                       return -EINVAL;
+       }

         priv =3D kzalloc(sizeof(struct vega10_smumgr), GFP_KERNEL);

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 538e6f5e19eb..3010cb31324a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -832,10 +832,13 @@ static int smu_sw_init(void *handle)

         smu->smu_dpm.dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
         smu->smu_dpm.requested_dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
-       ret =3D smu_init_microcode(smu);
-       if (ret) {
-               dev_err(adev->dev, "Failed to load smu firmware!\n");
-               return ret;
+
+       if (!amdgpu_sriov_vf(adev)) {
+               ret =3D smu_init_microcode(smu);
+               if (ret) {
+                       dev_err(adev->dev, "Failed to load smu firmware!\n"=
);
+                       return ret;
+               }
         }

         ret =3D smu_smc_table_sw_init(smu);
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C96b1fda73cc94c3ec44408d85ec8f126%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637363564431270216&amp;sdata=3DszoPYYfIpzZCyRrzYSR%2Fv5D=
bogjhMuyHMHIzWygj6Lg%3D&amp;reserved=3D0<https://nam11.safelinks.protection=
.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinf=
o%2Famd-gfx&data=3D02%7C01%7CEmily.Deng%40amd.com%7C849a249868ba4128962408d=
85eca6667%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637363570681227058&s=
data=3DulesiZTX8RCcr4IQRg2E6aenA430mwjHi%2BhlfAuRGoc%3D&reserved=3D0>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C96b1fda73cc94c3ec44408d85ec8f126%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637363564431270216&amp;sdata=3DszoPYYfIpzZCyRrzYSR%2Fv5D=
bogjhMuyHMHIzWygj6Lg%3D&amp;reserved=3D0<https://nam11.safelinks.protection=
.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinf=
o%2Famd-gfx&data=3D02%7C01%7CEmily.Deng%40amd.com%7C849a249868ba4128962408d=
85eca6667%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637363570681227058&s=
data=3DulesiZTX8RCcr4IQRg2E6aenA430mwjHi%2BhlfAuRGoc%3D&reserved=3D0>

--_000_BY5PR12MB384184A38E47945F8C5977CEB73B0BY5PR12MB3841namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
	color:blue;
	text-decoration:underline;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#317100;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Hawking,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We may need other features in PSP in the future, e.g=
. load cap fw. So we can&#8217;t skip the whole psp_init_microcode.<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Best Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">JingWen Chen<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt; =
<br>
<b>Sent:</b> Tuesday, September 22, 2020 6:22 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Zhang, Hawking &l=
t;Hawking.Zhang@amd.com&gt;; Chen, JingWen &lt;JingWen.Chen2@amd.com&gt;; a=
md-gfx@lists.freedesktop.org<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amd: Skip not used microcode loading in=
 SRIOV<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Hi Kevin and Hawking,<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:10.0pt">I think both you are ri=
ght. But currently we haven&#8217;t good method to handle this. It seems ne=
ed to re-arch the whole driver, not only refer to this patch. Only refer to=
 this patch, I think it is OK.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best wishes<o:p></o:p></p>
<p class=3D"MsoNormal">Emily Deng<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Wang, Kevin(Yang)<br>
<b>Sent:</b> Tuesday, September 22, 2020 3:38 PM<br>
<b>To:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Chen, JingWen &lt;<a href=3D"mailto:JingWen.Chen=
2@amd.com">JingWen.Chen2@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd: Skip not used microcode loading in=
 SRIOV<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Embeddi=
ng these SRIOV check into the underlying functions is in many places, which=
 is not conducive to subsequent code optimization and maintenance.<o:p></o:=
p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">It took=
 a long time to clean up the SMU code before, but now some new checks have =
been introduced into the SMU code.&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I think=
 a new method should be adopted to solve this problem unless&nbsp;there's a=
 special reason.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Best Re=
gards,<br>
Kevin<o:p></o:p></span></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang=
@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, September 22, 2020 3:25 PM<br>
<b>To:</b> Chen, JingWen &lt;<a href=3D"mailto:JingWen.Chen2@amd.com">JingW=
en.Chen2@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Chen, JingWen &lt;<a href=3D"mailto:JingWen.Chen2@amd.com">JingW=
en.Chen2@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amd: Skip not used microcode loading in=
 SRIOV</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Public Use]<br>
<br>
1. Please do not add the amdgpu_sriov_vf check in every psp fw init_microco=
de function. psp_init_microcode is the entry point for all kinds of psp fw =
microcode initialization.<br>
2. I'd like to get a whole picture on all the sequence you want to skip fro=
m guest side so that we can have more organized/reasonable approach to excl=
ude those programing sequence for SRIOV, instead of having the amdgpu_sriov=
_vf patched case by case...<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Jingwen Chen<br>
Sent: Tuesday, September 22, 2020 15:09<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Chen, JingWen &lt;<a href=3D"mailto:JingWen.Chen2@amd.com">JingWen.Chen=
2@amd.com</a>&gt;<br>
Subject: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV<br>
<br>
smc, sdma, sos, ta and asd fw is not used in SRIOV. Skip them to accelerate=
 sw_init for navi12.<br>
<br>
v2: skip above fw in SRIOV for vega10 and sienna_cichlid<br>
Signed-off-by: Jingwen Chen &lt;<a href=3D"mailto:Jingwen.Chen2@amd.com">Ji=
ngwen.Chen2@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 +++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++<br>
&nbsp;.../gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c&nbsp; | 12 ++++++=
+-----<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 11 +++++++----<br>
&nbsp;6 files changed, 32 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 2c66e20b2ed9..9e2038de6ea7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -2385,6 +2385,9 @@ int psp_init_asd_microcode(struct psp_context *psp,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct psp_firmware_=
header_v1_0 *asd_hdr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err =3D 0;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!chip_name) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;invalid chip name for asd=
 microcode\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -2424,6 +2427,9 @@ int psp_init_sos_microcode(struct psp_context *psp,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct psp_firmware_=
header_v1_3 *sos_hdr_v1_3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err =3D 0;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!chip_name) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;invalid chip name for sos=
 microcode\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -2558,6 +2564,9 @@ int psp_init_ta_microcode(struct psp_context *psp,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ta_index =3D 0;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!chip_name) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;invalid chip name for ta =
microcode\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c<br>
index 810635cbf4c1..86fb1eddf5a6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
@@ -592,6 +592,9 @@ static int sdma_v4_0_init_microcode(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_inf=
o *info =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmwa=
re_header *header =3D NULL;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;\n&quot;);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c<br>
index 48c95a78a173..9c72b95b7463 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
@@ -203,6 +203,9 @@ static int sdma_v5_0_init_microcode(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmwa=
re_header *header =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct sdma_firmware=
_header_v1_0 *hdr;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;\n&quot;);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c<br>
index 34ccf376ee45..9f3952723c63 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
@@ -148,6 +148,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_inf=
o *info =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmwa=
re_header *header =3D NULL;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;\n&quot;);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c<br>
index 1e222c5d91a4..daf122f24f23 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c<br>
@@ -209,11 +209,13 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cgs_firmware_info i=
nfo =3D {0};<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D cgs_get_firmware_info(hwmgr-&=
gt;device,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_UCODE_ID_SMU,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;info);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || !info.kptr)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf((struct amdgpu_d=
evice *)hwmgr-&gt;adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D cgs_get_firmware_info(hwmgr-&gt;device,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_UCODE_ID_SMU,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret || !info.kptr)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv =3D kzalloc(sizeof(st=
ruct vega10_smumgr), GFP_KERNEL);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 538e6f5e19eb..3010cb31324a 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -832,10 +832,13 @@ static int smu_sw_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_dpm.dpm_level =
=3D AMD_DPM_FORCED_LEVEL_AUTO;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_dpm.requested_=
dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_init_microcode(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to load smu firmware!\n&quot;=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_init_microcode(smu);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;Failed to load smu firmware!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_smc_table_sw_i=
nit(smu);<br>
--<br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7CEmily.Deng%40amd.com%7C849a249868ba4128962408d85eca6667%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637363570681227058&amp;sdata=3DulesiZTX8RCcr4I=
QRg2E6aenA430mwjHi%2BhlfAuRGoc%3D&amp;reserved=3D0">https://nam11.safelinks=
.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailma=
n%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40amd.com%7C96b=
1fda73cc94c3ec44408d85ec8f126%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C=
637363564431270216&amp;amp;sdata=3DszoPYYfIpzZCyRrzYSR%2Fv5DbogjhMuyHMHIzWy=
gj6Lg%3D&amp;amp;reserved=3D0</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7CEmily.Deng%40amd.com%7C849a249868ba4128962408d85eca6667%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637363570681227058&amp;sdata=3DulesiZTX8RCcr4I=
QRg2E6aenA430mwjHi%2BhlfAuRGoc%3D&amp;reserved=3D0">https://nam11.safelinks=
.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailma=
n%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40amd.com%7C96b=
1fda73cc94c3ec44408d85ec8f126%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C=
637363564431270216&amp;amp;sdata=3DszoPYYfIpzZCyRrzYSR%2Fv5DbogjhMuyHMHIzWy=
gj6Lg%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BY5PR12MB384184A38E47945F8C5977CEB73B0BY5PR12MB3841namp_--

--===============1703854402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1703854402==--
