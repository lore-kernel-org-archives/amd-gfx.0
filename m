Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AFEC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 19:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34EAE10E0AE;
	Tue, 19 Apr 2022 19:45:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F7D10E0AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 19:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtOY+6UJGQ19hEY+oEjc8wuAFEIJ4HiRpYXF5d/pkYiK+1daXDFAlFVs6lLVrIEuyWLSpXRSsn2EjL8ak2DPwo0UOTbpOsQ3tb3arnhSFPK6qpD73bRETsZGQG1pBUFWkINkY4tPc63esxOAJOi2AhJvik+C/THicW060mgO7x7FCFy56qj6LmJU9O2m8OTfzO6h8wrZRaI8YtrnjWBwbJBNmlSBI+Wf+b4n0Kyvo/3MgZpjIC5fYphkJAjv568sCbFdZp9VnuzONIW1GVvQjs4nn5liM6nKv51T+RcLq7P4ZQju5JuPf3iIHUXSQIECZg6aEefzDOO/95mLYwTDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nOk9mrvt1zFnaybJUeDQv+P9IBm8Lp/z4i/mEbMdPc=;
 b=JVHo1SkOh8iTxqXgJw450/XoYJCBg3C5emCqNmiBuHxPuGzu4KGG9UhrbN74DBj6eR6vO9GaMAznKRgCC9Lb5s1Iy2PfAVeM9m3PI0ZMyA2+f4gfxIuzAmgmkrHiSPWSviyDB7UrtXht2/0OxHA2QiKNhHU2ppAyGTFThgsysNieG1dPduSGT3P1cYKEarvinYGlgXfqF7W/Z1b4+PoImAnNs7EFI5zZGYapQby8ZEVpw3h7ff5BDKf5VY988scW8vPnyBFMigOj0wDbKImS8ziZZ5jg6IxU1Hbyx05Yca3K+Lobc89rqSyQUHA1rdyUCNUQ5dzg84PWqd7hNQ4YCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nOk9mrvt1zFnaybJUeDQv+P9IBm8Lp/z4i/mEbMdPc=;
 b=I5mo3lTBmzB4srExNC5iliX0qVJ/mMkNk1fKw4OUhXV3N/nxde11YCu0JkLWzJThwH1Ykck1dv2C7SuHhvAcwN+vasyZ7wX1Bpoh+dmA9wooju0i0gLyDC/yuA5hbRy23ca5TAbyHWdMj3ZDtOQK9kiGa/CAVuP6Iv96kYUdfVM=
Received: from DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29)
 by DM5PR12MB1227.namprd12.prod.outlook.com (2603:10b6:3:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 19:45:45 +0000
Received: from DM6PR12MB3963.namprd12.prod.outlook.com
 ([fe80::58c7:fc3b:9fc3:d926]) by DM6PR12MB3963.namprd12.prod.outlook.com
 ([fe80::58c7:fc3b:9fc3:d926%7]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 19:45:45 +0000
From: "Wong, Alice" <Shiwei.Wong@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Bokun" <Bokun.Zhang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Execute IP's hw_fini when hw_init failed
Thread-Topic: [PATCH 1/2] drm/amdgpu: Execute IP's hw_fini when hw_init failed
Thread-Index: AQHYVCUPR470w4pC20uzUSfEeNQRM6z3owyA
Date: Tue, 19 Apr 2022 19:45:45 +0000
Message-ID: <DM6PR12MB3963F0CA8A94E7B1C60A4357EBF29@DM6PR12MB3963.namprd12.prod.outlook.com>
References: <20220419193751.1856508-1-shiwei.wong@amd.com>
In-Reply-To: <20220419193751.1856508-1-shiwei.wong@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-19T19:45:43Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b289e8e0-b7a1-4df0-aa24-bad85e3cba18;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-19T19:45:43Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: a8520c17-3289-41c9-afbf-6ba3fc663eb8
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 691e0e17-7c52-41eb-38c0-08da223d31f3
x-ms-traffictypediagnostic: DM5PR12MB1227:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1227690FBA4164F44DB22984EBF29@DM5PR12MB1227.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFnrFevH6F0+BadA+pSu1YYnclg7dH/ODTm3TdWOajuElF4KFbdXLmFjR4nut0sRAVeCAONodV92Kti6ZZ1l+o0TDHbO4VUUGn+Nf//4riIaeOTIePWHTBV+94HBfj63WpTyoK7yeOYJTR0DAxf7HX9t0fvVv/Ws7xX0l/dVf2k8b7vFg+BLgIyns8qjx8vBvou7Ka2zGgivqi5BHELsyCSDDRzoOXDY3kZCJT57k9ctvg0VVu1Jyrb6KGHTuVE9ZfTJLnH0nJHNZvbJt/h/iw4MjyQg72Jnb3ZpH27wBdb7cwBxB4tUIBaqoJnujoo8psHJiFIRbw/DjF0+Tk8uW14HQeZPkLoWNVqxWeqmVq+tKer7aUi/aiZmD8XUrnfWT3AfZ++3DTAa3npdU9qGEvezQYVbUyZ1j8ElK1MPrkF/nsFJMn4J9LyF+YvGBB0YL1KYTFCqx07mebt/2um+lkXHqfhobZaPyNHYFctjTVfJYaFWBmBAmoANtdahXFPiQyC2wZPZQsx1WHYQeguMLq6zfOzeFXl4uK+kukx4xD5cvb8drvtQYcE0ZI2hzpp2KqEfm4yX0mG0zUVx3M3RZuMjnEH1X7P0WJDS/5+KnriFw6AALuHcX9ENsEvuwh3ewntZ6RrMKQUlWYyWP3AI0lAzcV5EE+d/HjFqs4/RjIQkXqcyPFMWt1o9hfxczprGUbuelMkESEIeQb2K6z6ygA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3963.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(122000001)(38070700005)(7696005)(8676002)(66946007)(66556008)(110136005)(38100700002)(186003)(26005)(9686003)(66476007)(64756008)(76116006)(66446008)(71200400001)(86362001)(8936002)(4744005)(6636002)(2906002)(33656002)(6506007)(83380400001)(316002)(55016003)(508600001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0+DRI0alMPol3hz6KS7BCawnxoKOW+O/BnFo7fFYivTJR6qOId1zdwt7af+B?=
 =?us-ascii?Q?FRExCIU0VXQRuKFqelztWW29+MpTcXDQTxbuNyR2VahSsLU3gY2aDQ3AB8ni?=
 =?us-ascii?Q?eoMsMefsL2ytAsneJoPM3rilGfrUmuCbFN4igVlPZ439j52XWQwwNM3aKuc/?=
 =?us-ascii?Q?BiEPSDZwVChG+obpTFCJZ4K4lcETjWgrezOJjYANm3IlZFbZlMnElOTNOtcK?=
 =?us-ascii?Q?ka4daw98sHHtmRgOAOIyQXR7NX1rigQx1xIZFYmIPFbI8oFMXeG5T4fttNbo?=
 =?us-ascii?Q?6xtvhz881yrM+V+EIp1SWyOKQAZkQXXNY7oh06zEpROfdfoHBNGbtFdNM9R2?=
 =?us-ascii?Q?T3SD/b6SUIzfUnf115gPD7z10MBHC+oojY6KIRfgh1fMqHnXFZ39yVzukQys?=
 =?us-ascii?Q?VWivWgPjcotnWqc06s5iM/WGHFrjnBOyS0nvHtM19TC3J/EgxOcqxsouFB90?=
 =?us-ascii?Q?6UvjqCmHEGPFT5BvrG2CHLKlsHtg417Yqo1FC9IHtx0QxBQcNX1surnXvTEQ?=
 =?us-ascii?Q?JGPiOpd9ij4BkpECWbNODn1STqa+LxFgd+dvfA9s7dEQRv/kpfeLNT9a+97N?=
 =?us-ascii?Q?LPfNBQVVzXi68jB5qe7TeYuyOf5VqzXaeIfk4p3FSkYF67KTDwu8CqZjncWe?=
 =?us-ascii?Q?c79Z8cyDY5JfUiSdCoa0C1Hf+HVx1NlT693yYMdl3aNZHnRetqEMvmwPEfcs?=
 =?us-ascii?Q?0LGyBGpw71C1ucnm18xwswADntZo7mFbL6xi6gupSL9QntvUfRfPwe8G6QgR?=
 =?us-ascii?Q?KCET3b1BXQl2tMrbaXfLX99oEgqGQFu3ptHW2MTJc+BELO+hkOlrkGvy0vUl?=
 =?us-ascii?Q?gGyZFcr9fn2ofer6IfCf8odxkRDF6V/LQiqhEeY7USnD5kSNfxpOg5bHq5AK?=
 =?us-ascii?Q?cdNe1GXdt2y5CLKUtJb3BB9ryAEMVOuaynup+KwMvpGn4UaTu77XAcRzFSfF?=
 =?us-ascii?Q?50F7Tm/ndDTexCfexhYXIzmaqnd038hMe/bVt3FQYFmQJHI4r2gebwXfNzeK?=
 =?us-ascii?Q?A25QxCz4nlctdJdabKLd9k04FQ1kLZl2BQ5GPDvtWQGGKp3H5tvxNfIeDC3s?=
 =?us-ascii?Q?QlephJF0dvXRtWn4Zzu9DZZgHg0XCsKOdnIdu92qriEO/uluKVGMDyUDIazW?=
 =?us-ascii?Q?i3H3KvfpIFvaQSIM0De4MqDbxd3Bdip0sCyWY6CnhH8wfmOyu7sGsvx0Hvfl?=
 =?us-ascii?Q?4vUo3x1k10HLABAkGU/tyPrYmhjKBVBlvgD48Gy7wfiE3V4jls50m9DeIuXd?=
 =?us-ascii?Q?XizjaIq5CbaArotGTGEuH62s7V8FL0910X6PK/VDBVTGF2cqJMzZgIBEwLva?=
 =?us-ascii?Q?d+TUG9fxO4VOfoJZjfjsOi1/jQUTqQ3jsEYNmgKP/3arJXY1Yx1aNfmOb9Sq?=
 =?us-ascii?Q?oV9VL95dVmmBJUzCBQnnsAr38ClV0NLrbzzmqpKyc2O/am+ApzeMAP4tw0P4?=
 =?us-ascii?Q?17wPLUeulyadETEtncwBEwpQxFsc2VEWtKeU9lWMs7zeIf9KGdMCpbisJngZ?=
 =?us-ascii?Q?YNnZL40z10z3bb4TqkyoypIw+J/CpwsZcVWxMTL8j9slmqFmwNpoDCWnDBcB?=
 =?us-ascii?Q?iDAPyQclQgr5QnxGdWJNdEjDMgLmrGMn7108eRyO1PaZX8ub/YNMsXzyh0wj?=
 =?us-ascii?Q?XDx62JC8XC+LOn2Eqi7Hbc9b+Kr4Jgz6/h506IFH1AQcaFPSnCIY3POQC2Xr?=
 =?us-ascii?Q?J8MO9ULbMepVYmmjzhOUHvd6ngMnP+MOj7c10ZJ9/ShQEEcF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3963.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691e0e17-7c52-41eb-38c0-08da223d31f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 19:45:45.1938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YEeJwq7yrB2v+wAfvhu1HIH8mYTzk+FASDJNaMT8OdWAaUjQ++uQ+5uIWsHBq8I9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1227
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

[AMD Official Use Only]


amdgpu_device_ip_hw_init_phase1 and amdgpu_device_ip_hw_init_phase2 call IP=
 blocks' respective hw_fini when hw_init failed.

BUG:SWDEV-332449
Signed-off-by: Alice Wong <shiwei.wong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index ec38517ab33f..3abe647bbd2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2281,6 +2281,7 @@ static int amdgpu_device_ip_hw_init_phase1(struct amd=
gpu_device *adev)
 			if (r) {
 				DRM_ERROR("hw_init of IP block <%s> failed %d\n",
 					  adev->ip_blocks[i].version->funcs->name, r);
+				adev->ip_blocks[i].version->funcs->hw_fini(adev);
 				return r;
 			}
 			adev->ip_blocks[i].status.hw =3D true; @@ -2303,6 +2304,7 @@ static int=
 amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
 		if (r) {
 			DRM_ERROR("hw_init of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
+			adev->ip_blocks[i].version->funcs->hw_fini(adev);
 			return r;
 		}
 		adev->ip_blocks[i].status.hw =3D true;
--
2.25.1
