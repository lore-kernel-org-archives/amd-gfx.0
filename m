Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F9DCA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 07:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA3910E162;
	Wed, 20 Aug 2025 07:28:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LB63D0CP";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA9510E162
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 07:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CX9T7XC/1ZBGUMUkTWeMjOqP94k7fA243efWdnZjv4MfAZAIqbXGwsI9eXtqhEA5wtKjmsHunNwDCxgojwS5N+VX6l+UbHApqaNs99oNDQEUe0/ZQQJ6EATvGnDmAM6bYs00QKJ6Lckp2ZC83KIf9NQEF+OLxJIJbop0AuHrjfGO/s4hUSuFLDBU8Qs7bRSxYMFNuWPR5lShAiVYvfC1xaSQCMTFZye7iCJFmHvs/clh9H9jIMFJffXShM26UQet0CqfkH63y4zKThejPEDFjLTSJ/9QstojoB1AXL+6lQRB2xxmvKf8m7wqxYp1ZHeIDZ8KZdrRtftxiVqaxyPotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8Sbz5gsyFJTf0czB6mwT1pJcZ/XlfVV0pMNTCEVVOo=;
 b=eXrlcGEQgQNg5hTeyky0NZfYMaSjgfRDcEk2fAJZuqjrIqBulTIQ/aImYRZDMDc7BWuTKWhUteZYHa8fiF8kYXaYQMlZNT5anNzS/lGU8C//uOpgyJiHcWP7pBPC1NSNg8JddVaPvukSm9ARgAddnjwn9LFq/BV5Ubp4p8uPG6rAhONgVnV9WdZ3nsQokSd7A2Loe6wtsFP7eunAPHUsYrTmpjGIVe26ezZggUyKyBsiOhnGL1qV2WsTYXlHPTM+Ju8eevQRk0Q5IWxoFnpEgrR4dsVqX/8tdZI1+apG07LlP4CnQLZ7D1qac4CiF7CEs3myuei7nii6J0Id6Iu4aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8Sbz5gsyFJTf0czB6mwT1pJcZ/XlfVV0pMNTCEVVOo=;
 b=LB63D0CPC5Guuwmo+hvkfmjwzkHwrQjp4mYr8/nCNeqpYr8b/PST7RK8+CMyOo7AXIMNJzSGblKNozNI0VrDa9vllRdm8/uPWO68es+CKKZtPu6w/9Fog0qeLQX4d0+oIYtZyFXbX9e36YdtFZboPTRFjL+nv/KBChso9i9YMZM=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 07:28:11 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196%4]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 07:28:11 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS
 poison injection
Thread-Topic: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS
 poison injection
Thread-Index: AQHcEMnHywYAE5JK7EKPrYQl3rwo0LRqxPUAgABBZICAAAfcgIAAFwCA
Date: Wed, 20 Aug 2025 07:28:11 +0000
Message-ID: <PH7PR12MB79886037BAE9476B8399A0C49A33A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20250819052548.124897-1-xiang.liu@amd.com>
 <20250819052548.124897-2-xiang.liu@amd.com>
 <BY5PR12MB42125F685673D0BDF0ADECBDFC33A@BY5PR12MB4212.namprd12.prod.outlook.com>
 <CY5PR12MB6345B07E614DBE882CE7FF2EFA33A@CY5PR12MB6345.namprd12.prod.outlook.com>
 <CY5PR12MB63454C06BC4FD4F4109D2A0FFA33A@CY5PR12MB6345.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB63454C06BC4FD4F4109D2A0FFA33A@CY5PR12MB6345.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-20T06:01:38.9770000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|CY5PR12MB6407:EE_
x-ms-office365-filtering-correlation-id: 67dce9ce-dbb5-4147-7fd8-08dddfbb1e0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?O4eC/HL9ye6Jg82wFi+awvTAave4olBB2IMi49xi+at0UggKjw1sv9Ng7RTa?=
 =?us-ascii?Q?I/tzTmrlHElyvnldB9RjSRJ2bcHyu9AWRieQFpe78FR4y4sXW17riaILds6L?=
 =?us-ascii?Q?0bbHbEEhGq5Wxku6FRvKxrHy+PcbVdnQyYrVhb1nQFUb/oSMjs+ALFsGONZG?=
 =?us-ascii?Q?LI51aCcU1aU5j1wi3w0yJFHJZuNbULZSadJhcMqulw+z4l5nKs/9Mq8kSgZz?=
 =?us-ascii?Q?nQKTBYCudmtA0/3J+KkyY8cMkdYeZlyIYx6sWTsGp2sKrdl7pkJ5CEeNzjd8?=
 =?us-ascii?Q?jxGqbZaLg7XDuzXq1O1NA63roNwQbwskmR2Jq25eoJtQyVEC+3F8l3iS/trg?=
 =?us-ascii?Q?dvXd3qiQ2x0Pdlrw2WzVJEzdWBu4gHHTsl2WquceEGrdyrVbLdy1cq0HZTNU?=
 =?us-ascii?Q?elhmKUgxkxCrzQJmUwCr2wLS7COUOWcMRd6X2jC5Bxj47DTCOyVRbzR4UeVX?=
 =?us-ascii?Q?zH5lqZAI+tu+0xgJg1r32s9L67JRy2jMFIjaONO1lQElDN6JL9XzRHrFlodJ?=
 =?us-ascii?Q?WLqr8te9dQ0LtA0AChdN2gHfEULGGHL7kMiOArbaXEyB3khvkV0pRgnCyBLA?=
 =?us-ascii?Q?0xAOL6af+7jueS/d80slnvLY5p+Exh7eFRuLgYAFJshsOaJLX/IUCNWIyu6f?=
 =?us-ascii?Q?uqnF6CFcLzSZkCORI3MaWOmVaf/zZvCpiWmoKtgs0gOBQh8velc0rrUxymy5?=
 =?us-ascii?Q?Y8h3VKHEVGFIcMCO35skY+hRMenzXWwVWW1QtNPrV4KD+HIRSfJJZiR58qZA?=
 =?us-ascii?Q?0aehovpNr6AWQua2dt6vW5+4USPH40VfA0DfnJ/3hrMGMu6ESGjnBbDBsRbu?=
 =?us-ascii?Q?5IMsOwdddQUEuNZISv8aPJnwhFhRJUkMqXIXT2jU9qWMiEPWAZ5/lieuhON2?=
 =?us-ascii?Q?KHP8z3uy8tJ7bUU6z8bethKK/z0OVBzRPJV1yI46bmnv/p7Jw0gvkXYA/DIW?=
 =?us-ascii?Q?X929gFxzUcD+DZ+hbSjMtKX1uXoQ+3nnNvzCd8VHAQdwsb5LU06HwRliAGR6?=
 =?us-ascii?Q?h0t6JWHK2xSJBbNznj7z4sf8JCbqx5DhF/1bu0yA91EDTy5fHac37SFtu78Y?=
 =?us-ascii?Q?9xUXBXP6CwpqH6bijyGNq4FlV8A1wVzxqGk2s1pwMYTcV1oOxfmNn6BNwqA3?=
 =?us-ascii?Q?dBJOFjDzhY8Y/vjBrrDvCL1Afh7nPcU6sfpOd38Wx2x0wQRWsm0D+INqgRuj?=
 =?us-ascii?Q?rwhyC/e0fDzLv9Yjogf1/+Q0qDfnSsvZssgW2wp7jsAiZPtxg8rxeUBCdCZ7?=
 =?us-ascii?Q?zoQXZ1gFOZq1qRLdx410dpt05RZANAqqYGOeARcx79u5bO46RAcHPLgBuQeg?=
 =?us-ascii?Q?cb/Rrqjx81XkxTkbOt4asa7ZnGFGKstQJfl0hIO49XaONmMJeFVdPaan09z2?=
 =?us-ascii?Q?OEOve540EApjPPa5InpjTf8wg4n+drUml8BvI0+xbH9TzAAZqs6f4Wv0HLXx?=
 =?us-ascii?Q?KWKsdwkyDXwwug247TpTwU1PWPbILCyXV7pHVXYN6VLqat26DGMaCjxiIo2R?=
 =?us-ascii?Q?qzjF19V8AkhfQzE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1IcEnEeeiFuzIMA4Dpz13TsvPmOBul2oTZGobSXe0CtK/5xVhrRHqd5jggOS?=
 =?us-ascii?Q?4uEB9r/4gChnlwVr0H9SAFFwlwnrIhbwNVdUkU0ByRWVmnMD2oAKQqAL/ILx?=
 =?us-ascii?Q?G3HeG6uPT2u7JkxyP7C2i45v1i/2X7eteQ0wqFMQ+V2RBMpphZjF9z/mwncC?=
 =?us-ascii?Q?Rlbc1j+rO+o1ze+hftYvMFFSzslWSfhT+9J5I6wxup/0RJtoOsNWGJ6tKXi8?=
 =?us-ascii?Q?TT36pyQuveyvYGiRlAqgSRUp50evdiKkUo98aY43L+30gd9g9bIQDzjdByxw?=
 =?us-ascii?Q?HEwhv97YcKNo0KIZNiCGBh8YhWdjXASh8lbk1qyTowVEPu/Br0Q6Jqvx4Utx?=
 =?us-ascii?Q?bpMGUSXJCpFIhk2+YhTf2xhFKbFQJH0BnI9rJj3CR1zuxJw6qL2osxH0MCJI?=
 =?us-ascii?Q?dgMkJcaP9im/V1Xx97BX8wY/LBiMB1XuZrv9ag8LQILh862iLQCtAoMsTfIk?=
 =?us-ascii?Q?cf8Dxo76oBSqGzUzA2p67egNDqLv7Vi1njhMoKf8zHr2fjU1Q88i/yZ2+z1U?=
 =?us-ascii?Q?i6pov7Y4Pgiq4Ym/fhl0u+VtAo4yP4QZgGHQER4aHb9Ghrg7XdTRzbAskH3B?=
 =?us-ascii?Q?lVjffdfoPpoOc47YgZEwFp7+CDjX/UFk3tMh3xyr+WgdysAvXKEFnZPsMDqa?=
 =?us-ascii?Q?W1Dc8Cr85QnRqifJK1e5Wp6KhDxtFbWKBnpAnOmfOXwXQFiyQCyLyhijIPzT?=
 =?us-ascii?Q?+NjdMmztKEmicoM9iqfEHI4c+i+xbwUBTZ7ImclbV+uhq+eoSAKqX8JX9YLO?=
 =?us-ascii?Q?NT/DwkMfHoNv8OOv26awJ+sNW8KXMAB16cO6Gp8myDiMGb13XIsQLhGGK+Zd?=
 =?us-ascii?Q?dy4+xgmMUTo3RMfVf2PUq9UOAP/L2W28wt1lBTqiVJ/ZdZj3LGp2B/3GjMNS?=
 =?us-ascii?Q?uPBrheqi+j50F3lQPO7WxgXNwE4he4pA3GFn9PK8dygO2r4Ls+9bfsSnPH7Y?=
 =?us-ascii?Q?Rb+mEyyn09/TjnHkNeW/7m+8LUDqzjQJZlyBOMwm46nXqhiGlKeISOWPjUdZ?=
 =?us-ascii?Q?g4ndmxC28/M85spYTlsdqkQ055vAVybi+OvpM75ckyefJkIzAdJrt83mNadw?=
 =?us-ascii?Q?uTPSjLP99YofSBcLpfv5vniPJ9LDC8eyaltirN9h61FcwTKmk1Vjp0+FaZDm?=
 =?us-ascii?Q?yhws2OBhPBhvJ/ImF5GM+KbSGqqCHTMCPYhI6oNkda1nU97KQwbakvy2qyZ+?=
 =?us-ascii?Q?RIbN/c6LHpX8sN7M6uL7nHK1ibKaqUMOfuWG9Oj2yNpUnTEinY9WZl7uDD7l?=
 =?us-ascii?Q?wPEZ8ZcRSDbkzgg78Y9+d4QBibIM6a5/nHfIEsfP+8SBxJxNxR1GmaNfwpOg?=
 =?us-ascii?Q?KxzwSQo2nOO2bMKyzGeslN19RC/oQRL4/XhYyliQxEyKizeCdTAs8meAK+G8?=
 =?us-ascii?Q?KU6efXgYGq8P158zMXiuEBEfkumKn6PcvVMAo25EFQlA/psyvKGreM7LC86I?=
 =?us-ascii?Q?Uin3YXPW16qNdJvAAit1P03X6958h6y8iDUzUR7B8pa0umTGJzXfFCa7w/FB?=
 =?us-ascii?Q?8A2EGyVgBUmXi1tpNTIhACOVaM39STihN6ScNC1zTttL+ojguap79I4kMUjq?=
 =?us-ascii?Q?OYJdVWJdZlXFq5YcjOo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB79886037BAE9476B8399A0C49A33APH7PR12MB7988namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dce9ce-dbb5-4147-7fd8-08dddfbb1e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 07:28:11.2119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hNGCGVjYBr8dUXPXPqGmqxIwvm4ka1rjFemZpuGbEMtwgZog508wWXXpN1DqqAuMfPSdK+ixL4HV02XOntw1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
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

--_000_PH7PR12MB79886037BAE9476B8399A0C49A33APH7PR12MB7988namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

All checking work should be done in host side, not only check current vf cr=
itical region but also other vf critical region.
For example, in extreme cases, current row memory addresses may be in other=
 vfs critical region, please handle this case in host side.

Regards,
Stanley
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Wednesday, August 20, 2025 2:02 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS po=
ison injection


[AMD Official Use Only - AMD Internal Distribution Only]

Hi,
As discuss offline with Thomas, will check the VF critical address regions =
of guest in another patch as a new feature.

Regards,

Liu, Xiang

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Liu, Xiang(Dean) <Xiang.Liu@amd.com<m=
ailto:Xiang.Liu@amd.com>>
Sent: Wednesday, August 20, 2025 1:33 PM
To: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley <Sta=
nley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>
Subject: Re: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS po=
ison injection


[AMD Official Use Only - AMD Internal Distribution Only]

Hi Thomas,
Sure, will do, thanks.

Regards,

Liu, Xiang

________________________________
From: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>
Sent: Wednesday, August 20, 2025 9:39 AM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com<mailto:Xiang.Liu@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley <Sta=
nley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>
Subject: RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS po=
ison injection

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com<mailto:Xiang.Liu@amd.com>>
Sent: Tuesday, August 19, 2025 1:26 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley <Sta=
nley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>; Chai, Thomas <YiPeng.Chai@=
amd.com<mailto:YiPeng.Chai@amd.com>>; Liu, Xiang(Dean) <Xiang.Liu@amd.com<m=
ailto:Xiang.Liu@amd.com>>
Subject: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS poison=
 injection

Check VF critical region before RAS poison injection to ensure that the poi=
son injection will not hit the VF critical region.

Signed-off-by: Xiang Liu <xiang.liu@amd.com<mailto:xiang.liu@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b00cbb927ca8..6730de574fdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -219,10 +219,17 @@ static int amdgpu_check_address_validity(struct amdgp=
u_device *adev,
        struct amdgpu_vram_block_info blk_info;
        uint64_t page_pfns[32] =3D {0};
        int i, ret, count;
+       bool hit =3D false;

        if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
                return 0;

+       if (amdgpu_sriov_vf(adev)) {
+               if (amdgpu_virt_check_vf_critical_region(adev, address, &hi=
t))
+                       return -EPERM;
+               return hit ? -EACCES : 0;

[Thomas]Only checking if the address is within the PF critical address regi=
ons may be not sufficient,
          The VF critical address regions of guest may be also need to be c=
hecked.

+       }
+
        if ((address >=3D adev->gmc.mc_vram_size) ||
            (address >=3D RAS_UMC_INJECT_ADDR_LIMIT))
                return -EFAULT;
--
2.34.1

--_000_PH7PR12MB79886037BAE9476B8399A0C49A33APH7PR12MB7988namp_
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.elementtoproof, li.elementtoproof, div.elementtoproof
	{mso-style-name:elementtoproof;
	margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
p.xelementtoproof, li.xelementtoproof, div.xelementtoproof
	{mso-style-name:x_elementtoproof;
	margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
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
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">All checking work should be done in hos=
t side, not only check current vf critical region but also other vf critica=
l region.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">For example, in extreme cases, current =
row memory addresses may be in other vfs critical region, please handle thi=
s case in host side.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Stanley</span><o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Liu, Xiang(Dean) &lt;Xiang.Liu=
@amd.com&gt;
<br>
<b>Sent:</b> Wednesday, August 20, 2025 2:02 PM<br>
<b>To:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: Check VF critical region before=
 RAS poison injection<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Hi,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">As discuss offline with Thomas, will ch=
eck the VF critical address regions of guest in another patch as a new feat=
ure.<o:p></o:p></span></p>
</div>
<p class=3D"elementtoproof" style=3D"background:white"><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">Regards=
,</span><o:p></o:p></p>
<p class=3D"elementtoproof" style=3D"background:white"><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#242424">Liu, =
Xiang</span><o:p></o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> amd-gf=
x &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">amd-gfx-boun=
ces@lists.freedesktop.org</a>&gt;
 on behalf of Liu, Xiang(Dean) &lt;<a href=3D"mailto:Xiang.Liu@amd.com">Xia=
ng.Liu@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, August 20, 2025 1:33 PM<br>
<b>To:</b> Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.C=
hai@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.c=
om">Tao.Zhou1@amd.com</a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.=
Yang@amd.com">Stanley.Yang@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: Check VF critical region before=
 RAS poison injection</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Hi Thomas,&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Sure, will do, thanks.<o:p></o:p></span=
></p>
</div>
<p class=3D"xelementtoproof" style=3D"background:white"><span style=3D"font=
-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">Regard=
s,</span><o:p></o:p></p>
<p class=3D"xelementtoproof" style=3D"background:white"><span style=3D"font=
-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#242424">Liu,=
 Xiang</span><o:p></o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Chai, =
Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai@amd.com</a>&g=
t;<br>
<b>Sent:</b> Wednesday, August 20, 2025 9:39 AM<br>
<b>To:</b> Liu, Xiang(Dean) &lt;<a href=3D"mailto:Xiang.Liu@amd.com">Xiang.=
Liu@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.c=
om">Tao.Zhou1@amd.com</a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.=
Yang@amd.com">Stanley.Yang@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before=
 RAS poison injection</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"x_BM_BEGIN=
"></a><span style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quo=
t;,serif">[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
-----Original Message-----<br>
From: Liu, Xiang(Dean) &lt;<a href=3D"mailto:Xiang.Liu@amd.com">Xiang.Liu@a=
md.com</a>&gt;<br>
Sent: Tuesday, August 19, 2025 1:26 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zha=
ng@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao=
.Zhou1@amd.com</a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.Yang@am=
d.com">Stanley.Yang@amd.com</a>&gt;; Chai, Thomas &lt;<a href=3D"mailto:YiP=
eng.Chai@amd.com">YiPeng.Chai@amd.com</a>&gt;;
 Liu, Xiang(Dean) &lt;<a href=3D"mailto:Xiang.Liu@amd.com">Xiang.Liu@amd.co=
m</a>&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS poison=
 injection<br>
<br>
Check VF critical region before RAS poison injection to ensure that the poi=
son injection will not hit the VF critical region.<br>
<br>
Signed-off-by: Xiang Liu &lt;<a href=3D"mailto:xiang.liu@amd.com">xiang.liu=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++<br>
&nbsp;1 file changed, 7 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index b00cbb927ca8..6730de574fdc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -219,10 +219,17 @@ static int amdgpu_check_address_validity(struct amdgp=
u_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vram_block_info bl=
k_info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_pfns[32] =3D {0};<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret, count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool hit =3D false;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, UMC_=
HWIP, 0) &lt; IP_VERSION(12, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_virt_check_vf_critical_region(adev, address, &amp;hit=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EPERM;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return hit ? -EACCES : 0;<br>
<br>
[Thomas]Only checking if the address is within the PF critical address regi=
ons may be not sufficient,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The VF critical addr=
ess regions of guest may be also need to be checked.<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((address &gt;=3D adev-&gt;gm=
c.mc_vram_size) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (address=
 &gt;=3D RAS_UMC_INJECT_ADDR_LIMIT))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EFAULT;<br>
--<br>
2.34.1</span><span style=3D"font-family:&quot;Times New Roman&quot;,serif">=
<o:p></o:p></span></p>
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

--_000_PH7PR12MB79886037BAE9476B8399A0C49A33APH7PR12MB7988namp_--
