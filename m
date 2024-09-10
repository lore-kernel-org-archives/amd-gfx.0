Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B35ECE564
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 14:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9F910E80E;
	Tue, 10 Sep 2024 14:05:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E3EYb4Ox";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99BE310E80E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 14:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFO9FTi6X2Dxc6gI4lXrcAsYdFpK+l1JD+u1BpAcmuFpThi52vX17N9qIxo2U4NPIX8G5lBl/jYrZ5wDMyu/M0EnfxNoLWILUkLkmehzMHdCNyUNLgRAbMc0Kam81J+jnWKWlrDhAIQuyusSqDIPwCCNB5ViDh1dyuq6SPSfEQNeY8RPYdWI+o87oKZjvbWdn1lJBagyOX7eNTvkB7Ny7L33DJwAWAKj0T+FlDX69pXwxfhEzHCsSmxuVLEhEm2UIaGphznZ471vy6z0XkIRrPRQKiLaflOz9noFQFlBTGZ0n9QNZOiobaNIREM0mkJr556egDoBrCVzL7bm5GI7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dr7ChQ70wCmoAtNrawBNT1Yte5tgYrHa9Ir7ax6iNBk=;
 b=KYc9vkDsTWTUJD7oS00dcQ05EvCMI8pGmP6sluKfwBi6znxgpKZQ0L6wHMswT0uvIurqljNBv/fY6Q2cnAZ/cfPY414LaX5u+sTVGqNxNHNwa/qqY5o/12TNmS+Lg7mpfl8WzTp+hqJFDRz+OCpFBLx7XrhIA3exskkcPAoLRx/ARSP+KwQPdu1MADAT3HVJSTu/efZy6AFILsYendar5vVWBmvnml/BnjYAquoEvxWLuWIO+V6SuJEPIE0u+KuHOZMU99tosebkIG6Fi+rmqC5Osf+23iWh6jB/xjf0pf5icJEGLEc+IDoyZEdoXQbOvkaJSc3kMDCEW5frL3goaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr7ChQ70wCmoAtNrawBNT1Yte5tgYrHa9Ir7ax6iNBk=;
 b=E3EYb4OxQWkpEWGtcscViRAKVo1GGbbjlwwYDWM7e2PiBwYy3+xk7OZmzyYps+N87fIOgFjpE0/fSzaOZr6wtwBkg1iB2KWwKsrXLwbcA0gIq9dVKul7IrT8ZLiPeMF77jwBOOp6rS9LgpoH82/N13u9Q5xCC2m8LvwFvq4aw6M=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 14:05:47 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 14:05:47 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Russell, Kent" <Kent.Russell@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Retry i2c transfer once if it fails
Thread-Topic: [PATCH 2/2] drm/amdgpu: Retry i2c transfer once if it fails
Thread-Index: AQHbA4aXZTNe1rYRVUGjuLZZXOaKTrJRDUbQ
Date: Tue, 10 Sep 2024 14:05:47 +0000
Message-ID: <DS0PR12MB78043C52A4BEEBDEEBBC5CAB979A2@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20240910133703.430803-1-kent.russell@amd.com>
 <20240910133703.430803-2-kent.russell@amd.com>
In-Reply-To: <20240910133703.430803-2-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=130e80a6-ecb8-4707-a282-2ef27683dbb0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-10T14:03:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|LV8PR12MB9133:EE_
x-ms-office365-filtering-correlation-id: e8d74c63-4da4-4fbb-9598-08dcd1a1ab3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ehgf/MK7UUO7bkRpGxicDgqDNCTni60Jl0A84gyhuLKHqNNRotEggdIJrsQx?=
 =?us-ascii?Q?QixcuWJPf2E8eeLl5367/paeiXK/xs4sna+CwDZjtz9OdQ/sRqqY+CxaVssQ?=
 =?us-ascii?Q?8Bgcg83+ouBTYQb6NQ/wXtkZnnSUqFXeIjRTTk/uK/hWf36yURlOPvAIWdFu?=
 =?us-ascii?Q?oJM1KX5FFgySHWq0uiIeaPUjBO/JI5kwvrG30/JxH9VxAmHUlgfHC9gJ41Wl?=
 =?us-ascii?Q?lOCsK8yjFjMfJ/uX2pBbsYN8S4bwjb0n+wAa2SU8I7jmlgpuztx4LiDK/lWR?=
 =?us-ascii?Q?vngDasQgf2OKXd8NxqLMO7Rd0bLXXeP9tXbyl7EXQyI7RxPQx/YE/i39J3sB?=
 =?us-ascii?Q?MEzTEmDMQykySBCe5SH6SIUQXg+pZwxIGKwbR1MflfDdMzM0/kkIbSm/7vjZ?=
 =?us-ascii?Q?BfTOElIeFEaLnOoIp8z1KL8hSm2tsF6xNWI8CXrZ1q4B1EOPFSbwAMYaT08u?=
 =?us-ascii?Q?klWgBnXxyv2ywhAIUEcr84j819dVjs3+HVCIszywIRfU/pn6KliOXW37u6+6?=
 =?us-ascii?Q?1nAbzx43+Xn/PDgteqJtsjzKX7rSx9zxZCDSpJdWFMZKbsk6whPwhIpGZFq1?=
 =?us-ascii?Q?8FuQUIzHTojYDCE8m2OHk2y1DFcGTI27/7m0nx0Xp0tikdEwu85eLLF+zz76?=
 =?us-ascii?Q?ZmQSxwCOfi/tMMt2A6TjFoJBqoevKgYKFLlXr1YLY/ilg6ftL71SyCPYGJwo?=
 =?us-ascii?Q?kKxyWwie/1xHH2CdZ13LnOwbbiURRK2gmaRhy+K3PTgR+bZROo+WCaEfs+45?=
 =?us-ascii?Q?dp4G9L8U+ktnLcKjNYQ2T4f9wFqgmCYxQ7S7hBtjIUONnnRnlSyTlsT5kmlR?=
 =?us-ascii?Q?IUBDOoPqRWytDYoknrLUE8yVEqScchgKme6ryvS022tvexMFPyIKKxewATjN?=
 =?us-ascii?Q?06uSLWZjV7y1IJLbT6rEdf7HTti9FRXXTCmxEVWXAEMcAF1ed2uhxRO0sxrH?=
 =?us-ascii?Q?h62VPS6LqCs3FnAhqIrPEFBbFTexNh6oAPW9GPmsCMx0Z72y3V2mCBxtWI6M?=
 =?us-ascii?Q?zLcy4ziZJOem000ObP5XgCHMzdtQhDf2G4RljtAiWn2uvFMqMuN2dsi5Aiyz?=
 =?us-ascii?Q?1X0+2vGQGu9uWT+taw/vzqmaqSHwnEN6AWe/noSGU56rs7ClA8pyisUFOX0y?=
 =?us-ascii?Q?D4Jnvfpl76N6SvsAwxD5HwI9BI6VXRMTTANwOz8zE/Ci1mppKG+uNgfeBJ+l?=
 =?us-ascii?Q?VDsnhd+HlNqME59aMG4KeKZxRodQkvEx0OgHHYbvoeO82w/8AaiGBd86dxbb?=
 =?us-ascii?Q?4Pr2J76wudT0S1ZteRuPjza6rFOjRq+kbOvq/s/2jzrVgZwDqjqnTkKjn5tk?=
 =?us-ascii?Q?/Ku/ylmbwYeD4/btFFpG2Ebpt/lAZa7t7+9d1Nge/E2MxJzeubkjUJWQXOkp?=
 =?us-ascii?Q?8O3fU4QoqragL8QZplirFuhoENN5L5H9xEOyNoJ1QaYFYo5xug=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ok0Cyxwe54REwT9pqz05Y1NXc+O6YLVUf1nB5ziLgLIw9zc0PULI/Pv/Wb9O?=
 =?us-ascii?Q?WX9y3uuBT31IEyabqCrAipgVrbSPA6scVV/cxdoPn9zQ7RLN9PbXpwH6B2BU?=
 =?us-ascii?Q?EMuca8HC/DmMtagMFakN0efXmZ+SuF1omUxGHEkvAPHP378UfOdetC9Pi+hO?=
 =?us-ascii?Q?mS+8KG5oSCGh2ALIoJ5L3kezBPrSjTVdcfx6Jlgt2XTRm3si5NulLHLRlh7r?=
 =?us-ascii?Q?+FJYdqKAplinQCM3kxiK8zEcR00WpsMG8pXmn+qrHWan6vSpaLldLMZm6z29?=
 =?us-ascii?Q?qSFfdWs/KbYLDM/D/2psEex90TpG5Ou+LgGyESp3ZyB4wt52QRmdxPUk72wZ?=
 =?us-ascii?Q?6iKLMWM4k5EW+Dv8Mce4+73581yhjR9iCTrP2FAP6CIuYwloOUaJOAJHeX8a?=
 =?us-ascii?Q?/8GTd29Ko5ynWxDJ9NCZl5Zo263JD5muOOpu50UH1DYalZVQlzDAr1IKtMAG?=
 =?us-ascii?Q?703bfaRhSOA2e0BB2xUiHXoTbkQzgUeULHh3GPPfMAEhqzgAIpqtjXwjhnlG?=
 =?us-ascii?Q?8cWydSOfZuLQv2L5+XXLFg2n7RPusE/QEvpswU5VlUAboen1EsiA9PJq/aM7?=
 =?us-ascii?Q?O/n4V3pvJvIJLeRMizJQU4eji7GSxXmgcjxv8kKOCZkA5NOB9jinZUeh3r08?=
 =?us-ascii?Q?HQktlSQHh3tL+4+uMQGaBNcqWlQf2YFt17OvQNCViB0bav1tsW0HSQqgk7yh?=
 =?us-ascii?Q?jDclOAFYEVOwmPrV2asZxPb5smw2PAqibiMYjhBQP0toZmQpWirNHMD6JJbI?=
 =?us-ascii?Q?cnk1KPlyqaO5YLzqSlfUi/ukMXHscC1Ftu9n5VSVOb8WEJvxEhXIM3Teg4w9?=
 =?us-ascii?Q?7ao/hRPRuWccs7XC3/sHy3cx7AKCVoiMFb27tTSCKVUMTJ7y32AXsi08/C9x?=
 =?us-ascii?Q?flp58dwPhQrkgb4Dg7/eYLbxHgm/c48sZv5odeIL8d7dcbS7gxn7vSlm3AZD?=
 =?us-ascii?Q?kpQzDvAZrWL5IJt3her+Dx88aMI/i/16xOcuL+KAnkpIN1SLYiOLwmEgy4qk?=
 =?us-ascii?Q?ZMFaZxao988vWpM4/bYY4dNiLlJm47onSYoY2GWGR6a6sNIGh5fcHtDbsw06?=
 =?us-ascii?Q?TqQFIurZoPcxJ+BFKQ4rnPOQ8dH1Pv8nUOeqsBNKBbdzfbd7I5t+QXIRKahT?=
 =?us-ascii?Q?g7ELaplQrQocPmlAiwzxaKsUD2wZphyVl6qDxfyMru2ri04RznrZ8vGm6YZl?=
 =?us-ascii?Q?AA18k7fMBxASc57xhqwvD0a8rU+x87yA5OeEgyZ2yCQviDIHNc81zo59M37N?=
 =?us-ascii?Q?ZUQvj9aIAhmF1T9isHJO7QAXsizBEWv6MPHQfUXvsKMIIdhY92Em6VSo50re?=
 =?us-ascii?Q?J1nH+BAhh/AeKJ7jjNcgsz5wetro5KI+BQVbD5Wb6QvBMKX01/Xq+Fdxsq4w?=
 =?us-ascii?Q?BZ3NitHnNl+OXOcMbt7AFKnkVqMSqg9KTRtOFeBDgDlOUauWEodmUiXK/YMl?=
 =?us-ascii?Q?KkNrvAiAvG3JtiZOZ3CIna3ZEIcci0ekoq3qXzwlS4ZxVUtX6YKtsRDY0zWL?=
 =?us-ascii?Q?phac7KnjUwJJ9TBGzoJCF8p0M96CvAC6Lp3xW//dTI0u34+5nMakIZXaLZpP?=
 =?us-ascii?Q?E0msSAHHowG7jyvEMvc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d74c63-4da4-4fbb-9598-08dcd1a1ab3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 14:05:47.2559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3CnjVsoLNS7l6cgelP9vcO/ZwreIZ2jb729ORO02Sj/1zRZ+//Ow+Ce6WLGNijN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133
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

[AMD Official Use Only - AMD Internal Distribution Only]

The ideal place is -
        smu_v13_0_6_request_i2c_xfer

Restricts the change to specific SOCs with collision problem.
Gives a bit more survival chance with a retry on every chunk requested.

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent Rus=
sell
Sent: Tuesday, September 10, 2024 7:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Retry i2c transfer once if it fails

During init, there can be some collisions on the i2c bus that result in the=
 EEPROM read failing. This has been mitigated in the PMFW to a degree, but =
there is still a small chance that the bus will be busy.
When the read fails during RAS init, that disables page retirement altogeth=
er, which is obviously not ideal. To try to avoid that situation, set the e=
eprom_read function to retry once if the first read fails.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_eeprom.c
index 35fee3e8cde2..32755a37dcef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -227,8 +227,14 @@ int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
                       u32 eeprom_addr, u8 *eeprom_buf,
                       u32 bytes)
 {
-       return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
+       int ret;
+
+       ret =3D amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes=
,
+                                 true);
+       if (ret)
+               ret =3D amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_bu=
f, bytes,
                                  true);
+       return ret;
 }

 int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
--
2.34.1

