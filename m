Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4135C48260
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 15:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D31C10EBB0;
	Fri, 16 Feb 2024 15:30:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bEY/toig";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB0D10EBB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 15:30:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+G7YBAKlG277Ym/I5dgjJ3IPC9LvED0Og8ZuBrcwgEfa6IFIGQXohtst5hxZ5sN73jPwTuVgkn9jmzTmuuGX7tcMisjGNajvTY1NsgoZpZw3RekBtQGOg8C1yCgamzWHO3DcdeS4eSP6dHBBx2wpIQXHaF7B0oJNm3/7EPJmXJnDmH9nx3LH/XoBKE2SlqfzeQdlG/LfwBGh2cKPW0GBn7katmS+GbUTHpcvC1VN9+vTJKFftGWUWDW5qYQlZ4RmWB35XnO6AknyLc4hN+5/fr4+dE63AD1D8qaxFUHlPJq1X4jqjNavp+6sus8la4Kx4HwoLo0UN/Dj1fq4979lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVjeUAfgwxbU4iVnzH+RkxoRXp8FKwQEqyt2PNLhlIk=;
 b=UY2NK9N/oLc9Pf5s/w2nJjDscqphlR1999nY52rZE458qSWR6neOEBqzT94Ivhe3r3LJejBLuWzv1Q/1xD6gyi9ayGZzrfvnTx0u7VoVRVQqpkb5S7rTlAQKbZ7h/ML1kagAKl4GZZMs0GOpeDT1+WJPaQGNAgnGydhuBSGpddYZNKx0eCBdxmA+mkO1YbKJIX5lMIv3JPVhZdgqE+w7lNY2xQq2SfCQgbMMBksKe1JMsiTUZ5DsoJ6klr1+uCcSCCwoStsKT4MXbeb7tPUPQrYXgyZp0IkiPo+xTM4MhCZZh+kgny3fpq5TqmmqzVeMIUvAlZEX/kJHKwopVPEhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVjeUAfgwxbU4iVnzH+RkxoRXp8FKwQEqyt2PNLhlIk=;
 b=bEY/toiglyZG4bvuiD+0oqkMOEArX8o1j9xlacNJXzoUIA6KmWV9h/E6/kzrCCBAWCdfNOTJURmuZKe/g4aOFPAF+0Kc/bJB2YpXfwzLCNYOmM6x4mywVBCfLtmLZPx67a9S+2xvkbSOhi0hMp7c0YeTJ9Yg4hl07DOGMZNzXMo=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 15:30:44 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::215f:f712:b269:fcbe]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::215f:f712:b269:fcbe%3]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 15:30:44 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 9/9] drm/amdgpu: enable MES discovery for GC 11.5.1
Thread-Topic: [PATCH 9/9] drm/amdgpu: enable MES discovery for GC 11.5.1
Thread-Index: AQHaYE86iH04GEL6NUCfkQw69aHV27ENGWNQ
Date: Fri, 16 Feb 2024 15:30:44 +0000
Message-ID: <CH0PR12MB5372B6466C3E04887E9AFAE2F44C2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240215203955.415314-1-alexander.deucher@amd.com>
 <20240215203955.415314-9-alexander.deucher@amd.com>
In-Reply-To: <20240215203955.415314-9-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=47917cb8-dc00-4235-b601-c6a118a5e60b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-16T15:30:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SA1PR12MB8598:EE_
x-ms-office365-filtering-correlation-id: adfe956e-8dad-4fd9-ff7e-08dc2f043de5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4B3AiqoFxYwdRUTJhjAY/1KPk3M7EgkjuxzonFVBYE4+MCRXj6FfI6C2tYSp2mT4YKtfbIdrJgIHZpqnm52Oiu7Wq3IdT3CFssDVVir02rxHmEloyHayLmvQGlhZSRoennjQw1gbyqUAVhnvZUAhPNBsuLgxnqbN4TMqumJG9jQFL1TxyGrRH0qKsWpf3kF5zTpSWRNltEo1Ek00Y4onhtqsanVgbo6+jjd1FW552gkA5nMhkPy3GRN17FrfkA7XEqX2MMJTwk6zA28nKyJOI6IgcgCDLLxNu4qlXKgfxMxHmUBgeUjM/gdQ+KvgsTMtK0KvfMD+n84tX9KZJD6LZfYdAFN1XrXw6jMGRU4f4bk7QQqy0m1J8TjPyiYiL4lIG4bJHwrAxKhm37j9xBolKCuiwJwALu22jF9naZygS1q5V8youPCVplo3X9RWY3w8+20Xec4oUCOTuAHo8IEtI5+rlnHquX/Y0j5wx4IyuGeaiBCIvNvxruNVKw08Id5z2ycLv2HCbuzOf86EFTybGgS+8SXpClGONEN8Fl+GTRKsusk3gZ8bCIPhH2yyS54ufcv1p+W1MRxKXhN6byF00qOzA9T2Ouh9u1aRw6Yf5gFiR3NhIlx8YwwBdBOaOcj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(55016003)(9686003)(478600001)(41300700001)(71200400001)(64756008)(8676002)(4326008)(2906002)(8936002)(316002)(52536014)(5660300002)(110136005)(6506007)(7696005)(54906003)(66446008)(66946007)(76116006)(66556008)(66476007)(38100700002)(83380400001)(53546011)(33656002)(122000001)(86362001)(26005)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bCND57nWAUebYsDtp4y15wZF+GaYfBOcWlX3Lj6nWX9pxf7E8W3PW4ZN7Oym?=
 =?us-ascii?Q?wuRHq5am1pQS7iDXmsfReNEh+RIeaVhJcQ4kb1GRwRS/hAYy10P9lHVhY2Oz?=
 =?us-ascii?Q?JkFcm7KBcMV2z2jtFRaKA3Dpb/IwknToL7ga2YS+O3sLAbOXYt74mOj1CXMW?=
 =?us-ascii?Q?Lq0KGFv4fpHndeJB7sjr9SCcH3o8eCnATyvJpWUNTaI2KHUi/drEELL1W0Oy?=
 =?us-ascii?Q?mLPunFeHLgqdBIiTmdi3GAWZh1XvS1f2RAg36Vp0Y4/GqKBOsez0MY1tbkbu?=
 =?us-ascii?Q?1jut9l2T3UcjyYGF6gGGde6ZXruEvgt/s2QQCaCr1GdFF88fyc0zlXHOGXua?=
 =?us-ascii?Q?wJEE8Ztmz7HyM1+Wq92NkLIAcCcby+kimKPh3/SjKimE1gSNBk2+xZoFdRhW?=
 =?us-ascii?Q?k8I7Gg1lwxTLn/DW8r+OVhpdR+g7xXtmNEEGG5wGGHcdCaE5ya3LTei+ZQAq?=
 =?us-ascii?Q?MFe27SrwhNona6oiY7QdkftlN7n69g/kvmmsdY2Y90igKeJALSWSoh34BiLP?=
 =?us-ascii?Q?tbXQv1TXKvLLSY+X5eNtEZAaFPARill7hXliWL+KIQtrJF1LtbPkHT3WZT2S?=
 =?us-ascii?Q?PYaA6rXk7aZ75DEbjZWqCyKEzVj0+1bi6ZC0Nyi5AQnoXTY8mjdmC73tS5Ev?=
 =?us-ascii?Q?J20NlcrSXK2bUvgb1vxRNx+zvqXkF8SrZhr/C4ZnrcVOoL+fP9qxYBTx1Iun?=
 =?us-ascii?Q?Owiw3pQPZQb/WYcRqwx5uKSbHo4hl3ziU1fTmXmG4gR15aJvp3ryo9vFTndH?=
 =?us-ascii?Q?K5pf7KViEDfQ0MNze2OiJVNsgDrdZUxv8FcDKiPaPAjf7zxx1Qhm3yYdCf/Z?=
 =?us-ascii?Q?w/wC3C3LfbOZoKszIGJu5Rz5akL2ysqyWWGOMHdj3BBmsfCJVPLUm0WzPKuX?=
 =?us-ascii?Q?MD+dvDLkAzXcldNqYpHs7CJgFU3LIDyBMWXqHDJMpynUaX6N1ZDgckGCvb3i?=
 =?us-ascii?Q?lCL3jBRJIAeCgp9giHFNbyeFEK2RVWl4Xjai4FC+4BRoQxuAUixwXAiWv0Cb?=
 =?us-ascii?Q?iIyfnR1qQlndd3rtH6o5UOGGdhrAideI607FLHMiAfs9l23zs3KFuVp0CdgB?=
 =?us-ascii?Q?PaGJC72bUWME+NAE1ljM9eTUtvtKhws7A8dFfxois5YDvAZev4BFE8YV1PCd?=
 =?us-ascii?Q?GpKTv6orQbtOCvYb5F8e5+r3vpofP+2IaZ//R5I8B5X95mUfezIItN/OqCp2?=
 =?us-ascii?Q?+7Qwf0zO0OMbw+DUMCaEBCo45dFtInkL+nYVwyNzTwQv6p8uQ6tO9m5MP9kU?=
 =?us-ascii?Q?AveWrHf9A1jl4XaGI8yb2GZNydYQlnj6Fler1LGg/lwxF9U+WUWt2GvYr8lh?=
 =?us-ascii?Q?vfuuhqId91NvdmgoklOUKCTs/7bMT1v0z50LyTvg6uzffiM/0PHLeYkVFrKi?=
 =?us-ascii?Q?LpeYw7fao6hAKfyTOM+PYz5a9MYHXlz8/FWbn/FVevFxFrboihV7/N6K2Pw/?=
 =?us-ascii?Q?Ule+TPjyoOHGxQgZmOZWbVVCPt5+UPb55bXvWIK6HzRNMhxS90lHfXRLLrfo?=
 =?us-ascii?Q?TC62LaIBlHa70QQdmCZBa1ZRQ9XBPEOiQBf0j8rWsw8u3HWQ5zqroXfnoIjS?=
 =?us-ascii?Q?sapMzo6zBZP+qc6BeuE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adfe956e-8dad-4fd9-ff7e-08dc2f043de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 15:30:44.4176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKZ4ImkUAvgrufN62oG8ndbKnX9+JSwOjPNOx7orYacmmgpr/z1CEM7rcIoWsbj8Plt4l/aPhIHBKCwfQo2+Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598
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

Reviewed by shaoyun.liu <Shaoyun.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, February 15, 2024 3:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Deucher, Alexander <Alexander.Deuc=
her@amd.com>
Subject: [PATCH 9/9] drm/amdgpu: enable MES discovery for GC 11.5.1

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to enable MES for GC 11.5.1

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 70aeb56bfd53..704b7820c47c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2185,6 +2185,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct =
amdgpu_device *adev)
        case IP_VERSION(11, 0, 3):
        case IP_VERSION(11, 0, 4):
        case IP_VERSION(11, 5, 0):
+       case IP_VERSION(11, 5, 1):
                amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
                adev->enable_mes =3D true;
                adev->enable_mes_kiq =3D true;
--
2.42.0

