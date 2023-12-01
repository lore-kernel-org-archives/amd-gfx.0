Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FCEC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 07:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7000F10E035;
	Fri,  1 Dec 2023 07:32:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C0610E035
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 07:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIkYYdCBr0KMUqj46D7Q4hQsWLeK8/KuyDQwm1JwNZzrYW9UgBsQwBxQwPSWOkOTbn3pVsMDcdrFPpDMVP1gAEr1fEbcCwLEb1AdPgXCifE2XwNwd3B668NEugKqfcS0T7203Vc0OsMUJ+ok+q/K709l7iTZzOJiG3+XU5QsdFm1N8oBX42d7BL527jFT+hnqAhFCB9gqSM5xflNFAKaQhE8PyLqiJCKRVuE4PX9CJpCv0TA9OtBrr/k207KF9dERkevpTcO4OKC9vqcPJfuo1h0P4fZCNMhpCgtPQXyUljwtUuHTu2BlcLI35FJHyen/w5QOvqtsuCeiGt3ixblJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgatljASsZle7yM4jksYq+FXJvoBSbVARDWMYqX8kYg=;
 b=lYYY2sybWrmPs4ur13Mrrru3eWLGYntvWKfuVFHJZb+0GWkX/EsU8g2UwsB2deWvp0iWewcy2fNZYh8gYm77c2xd20XayZuKgB8z0MjuFDa0PAHpZ9F0wQwiltIBBoSWyW/lg42lOPxzlKbMXP4NDI2d1/hHK1SzpiP+HkiPSmedcKdZEm7By+JOyoPlshhaCVhIqfG21T+mcI9CGtcKuNdGP2ZMhZ7DlvVpszkJuAhsQYTCJOJmQTdg0ShM8bSPhAPps8Zch32PTMqh4aT0l4n1Q7/+4d/mmMX000LdLyK9ofIoJfacNFAlKWL/lGrnKsmVlNqtLYStpsblwTIpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgatljASsZle7yM4jksYq+FXJvoBSbVARDWMYqX8kYg=;
 b=XQZb4Rsm6KW//a22OUYEXfJB6nPp2FCxPT/42zQ3GcO1RVetmyQi994kwpbPEopXIBazDbtpKK9I/qk4zk0eSqhjZKIfzThFyhqBqWt3Q49xScok9I8fHrTdjFRIqYVgOSQCRUgDZIi5eI/9etxJXLt1Zt/jWUomafunQ5gTkD8=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 07:31:19 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::734c:f924:fc7e:2eeb]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::734c:f924:fc7e:2eeb%5]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 07:31:19 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/2] drm/amd/amdgpu: SRIOV full reset issue with VCN
Thread-Topic: [PATCH v2 2/2] drm/amd/amdgpu: SRIOV full reset issue with VCN
Thread-Index: AQHaIyMr6IloMo7GMkOBdnI2iAFEBbCUCQsA
Date: Fri, 1 Dec 2023 07:31:18 +0000
Message-ID: <PH0PR12MB54177F13E8299D3B869E57538F81A@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20231130002100.113028-1-bokun.zhang@amd.com>
In-Reply-To: <20231130002100.113028-1-bokun.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bc1f0ae3-5fd7-44a9-ad48-2773b59209d5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-01T07:26:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|MW6PR12MB8664:EE_
x-ms-office365-filtering-correlation-id: d1b869fd-b6ad-4898-eb68-08dbf23f828b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7jX+dDE2K0oJ3e880WBrBfQHZCY3uVEmTNESc48X1BdWz021ShEOWycTUA3MyZdxVqlIXus8YivngfJpGJvlWfBt01Kbs0E66XlxzjuqgMo9lJoDvqBaTKW6ub8oCS0uH4u3q0deBpIcsSwBBqcJR1EYUI/FZ/a0yu/iuP8NHZ4VnYM9XKUodo3r1fUkCq6XLus3iyL1xzjAbRCxtb6AIYNYG8muYBp9K6ePdcAPCvG83ZO0r1XqlyKXnYB69QdBgDpY5M86av+1QQbe+vX7m4yBrOC3FX0GbOHKW1WlEZDMCmUEdV0Yy0PQn741f3/2mga1o801W9RZvrgAkkC1pwinpNGBvuMoQ7ibCenP2hqs3seKBAnEIW4eWahsXezLPsHB6OSYtwxb41b9UWgak4ZuARoDWT5PQIsyUTx5Hdl9SN0dZPzwI1QLSucB0+mZM2MF3rqo3VaKCdpLgZU9W6NYFrXR5apx5WdgAQV/M/PXyH/9DbRxMHYg9TRIAqECngrNQFkhMoy2hxSmyojL0EjqUUj1b2z5VynaUJ+s9FxPkqcfjZGSGswZYpNoda6Nac2VBWjdW1ipyldbItPogtPuHTjeQ/8yzeYTDNac9t5v64bzBu6txQTQozMLTSE/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(55016003)(83380400001)(26005)(478600001)(71200400001)(9686003)(7696005)(6506007)(66556008)(8936002)(76116006)(66446008)(64756008)(66946007)(66476007)(316002)(4326008)(8676002)(110136005)(38100700002)(122000001)(52536014)(5660300002)(2906002)(86362001)(41300700001)(38070700009)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U2h4zZYQpJwS9or3D3TZORz7UYx0xmLjhHGg5/tqV8+T9RohgJMuNfjXuwcS?=
 =?us-ascii?Q?BwvXKQiEl6VbKcs9fhxGVyBdAC9urJEuilHs27PnPXeZa/s39j4nezBM+uVR?=
 =?us-ascii?Q?uO64WK08UKjLbgp6+ZUJfUqgxAuPVoYkCXEcGCjJrERee7lJQSn8Ifn/u7Ey?=
 =?us-ascii?Q?cpVOluAoKIpfy6VNRQ6qi4Pmu7l36CemqiELR0hsRypagTV6YssK7styBmem?=
 =?us-ascii?Q?PtEF+hh0VJ3Ud4g+A5JZBxfnVgIZFkLwlgN991tXXrPejcKNt3Wr+RgKy1at?=
 =?us-ascii?Q?WFeggzWJyCEcNKdH+zZGDQoAqRfER5AoKeiKbLrUFY8lC1OfBg2cxRBs0LHK?=
 =?us-ascii?Q?Df1BU8Wqdsjfn3a7hueqx3oEUghsuvgmQuk2EyZYH2mv/yrk7+efQ/mg7KVK?=
 =?us-ascii?Q?ztVKaPv4zMBmR+VEbJcRyNYlWczt/kbaFnv7eJoE5GBrwx20muWisp9ky0eb?=
 =?us-ascii?Q?kFjOpFNiXYOh212MkreBqAuCz5gtFb6H0flOaIzQuNMgmfi8xhzz9g43Sl3g?=
 =?us-ascii?Q?RJmNOX++ZZwfTfblqFPlDnqhWL75zSVsA9TJMjNMTz4o8pEiU2HVJqpIaqaZ?=
 =?us-ascii?Q?cjIAwclYyiSAkf/r78uixM4RfsBAmyScS6BCVUm7ETHLcpZFqDlrLvvYeDae?=
 =?us-ascii?Q?2CsOZ+eZxmMiNpnqKkOFfkJzqa0kT4K30jf97qTFwwz8zUTh4rge2/s6PnD1?=
 =?us-ascii?Q?h4qqHC/tejNAGG+C+wdzW+ed2QUv7b/fm2wjorKz6LVQj8uCo0NsWHLVY4Na?=
 =?us-ascii?Q?fFY0i3/vI7eegHcPTjnCvLFDDDohMG4m/cYDhk7Dq6tfTusHLZTxupHtQDl1?=
 =?us-ascii?Q?1Md8ebUjPGqD+K+658hFMATY3efwa0lo30liv4jtNz1xzm/xNtUE3Y0Ex/Iu?=
 =?us-ascii?Q?TRa8z6Iy6s3AceZ5Z7XWx9GBYvqaIAxtoUX9YL8uSX4Yp5NmHFAYPNwPj/t9?=
 =?us-ascii?Q?3cmZdW5sgmX5VXiZF47t8IQX3y1+ogXaZas/tMcNWNFLMoj4DE/FJV8e+dSK?=
 =?us-ascii?Q?tWS9e6a4EZ7q//d86JMXkE8X1FPXCfxNr5F2zU81KYXcjvWa+ZsP8Ed/meez?=
 =?us-ascii?Q?Kaseg8CY57RTnuf/jJQYUeKpo16b+R9TWjfOV5179+oF/3s+WtU0M0BabXhy?=
 =?us-ascii?Q?C5X6KHrIbcrREpSFlQSlLW5obYXob9GIejn/APoQ2LSf4cdDTHpwFyywVrir?=
 =?us-ascii?Q?DvMqA7m996cks1CRC3lH/9Yz8S2FEi7VYwPXqMFnKds1NSbCTBNKpsaEzciR?=
 =?us-ascii?Q?CpqgOVRs54p0DnfVAi2BG4JDY/NQ7NeqtPyNabteWkD688TeVmKOUEF/nEqS?=
 =?us-ascii?Q?Bft9EeCNeFXoCfFrj5Apl0wWE1m1fba7IGvqUtiCFSHg7IYmcO9c9+fxXxPo?=
 =?us-ascii?Q?t+J8QgDHw4MWchdQFpjWeJRvgeSO8nIP687y+4qJ+a8efP3sUpCr9hK7w4f2?=
 =?us-ascii?Q?N+TLY9HxM7+xM0wH3VQBjg51kJr0lYhoDttIjCzgPlh+yNYWkky5c0UgqTvU?=
 =?us-ascii?Q?l18LbVIgYxbkLYWknvbhP3YZvTPCOM27PvR2zl3GPWdHtoY+7kJO+IcFNEzy?=
 =?us-ascii?Q?kjkZ9sKhQRnSn5XJLM4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b869fd-b6ad-4898-eb68-08dbf23f828b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 07:31:18.9765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Gt38N91Eu+MABu99rsVCZrL//+KRYipzxgC/wjjS7sDhvQC98ivX1x+dK8v1zXW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bokun
>Zhang
>Sent: Thursday, November 30, 2023 8:21 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
>Subject: [PATCH v2 2/2] drm/amd/amdgpu: SRIOV full reset issue with VCN
>
>- After a full reset, VF's FB will be cleaned. This
>  includes the VCN's fw_shared memory.
>
>  However, there is no suspend-resume routine for
>  SRIOV VF. Therefore, the data in the fw_shared
>  memory will be lost forever and it causes engine
>  hang later on.
>
>  We must repopulate the data in fw_shared during
>  SRIOV hw_init
>
>Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>index 54b03df63a51..b71590b67e20 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>@@ -1280,6 +1280,9 @@ static int vcn_v4_0_start_sriov(struct
>amdgpu_device *adev)
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
>
>+              // Must re/init fw_shared at beginning
>+              vcn_v4_0_fw_shared_init(adev, i);
>+
>               table_size =3D 0;
>
>
>       MMSCH_V4_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(VC
>N, i,
>--
>2.34.1

