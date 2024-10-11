Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3BBD0EE12
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 16:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A038F10E033;
	Fri, 11 Oct 2024 16:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vd++0QIj";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AEFA10E033
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 16:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yq+sLymXRa1Hi5fNJRC/RVeFCzExhhrjc6a+T9Sz+upkSDXAj/xh9SXSZTeziIc9XT1pgA3B1BcwCuA+ne0u4wKSG5Y/3anb9oJ8znAFIVcvouTnH2S2kEuZnadso0c2/MWd/KRstb9rp868siJY/4Rnd4/wyXNZjj4iH9WElkLtM/pGHaDqhyTJPPnPvHr1so3Ijm+EGvSvAwOic0Ct2SEc223C8uVER+BKm2lAob7NR5JtE8iKkdT64RPvEkAwvYyvY1Q5oEkYaN3uGDdr4vfTLygQG4tyFki6wnIwDtKhCJ6akTGPFNFD1gsKJmrQtOynl67uTPSGlDXmT3tibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+TEuTCB5QShlDUU2LZbEcDP+yhFu58fGNX8bBh9mfc=;
 b=yemI+trAyXDuwxeQezLRCw9VNMgYhNkqqjb5kImMhLDKNlNO7uGO19ePsh5WhnCyuaNtSSzHuzHcoizgnEme0lwice15hJkIXQ0b+i+vLp2Pc93sxGj7ybhbtGWWZB1JBr29kOBtFhlU4GQUEyN5GWcSkMxPkt/a2otW2dZHK9UoTxoZvNfXIkDxTSX8k37CIk3jMcEsxxbQfhhg2CXZ2aDVUOXn1KGAAVeho8/GBUXyQEjL+z8wTcIZ85CSYa/CyYPYAPTeUlUru+tws/JsOCl8UOcFUPb9tlyb/u80fjVM07IC/wEm3NTrFcQNcXXou9T0Hia4k0gDHZxUAaj0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+TEuTCB5QShlDUU2LZbEcDP+yhFu58fGNX8bBh9mfc=;
 b=Vd++0QIjYGTLup2LY7P6upKJLwo2xdrTlsNGtt9OM6aFbfleA+GEEoMx17BGU5xFgMEPe/nw68czdwEcAi1P5ITkeri5ebRFBnjeXOQt7P+KCd6TZypO1X5U5ycEoSXWPjvKmV1yhl7FwQepJVfRl15pvYgUyUehxukesmEEsN8=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 16:21:25 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%7]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 16:21:25 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Li, Yunxiang (Teddy)"
 <Yunxiang.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdkfd: pause autosuspend when creating pdd
Thread-Topic: [PATCH v2 2/2] drm/amdkfd: pause autosuspend when creating pdd
Thread-Index: AQHbGy/40YzDgh5dyESdZoLWW6e6NrKBpVyQgAAFkICAAA5HAA==
Date: Fri, 11 Oct 2024 16:21:25 +0000
Message-ID: <BL3PR12MB6425FF1BA1BAA4226B7D8D75EE792@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20241010151831.10859-1-Yunxiang.Li@amd.com>
 <20241010161730.13416-1-Yunxiang.Li@amd.com>
 <20241010161730.13416-2-Yunxiang.Li@amd.com>
 <BL3PR12MB642501535A7BEEBBBB32C54DEE792@BL3PR12MB6425.namprd12.prod.outlook.com>
 <3d0053a5-efa2-497b-8316-8e0ec571bf2b@amd.com>
In-Reply-To: <3d0053a5-efa2-497b-8316-8e0ec571bf2b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ae4349b4-6dff-4f23-a91f-bd2b4ee19f7b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-11T16:08:19Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|MN2PR12MB4376:EE_
x-ms-office365-filtering-correlation-id: fc2167bb-4bb4-40b9-8cba-08dcea10c0fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MThkZmtmaEF2dkVBUzh0NXVJRFJjSThzeEExMWFzZnZ0U1JSZm81STZmSGhM?=
 =?utf-8?B?N3V5aEFUbFlDSzNtYS9ac1JWRjBBcE81MWkzbWo0dm5kcjZOTFRKN0g3b2FN?=
 =?utf-8?B?dTc3RXNRbmpBSkQxcDVRS0pGMGFqeVZKUm50dmxWdXNkbDdzK3FMU3NkT0pS?=
 =?utf-8?B?RmpUOTNnK1R1QXI4K2xLTmlncUFHazU0L21OY05ZZXhCaWtrL0w0cXp0a3BQ?=
 =?utf-8?B?UTFodUZWbmZXZVl1VlNNc0hucFhIMlIvbzZSa1VJRTJkbnkwZmdWWTk3bExj?=
 =?utf-8?B?V1JodnUrRTZJd2tpaWpJc2Fvamx5ZnJQZTgwd0dzdUs4eWdYY29lTWJXandS?=
 =?utf-8?B?TlMzbzM0d3hKUTRhMU85Z0FlRUhDNDN0NEV5bzhCVHNrdWdvb0RJcTdyOVh5?=
 =?utf-8?B?M0o2bjFrc1JtNnBqZUtPWW5NLzg5QTc2akZveFFjRlBHTjhBYVZQcTBJTFpa?=
 =?utf-8?B?VUNRbm9HZDNMdVo0MFZWcm8zSENUaTBWKy9TamtiV3hDYUUrSjVDRUpaNnNK?=
 =?utf-8?B?dGp5eTVHY3ZUQUNlTk9uTjI0RjZ2T2FiTnU3YXVUQUlGVzVTSmJJTzRUS241?=
 =?utf-8?B?Z2kyemJsNTZta2tXUjIvRzZEZThJTWQ5WjNZMnplblZUdDdoOWhyZ1BhNXFy?=
 =?utf-8?B?elZrTDI3U3JkWEl1UG1ZZkwxL0E4ci9Dc001cUJHSGpaOVRqQnJMU3d1UDlJ?=
 =?utf-8?B?NEc1cWZGdDN6V3pQYXlWYk1FbzJpUkRocGpHMVdqeDE5ZkUxUXh2Q1hOZkpS?=
 =?utf-8?B?OHpNMnpyTmxxMEp5ay9xdFh3K1U0eDFCWjFHMGViL3FVMU9ISEtGYnVrbms2?=
 =?utf-8?B?czZKeEtwUkd2S0VMVUFYTUZTNEVuS0JURjBTMzA1T1k5bDdLNG5Zek9NbE5U?=
 =?utf-8?B?WHBzK2MzV1ZiTTVaTW9aNTkwcllMeWRXaU9qMGhaTExxU0VFN3dSam96YXhI?=
 =?utf-8?B?eUNEOC9malh2emc2eU5nYVcyeXNOUTJ3NmFWTDBYZEN2UXdaNElHdTFYZzY5?=
 =?utf-8?B?ZlhsbUkzQ0VRUDRRVnBncUt5WTRNa0kycDNsZE1qVkVLTzJjZDJnS3VTUUY4?=
 =?utf-8?B?bjF3b0NaaEw2N3dqSTdkWXNQYW8zM1h6NytZd1hJa01DQ2xtK2JCdkh6cmQr?=
 =?utf-8?B?Rmw0WWRVUzFTYlJGVCtjK1Y2U0ZrRFVBdC80SHlKMXFIR3lrb0RNQldkL3JP?=
 =?utf-8?B?SEZYc0dER284c0ttWXYxZU5wQmFacmxJVmhGbktYT3FndXFTR1BXKzVJZHVk?=
 =?utf-8?B?TEFwRzloRms2MWVDMXhMQ3lKc0Z5N1A1NjM5REhYc3N1MytKK093cTFDdUo0?=
 =?utf-8?B?dUp2Zzh1QkdOeWxkU1FKQ1lFcU5MaGNGTU9KdWc1RkRuQmRleVNWU2JGdnJJ?=
 =?utf-8?B?N0llVXAzQmhTdUQ4dTY2Q2JFbWM2aFVDNDQ2Z2hzWVpVdzFiQlB3NE9IVnNS?=
 =?utf-8?B?S1ljcHV6Q2RnZTdaL0w4cHUwSXlCTk03YmJBWWlRWnNhRER4bEQ5dHQxQ2xz?=
 =?utf-8?B?Y1RnWlMyT2VLQ2Fna3N4a1cxelhVdUJTaFU5QmJnQ1VlYTZleVBkRitRZ0RM?=
 =?utf-8?B?WkdJTXBtRk9ZTjVURExiWmlKVHRyMFFSMm5VSFNiZS9nTHY1YzZDdWdsVFk0?=
 =?utf-8?B?d0hWbkxWRHUwbXMvVHUwaVJhUmFSSEtNL3FNcHA2dnJ0MmFaaFpjVDVwMERK?=
 =?utf-8?B?Z3lwM1FubE9wQi9ZTlhVVjhqbTdtZXNKam9DY1R4TytTMlM4Y0ppdGd2UGJv?=
 =?utf-8?B?Y1VwOEM1SVhnMVVkRmVOZWlYL2JKREQvb2xkMXNDK1RhanhZb2FVd3Rmbmpo?=
 =?utf-8?B?M3pMZW1OY2tCOFNMbVN0UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K00vSnVQMmRrSWdkU2JHa2FCb3A3eVhYUmdQanRjYVFZaGRsS1BQWW81eWFy?=
 =?utf-8?B?SkxNbk13eHJIUUZTeTl4TVNvdFNIT3JOcXdVVnFBcnNkcTNCK3BTYkg3ak9Z?=
 =?utf-8?B?cURuR1NQV2NJYWtsMnBVSnlaUEsvcU41NHc0TDBlbFV5dmhhbUxTTEFBSFBa?=
 =?utf-8?B?QlNaaHp2dE11VGt6N1dHVTIrTmtPVXR6ZU0rRHpvRzJSQTFjNnl5TW9jbDYz?=
 =?utf-8?B?RVJ4TUJheHNWOU9vMG42YnNwQ3dzb0xCeVZBMTJMZkh1d3NpU3dnY1M1M241?=
 =?utf-8?B?Ly8xblB5czJCRnYwTDJIYWtjaDBGSVdacGRoWUlNZnAxNVBRaHdlWHJhTGRh?=
 =?utf-8?B?dXhweGRVOTJnaTFYa3FQb3ZCQnZLYnMxMVh6dG9IYkFzM3dXeEZORzV1MDRL?=
 =?utf-8?B?RDVXMy9XckNhTytMVExDTTl5dmN0WVpWbC9iZnZodlR0ZkJDSjRZS1g4WWw3?=
 =?utf-8?B?c2NHVkNWRUFndllmcDc0eTN1UTFySU5pNjZVR0djSkFXVWxGSWFYaFRxNmtS?=
 =?utf-8?B?ODd3QnhEeGhrb3VpVkJsbGFkQ24rallDUlFxWTFpZGVTYUVUSzhBcmJzSk5l?=
 =?utf-8?B?eVB0OUNXQy8yMDdYcGNLSjk5R1RwTzF1RE9GblQvbFpaM2cwL2t4UmppTE9x?=
 =?utf-8?B?Ynh2TVB4Rzh2MDFyU1poYnNjT0NSZHNuZncxUVJxT3l0SGJDOG5neTVnQ2l2?=
 =?utf-8?B?SG1BaTVaYXIwTWFlR3FXanBTSXpaSDcyNXNkdWxSUG1ocmFndFJWNDJNaFdD?=
 =?utf-8?B?eEVxTnVlRlcyT2pTVXR5UytER2ZnVWgramp0N0h0S21Ob0VYTXh2WG1mcFVO?=
 =?utf-8?B?M2VFcG9PMGMreXZ2Q2d2SUdoWUxsY1M4NEZodjJxNUNjVmlLaGpHR3hyeW1I?=
 =?utf-8?B?Y0NST2pkUU4zK2ZnUkVTYlRoM0F3MFhGL0ZPTmg3akkxTDJEcUV1eVRsM09J?=
 =?utf-8?B?b3dPRFBFT0F4MnBzemZ5TW5SaWZuTXUvTHlFU1hlbXZCN0NYblZad0dZdmda?=
 =?utf-8?B?ZmpIL01mWUhGekhDVndmZDBSQzlDTldaUjFmWjVManBpOUU4TW5CTjVQUjNs?=
 =?utf-8?B?MmZVRVZHNmhMcjA1VXdiYkZWWUtncStWTERCM2IyWmJnNEtMUlRROWxNVVpt?=
 =?utf-8?B?aG9SdWcvZ0c0UXBjNGJ4MHNDWWptOWhYZkxTQ1RCMDRYcGlOZGtRdnoxN2x0?=
 =?utf-8?B?cUZpSnA2Q0t2YnQveEJkdEVHWjBNN1N6ZFlFRjZhRFlMZzdodkJYdWlNdENT?=
 =?utf-8?B?SUtlT0ZqaHJrcG9mbFFKZ2xIOWp2aDB3eldHeFRFaDV3V3RaMktvYWJFT3RM?=
 =?utf-8?B?ZHBxQlBpMFl2RVhONDlCTE9XUHpnVjZDVjhXZTdyZW96V0NFeEhMaWVDamxu?=
 =?utf-8?B?WXVZL2QzcC9kOUJydXJBNXViaTRScUZxcGd4RUFqbFc1SmRRZkpxblM3NWcw?=
 =?utf-8?B?SGpSVXdBb2VlMkgwV2NiS2lScWtFZ3V3OUtObW8zWDYwQVU4MkJFRHJJcmND?=
 =?utf-8?B?WW4xTkZlaEg0WXdVdUgrcWpEZ1FheDJrVnJuOFBXMC9yeE9Gc2ljNUYxZjdD?=
 =?utf-8?B?d3pYY0M0cmZHUUEyT0lYcWh5dFQxL1Z1eTNuYlBqMlhLNFlDZjZTeVpiSUht?=
 =?utf-8?B?MnpYbTZXbTV3all0MWx4T1BzR2grTzErNTc1TkVnc2o0bEh2dmVGWE1yMkZw?=
 =?utf-8?B?OC95SXZsTUI1cTk4RG1wYW0zejRQK0tSTHNWWFozMWlQTjdFTkZ2RlB5Szlv?=
 =?utf-8?B?ZFJqQzJ5YWZzVk1ZZlhidStmcjV2OUViRUc2NmdwOWxLbjhBb2dVVkhabjRm?=
 =?utf-8?B?QVYyeE1Hc3hTOUVSR2htOGFqZlBXT08zc29YUDljNk9Ka05nZFdrRXY4OVds?=
 =?utf-8?B?cTJyNko0cVJzVFRJMElSaFl4K2ZKcEQxcmx3d3VJTVpnZUhiNFNLSFNYOWR4?=
 =?utf-8?B?R1duaTZ3NW9xcVNzVHNnT0NJeXBDNUp6S1VKWnVlYmRSNytsVWZyWTA4ZlU1?=
 =?utf-8?B?eW0wWlRxOFR3NWJnODZSZHRrRytJUTNEdlpLbldFcDFoOXZ1SHJvVUJ1bm9r?=
 =?utf-8?B?SE1ROGU0WFgvZlczR1FOYlB4YWltcEdsMm9KTVFFaTZCSXFUbHFIeWlkZVB3?=
 =?utf-8?Q?klCY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2167bb-4bb4-40b9-8cba-08dcea10c0fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 16:21:25.7182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0544ZSg0ZkeqozJoWlpFXIbQBRkwTuu+zIz+u+1tEJBhs8DoNbM1tnMAte7Nlcpq29WhdZ0JB3n0ULfRre7eyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGluZywgRmVsaXgg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAxMSwgMjAy
NCAxMToxNyBBTQ0KPiBUbzogSm9zaGksIE11a3VsIDxNdWt1bC5Kb3NoaUBhbWQuY29tPjsgTGks
IFl1bnhpYW5nIChUZWRkeSkNCj4gPFl1bnhpYW5nLkxpQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT47IEd1aSwgSmFjayA8SmFjay5HdWlAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAyLzJdIGRybS9hbWRrZmQ6IHBhdXNlIGF1dG9zdXNwZW5kIHdoZW4gY3JlYXRpbmcgcGRk
DQo+DQo+DQo+IE9uIDIwMjQtMTAtMTEgMTE6MDcsIEpvc2hpLCBNdWt1bCB3cm90ZToNCj4gPiBb
QU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0K
PiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IGFtZC1nZngg
PGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiA+
PiBZdW54aWFuZyBMaQ0KPiA+PiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAxMCwgMjAyNCAxMjox
OCBQTQ0KPiA+PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hy
aXN0aWFuDQo+ID4+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBHdWksIEphY2sgPEphY2su
R3VpQGFtZC5jb20+OyBMaSwNCj4gPj4gWXVueGlhbmcNCj4gPj4gKFRlZGR5KSA8WXVueGlhbmcu
TGlAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENIIHYyIDIvMl0gZHJtL2FtZGtmZDogcGF1
c2UgYXV0b3N1c3BlbmQgd2hlbiBjcmVhdGluZw0KPiA+PiBwZGQNCj4gPj4NCj4gPj4gV2hlbiB1
c2luZyBNRVMgY3JlYXRpbmcgYSBwZGQgd2lsbCByZXF1aXJlIHRhbGtpbmcgdG8gdGhlIEdQVSB0
bw0KPiA+PiBzZXR1cCB0aGUgcmVsZXZhbnQgY29udGV4dC4gVGhlIGNvZGUgaGVyZSBmb3Jnb3Qg
dG8gd2FrZSB1cCB0aGUgR1BVDQo+ID4+IGluIGNhc2UgaXQgd2FzIGluIHN1c3BlbmQsIHRoaXMg
Y2F1c2VzIEtWTSB0byBFRkFVTFQgZm9yIHBhc3N0aHJvdWdoIEdQVQ0KPiBmb3IgZXhhbXBsZS4N
Cj4gPj4NCj4gPj4gQWxzbywgY2hhbmdlIHRoZSBvdGhlciBwbGFjZSB3aGVyZSB3ZSBwYXVzZSBz
dXNwZW5kIHRvIHVzZSB0aGUNCj4gPj4gY2xlYW5lciBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0
IGhlbHBlci4NCj4gPj4NCj4gPj4gRml4ZXM6IGNjMDA5ZTYxM2RlNiAoImRybS9hbWRrZmQ6IEFk
ZCBLRkQgc3VwcG9ydCBmb3Igc29jMjEgdjMiKQ0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBZdW54aWFu
ZyBMaSA8WXVueGlhbmcuTGlAYW1kLmNvbT4NCj4gPj4gLS0tDQo+ID4+DQo+ID4+IEl0IGlzIHVu
Y2xlYXIgdG8gbWUgaWYga2ZkX3Byb2Nlc3NfZGVzdHJveV9wZGRzIGFsc28gaGF2ZSB0aGlzDQo+
ID4+IHByb2JsZW0sIG9yIGlzIGZyZWVpbmcgZ3R0IG1lbSBndWFyYW50ZWVkIHRvIHN1Y2NlZWQg
ZXZlbiB3aXRoIHRoZSBHUFUgaW4NCj4gc3VzcGVuZC4NCj4gPj4NCj4gPj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMgfCAxMyArKysrKysrKystLS0tDQo+ID4+ICAx
IGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0K
PiA+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMNCj4gPj4gaW5k
ZXggYzljZTk1YmMzZWM4ZS4uYzNkNTEwZjFkYWJmYSAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiA+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+ID4+IEBAIC0xNjMzLDEyICsxNjMzLDE5
IEBAIHN0cnVjdCBrZmRfcHJvY2Vzc19kZXZpY2UNCj4gPj4gKmtmZF9jcmVhdGVfcHJvY2Vzc19k
ZXZpY2VfZGF0YShzdHJ1Y3Qga2ZkX25vZGUgKmRldiwNCj4gPj4gICAgICAgYXRvbWljNjRfc2V0
KCZwZGQtPmV2aWN0X2R1cmF0aW9uX2NvdW50ZXIsIDApOw0KPiA+Pg0KPiA+PiAgICAgICBpZiAo
ZGV2LT5rZmQtPnNoYXJlZF9yZXNvdXJjZXMuZW5hYmxlX21lcykgew0KPiA+PiArICAgICAgICAg
ICAgIHJldHZhbCA9IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoYmRldik7DQo+ID4+ICsgICAg
ICAgICAgICAgaWYgKHJldHZhbCA8IDApIHsNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgIHBy
X2VycigiZmFpbGVkIHRvIHN0b3AgYXV0b3N1c3BlbmRcbiIpOw0KPiA+PiArICAgICAgICAgICAg
ICAgICAgICAgZ290byBlcnJfZnJlZV9wZGQ7DQo+ID4+ICsgICAgICAgICAgICAgfQ0KPiA+DQo+
ID4gSSBhbSBub3QgMTAwJSBzdXJlIGlmIGl0IG1ha2VzIHNlbnNlIHRvIHJlc3VtZSBoZXJlIGFu
ZCB0aGVuIHB1dCBpdA0KPiA+IGJhY2sgb24gc3VzcGVuZCBxdWV1ZSBhZnRlciB0aGUgYWxsb2Nh
dGlvbi4gQW5kIHRoZW4gYWdhaW4gY2FsbA0KPiBwbV9ydW50aW1lX3Jlc3VtZSBpbiBrZmRfYmlu
ZF9wcm9jZXNzX3RvX2RldmljZSgpLg0KPiA+IE1heWJlIHlvdSBjYW4gc2V0IHBkZC0+cnVudGlt
ZV9pbnVzZSA9IHRydWUgaGVyZSBpdHNlbGYgYW5kIG5vdCBjYWxsIHRoZQ0KPiBwbV9ydW50aW1l
X3B1dF9hdXRvc3VzcGVuZCBoZXJlLg0KPiA+DQo+ID4gSSB3aWxsIHByb2JhYmx5IGxldCBAS3Vl
aGxpbmcsIEZlbGl4IGNvbW1lbnQgb24gdGhpcy4NCj4NCj4gSSBkb24ndCB0aGluayB3ZSB3YW50
IHRvIHNldCBwZGQtPnJ1bnRpbWVfaW51c2UgaGVyZS4gVGhhdCB3b3VsZCBtYWtlIGFsbCBHUFVz
DQo+IGxpa2UgdGhleSdyZSBhbHdheXMgaW4gdXNlLCBubyBtYXR0ZXIgaWYgdGhlIGFwcGxpY2F0
aW9uIGlzIGFjdHVhbGx5IHVzaW5nIHRoZW0uIEkgdGhpbmsNCj4gdGhpcyBwYXJ0IG9mIHRoZSBj
aGFuZ2UgaXMgT0suDQo+DQpPayB0aGFua3MuIEkgZ290IGNvbmZ1c2VkIGFuZCB0aG91Z2h0IHdl
IHdvdWxkIGNhbGwga2ZkX2JpbmRfdG9fcHJvY2VzcygpIGV2ZXJ5dGltZS4NCkJ1dCB0aGF04oCZ
cyBub3QgdGhlIGNhc2UuDQoNCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gTXVrdWwNCj4gPg0KPiA+
PiAgICAgICAgICAgICAgIHJldHZhbCA9IGFtZGdwdV9hbWRrZmRfYWxsb2NfZ3R0X21lbShhZGV2
LA0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1E
R1BVX01FU19QUk9DX0NUWF9TSVpFLA0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJnBkZC0+cHJvY19jdHhfYm8sDQo+ID4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcGRkLT5wcm9jX2N0eF9ncHVfYWRkciwN
Cj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZwZGQt
PnByb2NfY3R4X2NwdV9wdHIsDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBmYWxzZSk7DQo+ID4+ICsgICAgICAgICAgICAgcG1fcnVudGltZV9tYXJr
X2xhc3RfYnVzeShiZGV2KTsNCj4gPj4gKyAgICAgICAgICAgICBwbV9ydW50aW1lX3B1dF9hdXRv
c3VzcGVuZChiZGV2KTsNCj4gPj4gICAgICAgICAgICAgICBpZiAocmV0dmFsKSB7DQo+ID4+ICAg
ICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGJkZXYsDQo+ID4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJmYWlsZWQgdG8gYWxsb2NhdGUgcHJvY2VzcyBjb250ZXh0DQo+ID4+IGJv
XG4iKTsgQEAgLQ0KPiA+PiAxNzY4LDExICsxNzc1LDkgQEAgc3RydWN0IGtmZF9wcm9jZXNzX2Rl
dmljZQ0KPiA+PiAqa2ZkX2JpbmRfcHJvY2Vzc190b19kZXZpY2Uoc3RydWN0IGtmZF9ub2RlICpk
ZXYsDQo+ID4+ICAgICAgICAqIHBkZCBpcyBkZXN0cm95ZWQuDQo+ID4+ICAgICAgICAqLw0KPiA+
PiAgICAgICBpZiAoIXBkZC0+cnVudGltZV9pbnVzZSkgew0KPiA+PiAtICAgICAgICAgICAgIGVy
ciA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoYmRldik7DQo+ID4+IC0gICAgICAgICAgICAgaWYgKGVy
ciA8IDApIHsNCj4gPj4gLSAgICAgICAgICAgICAgICAgICAgIHBtX3J1bnRpbWVfcHV0X2F1dG9z
dXNwZW5kKGFkZXZfdG9fZHJtKGRldi0+YWRldiktDQo+ID4+PiBkZXYpOw0KPiA+PiArICAgICAg
ICAgICAgIGVyciA9IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoYmRldik7DQo+DQo+IEkgZ290
IGNvbmZ1c2VkIGhlcmUsIGxvb2tpbmcgYXQgdGhlIG51bWJlciBvZiBpbnRlcmZhY2VzIGF2YWls
YWJsZSBpbiB0aGUgcG1fcnVudGltZQ0KPiBoZWFkZXIgZmlsZS4gVGhlcmUgc2VlbSB0byBiZSBt
YW55IHdheXMgdG8gZG8gdGhlIHNhbWUgdGhpbmcuIFRoZXJlIG1heSBiZQ0KPiBzdWJ0bGUgZGlm
ZmVyZW5jZSBiZXR3ZWVuIHRoZW0uIEl0J3Mgbm90IG9idmlvdXMgdG8gbWUgdGhhdCB0aGlzIGNo
YW5nZSBpcyBjb3JyZWN0IG9yDQo+IGhhcm1sZXNzLg0KPg0KSSB0aGluayBpdCBpcyBPSy4gVGhl
IGZ1bmN0aW9uIGRlc2NyaXB0aW9uIGFib3ZlIHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBzYXlzIHRv
IGNvbnNpZGVyIHVzaW5nDQpwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KCkgaW5zdGVhZC4NCg0K
UmVnYXJkcywNCk11a3VsDQoNCj4gUmVnYXJkcywNCj4gICBGZWxpeA0KPg0KPg0KPiA+PiArICAg
ICAgICAgICAgIGlmIChlcnIgPCAwKQ0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IEVSUl9QVFIoZXJyKTsNCj4gPj4gLSAgICAgICAgICAgICB9DQo+ID4+ICAgICAgIH0NCj4gPj4N
Cj4gPj4gICAgICAgLyoNCj4gPj4gLS0NCj4gPj4gMi4zNC4xDQo+ID4NCg==
