Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E78AC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 07:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E999310E430;
	Tue, 11 Apr 2023 07:29:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D37A10E430
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 07:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtUFVATekHnJMAb1Vob9Asyr6YKVpNHIDVoyKHxW1mKNi+FvCfcwFXpoZ19zk4vUjobBGugP9MWAC7M4u5sfKJ2fiugFqJEImwxsShd6R199ghaH2ZiKE0q14sfLJKmUkfMa/lodT8duPsIztXHoJHnaeDguZWsdCtFBT22XA0McHeIMZLpOLdCPk6z26KpbrOQGAZDpmC99Pc93g1q6dxqNFVlHtBmRrxFRr9xdEruePTXhf6yR8w8MaWcL8SMfPYhJveLwWC9IXw1mckWRVAv4czSKLPC6sLeK5Q1LP6Ka9U49KI14Nc+jEPQwPIMigsCUp5da+CqQD1uTl8pJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsRvS9gNuSZizj/0u5xu4seFYaeHrDiAg3D8eSRyIWk=;
 b=EmLfqqYK9637akHP8FI7FSpzMretlGaYJDL/9vEp54S3LAT5W/pyjxiTbfl9GjxhXu+7FYoe1dW4wwq1TPuFX5QJDiQ9auzGoF2kf7AxGP+4xLFBLSRI1+KAFqpgoEmrf+650aU03qNmz8wCYy5Dsji9xdDRyNO7BktGBS9OTKasTO6KuwPQypgMdLUrXr+Gh0M9MRZFJBq8DGe7Tx8454POrS2R0uqoALWns6YyLWKi9+cs2QwH6iuP8MamjvAPfYTlGgdtF59U5b0otZ1gFN4hheJsWiBZ+n7Jsk4QosY/RWl61g7e/l/oWxfOcgPGrYFUXqY3NrKmai8pLDIJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsRvS9gNuSZizj/0u5xu4seFYaeHrDiAg3D8eSRyIWk=;
 b=4ZlL3agezD4XyJIeWzpKnbSauETqjGaWKGX2LD7n+FgwACr7mfi/eaDMpcExsl/lBDyClBZ4/PFt4yBDCkJAGspuzcH8sd+mAxvxrfYREaWP+h06mfr0koS7z+9mFe4W1Gxtl3GSuOjSKpReHuxR8bSC4U9SQKt1sTASeNNQ8Bk=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 07:29:49 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::3f0f:783a:2620:4b1c]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::3f0f:783a:2620:4b1c%6]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 07:29:48 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH Review 2/2] drm/amdgpu: correct ras enabled flag
Thread-Topic: [PATCH Review 2/2] drm/amdgpu: correct ras enabled flag
Thread-Index: AQHZa6Je2Fgs6IbCM0qf63hItEKr768lfjiAgAA437A=
Date: Tue, 11 Apr 2023 07:29:48 +0000
Message-ID: <BL1PR12MB5334612E2B610FD3956326E69A9A9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230410114822.750-1-Stanley.Yang@amd.com>
 <20230410114822.750-2-Stanley.Yang@amd.com>
 <BN9PR12MB5257B09673A51355D78F7BA1FC9A9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257B09673A51355D78F7BA1FC9A9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-11T07:29:46Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Privileged;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6267d8c0-b2bc-4e5b-be0d-4fadf928b38c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-11T07:29:46Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Privileged
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 68cf924d-d488-49a2-ba79-fe47991f121f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|BL3PR12MB6617:EE_
x-ms-office365-filtering-correlation-id: 4bf511f2-43b9-4519-82f4-08db3a5e882b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4V9u/oQG3JSVcEg5VNXgAvmrMv1n1lJ9aR6i77unbaqbp2HdsWXRU66uOJ7m890BtcUBXah/7B8NNvRbonjp6t4KyRKlXuLzdUuOOYWKfFQigvfHZaA10i568gVRlT8YmWiziXl1D2aURRfnonHbaBpWkqp5b/qktH7JD4tMuZG1222Pm7FBk4bMbJWKRQMMTtIV/AjG2CWNK2j/zHoHXUpF7UYkl08gYB31q6U1HtJTV+xM4vFTUw6y4rLUbMfBswD5qped1c2J8sKXH6LnyNR/yTeWAEJgCE7RokrY/wqzQoE5TpHCh3XWinjkKhjAf3GQXS7wTqZlbbnjr22nj9fEn9uf+6JIYp//GU4vtLR5O6OBdO5g0mSfgEgCmqogP+fzUA1lFnhiAcHmSsiDA5IJooIM2ZOnxeHfQBWm7g8KkslXuVwQRwCBR6XIwAW5ssPpQrV3mac4Q5ZR3IO5O97/WfP7OgT0qkIoRaxyhqRpk6rUQrdddGvW9G5MlgvD0RxK7cYl+hVdAkoaqKsBaHa2S+2MS1RwLZt+s3zcdGSXya3zvOE3i90aOm1+qxgqtlFEpNADdbrK6/FDJUfBAuY1Shc+Ee62uylNzo+hjWdp9lVJ0o6ep7AtuefXndD2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(33656002)(86362001)(71200400001)(7696005)(41300700001)(110136005)(316002)(66946007)(76116006)(478600001)(66446008)(66476007)(64756008)(66556008)(6636002)(55016003)(5660300002)(52536014)(8676002)(8936002)(2906002)(53546011)(38100700002)(186003)(38070700005)(122000001)(6506007)(26005)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GlzcGsuaKffRekvXASbcMrQfDEnYpBS8o9BsKOByrL0I8joTwKDBmRg7rnmf?=
 =?us-ascii?Q?L2QkyMP4CbUDnpDP/e2xA75VSNYpu17VMTFpieYGjex+PFmUzC9UowpaHM7T?=
 =?us-ascii?Q?LeWfjL2CtDwKKayKhfm4jk684/6AFE0kIeVSTpOPIfE/mN5zbCdzHHmEpkGM?=
 =?us-ascii?Q?3kh2C9Oa3LHhozh9V1GMXSbbWsQRlhp2JXbmT8jsQxUGUX6PqO+2Q1M2cTjh?=
 =?us-ascii?Q?AZNcqq4bkq0arhFrbwGDjVba4peN31K4Yq3KqEQk1Ib0n39bQPBSyu+YbcPh?=
 =?us-ascii?Q?TKiKbEER76hwSKSkFFLbqpK0DtKgsAWbeHQPRB94TxWSXsS58owItgh/pjL2?=
 =?us-ascii?Q?RD2gC4iTCcqxQifPGSpjDd7dJ5CGVgjvTCNmV5KkNV4xiMor+VUQXlfxy7gs?=
 =?us-ascii?Q?Rk94xoVscipNW9GewLltum38yNxnYIRsC9gOUrMx0Ha0noyBXAAIEL39a/0+?=
 =?us-ascii?Q?siAWYqZest3S/C9MPzG63QVVuPnISokRhnMrQQtZQN0iFWr7Ywlumff6iUD9?=
 =?us-ascii?Q?m1+PXlSw+qOW8KVni4i/j59/KpClbvS5h6C4PQ+CBHeBI9TZR+TEmlVTVsDy?=
 =?us-ascii?Q?VITB+3hlP6RLWWlvawZC8Bju/h2kUknzFH1vbi8SevjmjpUBv32Y9vbyBfmI?=
 =?us-ascii?Q?Fej0HrULZEDanYBbZXU/OK9xzn2JYeFcTR0hIw+btyqJ2IUaL0xygpcWFNhd?=
 =?us-ascii?Q?ookBrMISnx6jk8Yp9dtwBkumxrX8cwJFx8EINLr5g62fFozZNBhgjn4cAJCO?=
 =?us-ascii?Q?xcujYloKrtPMiy+6j/YMDGgDFlKnP6yefS7/5AkFBz19AH4RC1ZSXdfdIiHP?=
 =?us-ascii?Q?yXvoasz7QwARzeAH8/vnynwMBJVMvTEhTBTGqM3AYujIePs9cpvirttsXmhA?=
 =?us-ascii?Q?QUl25xN5KMi4AjsFu4V52/B8eShic0CM5mtsjlZJBSvPZ2NcaoP9FqgbpyLk?=
 =?us-ascii?Q?V24CeqJCzmmuFs+YWIbeSjcwIeXxFtS/RF43DwaQlJ6cpYn9ZYQDCjkbWtA4?=
 =?us-ascii?Q?Npm5LRYjEpJeePSr8hlhWxj99H5WOAOl+wE6VFlUAAt96Z6+9orK+6URGMiM?=
 =?us-ascii?Q?/4opkRa0NTc3ovvp7edu8/NvM87BFTtT4r2zd5BjZB/o/NLKNz2ATIcwRjdI?=
 =?us-ascii?Q?eE/eLRgtWRK48y10a06xDGFpRua8yiizGWrkBIG9iA5zErm4dHQ/s8Cq0Tc7?=
 =?us-ascii?Q?/MAsz5OkYREhfm0qCWGkbwQlEuDgvm2vFESBvkibWWbdT2tXdUJiYAe1uCb4?=
 =?us-ascii?Q?X78sNVVOWM/zz8m1cc53l0NZWd5PC04dIKctB3vAPuziwmraRkqebmDCwLNi?=
 =?us-ascii?Q?FDb1ik0sGAJxo1bTZGbX/y6EzWQgrkYfU+dXSQq8TMKrm/tR7lzCY6o5ZhxE?=
 =?us-ascii?Q?9FwnFLAPKYm8yiRk5lMUiaRlcyBXuRZcorRJbtd3IaHmjqq2zByM2tHijxhP?=
 =?us-ascii?Q?Mw7ibhlKoCmDn/k1fb7sbaNNi9otTc32Pw+0LNMDyoultMEIHSt7n3qHEByl?=
 =?us-ascii?Q?h56fYbDNNXW8mw8L8Q/2s6VsTr2rtHRX1AiVzjAKgC3WMCCC1jL0tX4ymAEU?=
 =?us-ascii?Q?AQjruyyltor/yaQ1jCM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5334612E2B610FD3956326E69A9A9BL1PR12MB5334namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf511f2-43b9-4519-82f4-08db3a5e882b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 07:29:48.8664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+JZquK8G0fSuD85W7ZbFF5Z4Xhe55mUhEoo8FoAhvHeYY5xOnXfhGbbo2mJI3PaLkKkgvGSN7dGmguBd7sSow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
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

--_000_BL1PR12MB5334612E2B610FD3956326E69A9A9BL1PR12MB5334namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Thanks Hawking. I will update.

Regards,
Stanley
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, April 11, 2023 12:05 PM
To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org; Zh=
ou1, Tao <Tao.Zhou1@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: Re: [PATCH Review 2/2] drm/amdgpu: correct ras enabled flag


[AMD Official Use Only - General]

Just check gmc.xmgi.num_physical_nodes =3D=3D 0 should be good enough for t=
he case that we only have single ALDEBRAN/ARCURUS available in system.

In such case, there is no need to expose xgmi_wafl ras node.

Regards,
Hawking

From: Stanley.Yang <Stanley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>
Date: Monday, April 10, 2023 at 19:48
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>, Zhang, =
Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>, Zhou1, Tao <=
Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>
Cc: Yang, Stanley <Stanley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>
Subject: [PATCH Review 2/2] drm/amdgpu: correct ras enabled flag
XGMI RAS should be according to the gmc xmgi supported flag
and xgmi physical nodes number.

Change-Id: Idf3600b30584b10b528e7237d103d84d5097b7e0
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com<mailto:Stanley.Yang@amd.c=
om>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 4069bce9479f..d26a93272bf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2430,6 +2430,14 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)
                         else
                                 adev->ras_hw_enabled &=3D ~(1 << AMDGPU_RA=
S_BLOCK__VCN |
                                                         1 << AMDGPU_RAS_BL=
OCK__JPEG);
+
+                       /*
+                        * XGMI RAS is determined by xgmi supported flags
+                        * and xgmi num physical nodes
+                        */
+                       if (!adev->gmc.xgmi.supported ||
+                           adev->gmc.xmgi.num_physical_nodes =3D=3D 0)
+                               adev->ras_hw_enabled &=3D ~(1 << AMDGPU_RAS=
_BLOCK__XGMI_WAFL);
                 } else {
                         dev_info(adev->dev, "SRAM ECC is not presented.\n"=
);
                 }
--
2.17.1

--_000_BL1PR12MB5334612E2B610FD3956326E69A9A9BL1PR12MB5334namp_
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
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks Hawking. I w=
ill update.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Stanley<o:p></o:p><=
/span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt">From:</span></b>=
<span style=3D"font-size:11.0pt"> Zhang, Hawking &lt;Hawking.Zhang@amd.com&=
gt;
<br>
<b>Sent:</b> Tuesday, April 11, 2023 12:05 PM<br>
<b>To:</b> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; amd-gfx@lists.freede=
sktop.org; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Cc:</b> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH Review 2/2] drm/amdgpu: correct ras enabled flag=
<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Just check gmc.xmgi=
.num_physical_nodes =3D=3D 0 should be good enough for the case that we onl=
y have single ALDEBRAN/ARCURUS available in system.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">In such case, there=
 is no need to expose xgmi_wafl ras node.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hawking<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Stanley.Yang &lt;<a=
 href=3D"mailto:Stanley.Yang@amd.com">Stanley.Yang@amd.com</a>&gt;<br>
<b>Date: </b>Monday, April 10, 2023 at 19:48<br>
<b>To: </b><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;, Zhang, Hawking &lt;<a href=3D"mailto:Ha=
wking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;,
 Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.com</a>&=
gt;<br>
<b>Cc: </b>Yang, Stanley &lt;<a href=3D"mailto:Stanley.Yang@amd.com">Stanle=
y.Yang@amd.com</a>&gt;<br>
<b>Subject: </b>[PATCH Review 2/2] drm/amdgpu: correct ras enabled flag<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">XGMI RAS should be according to the gmc xmgi supported flag<br>
and xgmi physical nodes number.<br>
<br>
Change-Id: Idf3600b30584b10b528e7237d103d84d5097b7e0<br>
Signed-off-by: Stanley.Yang &lt;<a href=3D"mailto:Stanley.Yang@amd.com">Sta=
nley.Yang@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++<br>
&nbsp;1 file changed, 8 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index 4069bce9479f..d26a93272bf2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -2430,6 +2430,14 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ras_hw_enabled &amp;=3D=
 ~(1 &lt;&lt; AMDGPU_RAS_BLOCK__VCN |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt; AMDGPU_RAS_BLOCK__JPEG);<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * XGMI RAS=
 is determined by xgmi supported flags<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and xgmi=
 num physical nodes<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gm=
c.xgmi.supported ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;gmc.xmgi.num_physical_nodes =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ras_hw_enabled &amp;=3D ~(1 &lt;&l=
t; AMDGPU_RAS_BLOCK__XGMI_WAFL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_i=
nfo(adev-&gt;dev, &quot;SRAM ECC is not presented.\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB5334612E2B610FD3956326E69A9A9BL1PR12MB5334namp_--
