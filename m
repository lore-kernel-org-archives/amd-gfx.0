Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4457EB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 11:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C2810E1D2;
	Mon, 26 Jun 2023 11:17:59 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53AC710E1D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 11:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDZ82SNQu3zVaFLS9Usp8uyLjv5ho5ywFM7tuwDswGD3EFjUbzopgPRUYdI815bQFt1BWfKQWDHFSzoHFJASEwJfyJWZ0NH4Bw2OrtJrkw5aEE/ZEiCi6F5X5X3KpcZa0kla4I6DpvJ2tFmK+mL1ZpvyvB8Id1Y6gprTXJMAgxBkKYLf+dIC8NVTwTv8t/xKFED6u4C0LBn0IbszFIRcCHXq9WOnd0viUB/jQm+GRKV1pxwae+VOQ3NlI2hxH8+msRaqAi13qI+fzl/S7xd2tQhIE+DTKLbrHBRANN1Oyc53mRvxbwRo44FF0nYdsGvw2w3QLKiLaQmga2B//frkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KJRh74XZT0ilvAkJCcbWed926Fgz5Kv+VFYp1wYioY=;
 b=fmlHwfRBh+ifurHeO1FhOmPrb/4qZk3WeAvRHsbQe16IAYUOZ9wV/CnlRVBG1ca4kN37XaZwhKBX5E2l4d+9YKqja27V9sZQjyYsZbI8WcVzto1zMwOUvBVCBph4b9SkI/u5B5SCisKZtSqveeOVN/O/lp1IhC/CGpoeRGgnEZcXpG5ag+0Ekdd6Mi4Qd31inv6MMkeZdnBWwI8qNgLZUmIMTzyPPveVeeZ6VmiwxcW5WggfhGHrbYCOAqu2ugAL7/wYt+QSmtdW5sWN94sLYUO5xFKQLnCDbEpVeBhhX5pwaPSM68dedKUuDln4RBAOHfSTXrqcnoRQlNYoZpHWrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KJRh74XZT0ilvAkJCcbWed926Fgz5Kv+VFYp1wYioY=;
 b=GGOJi79TPGSZe6N88l4lx65aXTAy2g7QRpOapsUXfAEPWuC/1mV4SZ7VgKsi7UGC2S4XSX+sG5+nf2FUsfJJmj5053o0x8X0iy3wI2G6Yi9UVFayxQbN8Qg56ZsbmwCOYTO7rqR0tmm/zAzJV6SxvML2NCxJrnaCr0ZLWix4bFE=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 11:17:54 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::5a8f:ad4f:8874:8e25]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::5a8f:ad4f:8874:8e25%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 11:17:54 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: enable mcbp by default on gfx9
Thread-Topic: [PATCH 2/2] drm/amdgpu: enable mcbp by default on gfx9
Thread-Index: AQHZoJca9qq/oBFobUGFOnQk1FG0B6+c/nRw
Date: Mon, 26 Jun 2023 11:17:53 +0000
Message-ID: <DS7PR12MB6333237D15C31F1DEE777D64F426A@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20230616211011.31578-1-alexander.deucher@amd.com>
 <20230616211011.31578-2-alexander.deucher@amd.com>
In-Reply-To: <20230616211011.31578-2-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5737b661-d1e3-45a0-826e-b1d315c88059;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-26T11:17:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|MW5PR12MB5682:EE_
x-ms-office365-filtering-correlation-id: c544b386-5576-487e-a2b5-08db7636fc8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sdtWt9FyOgmRfuH03lLaOvblN+z4xAOqnOUsFPRYHNATe9tdRYHNP7fFEETDujAGKRtIojJey/TxOZvBrwOV9tYJi4VtkX6nqoJrqV/Ug4t8gxU6mzBaLo8mdzN8eimlZPapVzNzYwqVRJjeHs2dicjTW6UHxbTIPXd4C/Vj1k54p373ZJ2pY4RgRw0DzOX1SYh8a5Ei2OLSGIUdTj9mwcBYhAkDRezbeAMyCH/9Dq1yfCy5UXNYp2B3GoAjl4sMeIHM57WtP1MLkJOYZl+dr/oE4pRL3nvCtha5f/xJ7oy+hQVRtdI9VV6eCA4vWA+oC0wD0IihIWre9zWOBcIfx1jCNfKvzKaaoXQ29U6syj/1/qoEItRmmMZlyUq8oUrjDrY6uyY6XmRz2Ly0+8OyuTiylZ4j+eeBdpCXY311mJ/k3v8Tdk/sMcN4UmO5p6IMru6ztTI8U2yuGH6LdVqyua8Wn2FQSb8+D5vg9H9MbcgojhlushQdrcOkpUqysZazC7+08yrwcxMlWDAt/e70Y7gWmXRTDZ8Addksms/EmnhS+vdvb3ZkulBv3EZmyrGnGs8GztEu13FU2a9pUxsEDSubiFdRCSRhJjCn3mpz+TY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(33656002)(52536014)(5660300002)(316002)(86362001)(66476007)(8936002)(8676002)(55016003)(4326008)(41300700001)(66446008)(38070700005)(64756008)(66556008)(38100700002)(122000001)(76116006)(66946007)(966005)(26005)(53546011)(6506007)(2906002)(9686003)(186003)(71200400001)(478600001)(7696005)(83380400001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ULlQXFrwvJjXq8JL8z+bpwsKFHmcDAoP3R2yBIeOGiOUuq+OZfSTRb/9J+xy?=
 =?us-ascii?Q?f1Gm5qm0oYtsY52MucbW13Sqm2CKZvoeALsza6H6xXINf1kmSOa2B8tITBSO?=
 =?us-ascii?Q?ZRO0AYolsYeQSWJbetywRMDbUGxD0nrTegGGdb7GsS5F1ndV6ZXG2V4wcxzM?=
 =?us-ascii?Q?Z+yyaDawSLd6ULnTeUwoXEaWU/YgxXluIV22MUMd0rKJmsrmif5fWPgVXogF?=
 =?us-ascii?Q?HvDwAT/tQJOiCBzZTY+I1tZ4pS34xeriPS4Vt6DeDHqWmTYG5enqatsY8vLR?=
 =?us-ascii?Q?88Llm2vbjjh2w3k9ib+HL1zdfGJvCV1tw3MRx/b3UERyAClrMnqqRr5WDZOZ?=
 =?us-ascii?Q?whUJMH8H9k/IfJvbUjPJB16Ip3TQmeSyMxcb/r4YrFziy6Z49VmTEtk1P5AR?=
 =?us-ascii?Q?j607RafnDPom94YGGmfOssIY85l8tRiEh20eB05bdX4AtpZy/ndf2ztB/IBS?=
 =?us-ascii?Q?MfMzFgxvARCYsKN3vhE8+SdxOIS724BHljW7a4+2yc0EY4uTbcs9AuhkiNPs?=
 =?us-ascii?Q?EbCnbfkSDbOoWv/Z1NxaplGlr4SSyIJWJlnowwsHLkVw8WYB10Z7qQN2BOkH?=
 =?us-ascii?Q?zXXXjWa8xzOsN3aXNM4CBHVubjI8TEsWNGCdoUFk3RgIm1pLnjDGBKhLP/ek?=
 =?us-ascii?Q?9Z9lDFEQcP3yVgjSatKA1ZjgiE7V5LppyXJ7dSkhY8DH5cdZFmd0T+DkG/AC?=
 =?us-ascii?Q?KqkDPaZ0PRn5piN7jI9YE3952iXsJVaSJCKRuvADyQNFZmjRHNFdswn7LG/J?=
 =?us-ascii?Q?2U+iH8VGV50Mbxgr4xcWytly2ZKuqrn5WVplVDq6JlWPozKNOF0ptM8YUVZM?=
 =?us-ascii?Q?ZF9ISt96iNn8/wSpYgCjTBzWq9Jh3sNZXPzN8OWc+tPpVmsyReoMfcqOzM+B?=
 =?us-ascii?Q?xLdjWvQoD8hTswN+Vx3RX55u/MU9F+5WeLso1pDCASpkZUVrwZ/iEd+fqB33?=
 =?us-ascii?Q?tG++vLJAtr8Nm9pBsh9PBCGhYX9taLgLK94SgpqFSy+dB2oH9xL2bV45nDJc?=
 =?us-ascii?Q?el1/h2A7hemHEH0Cenlez4S1ikjydnCeutx869ARZ9ElxkQFjjXUEbxI5GK1?=
 =?us-ascii?Q?NvtNRhyHM7IWukwOeVrOcAgzwcBX7WZOY15MuYXdSeG41KL4X0POaGB9885Q?=
 =?us-ascii?Q?5EDr6/BvpY3I5jfIw44e8kzlSfbyHt0O33H0/Ob++fl/+EyK23oCsFpjflzn?=
 =?us-ascii?Q?KOUfEXwFEJaJUMwmwLTuypiZYN8O8j0xw86pA7jIS1foxHGCHOL0XILc9Hbg?=
 =?us-ascii?Q?FxgXi2Dt+c7zO/Eu7BZ2W9Mv7mTwH3MhJVXnBqTEL18c8nyOpAcffSg8BciZ?=
 =?us-ascii?Q?LKArz5dYntK0/lpi/5xAK9bcGjDWwyexo1oqygfHBI4Y4D2sFqgM4F7pf1uA?=
 =?us-ascii?Q?jIalvWx3awuyDJICho9DDQTCK0RxATa9LcWRmcL1VUjBQzIMTts6csXfmfy6?=
 =?us-ascii?Q?a0rFL7f36gkfEvARZXSIrbhJrd8IkdvTfY32YzH+3OhkoCNSdnzN3cjbwa+w?=
 =?us-ascii?Q?3waH9M0a6vh4IikPMoewrxnYxevgY1fRDzjSQSRL35bgFm3R+6N6TWH17j0h?=
 =?us-ascii?Q?BJ951PpoNprG2QMUnpw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c544b386-5576-487e-a2b5-08db7636fc8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 11:17:54.0110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SiYbVbE+i0mgMc5JiGJ8b1fvT/4CRkswqP95tHt1xsxmvOQXvoG+tLCnPu5gY7142uhIovaLjYY6gxK5FlriUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-and-tested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, June 17, 2023 5:10 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: enable mcbp by default on gfx9

It's required for high priority queues.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2535
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 78c6265fe79b..3eb370b77ad9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3677,6 +3677,11 @@ static void amdgpu_device_set_mcbp(struct amdgpu_dev=
ice *adev)
        if (amdgpu_mcbp =3D=3D 1)
                adev->gfx.mcbp =3D true;

+       if ((adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(9, 0, 0)) &&
+           (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 0, 0)) &&
+           adev->gfx.num_gfx_rings)
+               adev->gfx.mcbp =3D true;
+
        if (amdgpu_sriov_vf(adev))
                adev->gfx.mcbp =3D true;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 03874371af60..308149dd7d00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -180,7 +180,7 @@ uint amdgpu_dc_feature_mask =3D 2;  uint amdgpu_dc_debu=
g_mask;  uint amdgpu_dc_visual_confirm;  int amdgpu_async_gfx_ring =3D 1; -=
int amdgpu_mcbp;
+int amdgpu_mcbp =3D -1;
 int amdgpu_discovery =3D -1;
 int amdgpu_mes;
 int amdgpu_mes_kiq;
@@ -635,10 +635,10 @@ module_param_named(async_gfx_ring, amdgpu_async_gfx_r=
ing, int, 0444);

 /**
  * DOC: mcbp (int)
- * It is used to enable mid command buffer preemption. (0 =3D disabled (de=
fault), 1 =3D enabled)
+ * It is used to enable mid command buffer preemption. (0 =3D disabled, 1
+ =3D enabled, -1 auto (default))
  */
 MODULE_PARM_DESC(mcbp,
-       "Enable Mid-command buffer preemption (0 =3D disabled (default), 1 =
=3D enabled)");
+       "Enable Mid-command buffer preemption (0 =3D disabled, 1 =3D enable=
d), -1
+=3D auto (default)");
 module_param_named(mcbp, amdgpu_mcbp, int, 0444);

 /**
--
2.40.1

