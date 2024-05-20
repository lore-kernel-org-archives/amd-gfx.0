Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA9BC04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 06:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D851210E4E8;
	Mon, 20 May 2024 06:22:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KDXhit7B";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECCBC10E4E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 06:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7gdPWcd7fltCghJJZBB4tB7NOmdHLmfGN1yL0UqNBWD8smBLjsdVPuVsiFwk1svpGg+ESsFg54Dky23UsYICiULGStPSJ0SJoVnRH405q0c/2lA5diSikL7JP3V/lx9ZUSbMBnDBZ6LeNE5mGEa3Am9sbXdjC3rnPSyxhpr80Mm+E622Ie8a43oo6bSkAjdYUMXPlfi6AjNhT+LQ+fCinMWaUVX0BzjnWUCMl7uHYSZjVve4XS541RbAjdLQ4tZUVz69dFxh30kEMR1YGCMOgRQyS9J3F48EACgT1x/SaY8T/ok8NirhnkrHeY+A5DZY6NBTNr61O++dxeJxolVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LF7ZRfhlFRzTsh7HGNj+yEyFroDmKQt7WZPJ+MnVPXU=;
 b=Wq3iehMOZvpD2WEgAbMc2ZBpaHyZ9XlKmYrCUSsm9CNNQ7OtKwYKgG+KpXX5qVpimXkB8azWYLoNw+gDwnvBisQq54IXo/0PytPnkV6YDgCJ3HFAWA+KOYbyiSFoIy1YyOvcYiFYfu1kv1TJVKQFMhPRtEsoSo2SM6UgEwaAc0XY7X4a+nR3NmKjfLLOuRe0Zr2st79QpOS5KUCMqTGJDYG3uSS5oCXqsyWetR+G0PQTJBEmEZBUFoak8jIBXC7nkTR+otEup6J7IBMJbpvs52XCQ2m1YHI2Z57okf12u8vbFPOFwj3KThksP9pqlJPoglekyj9fLSeRnlMUMRbOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF7ZRfhlFRzTsh7HGNj+yEyFroDmKQt7WZPJ+MnVPXU=;
 b=KDXhit7BEb9EGjYF5GKQf+WzO5b+78cp8cFnkyRgan7OhynlWLdgwmC7Pqx30d+nMm7MMLPO5n7un4nqGhePChwMKnl+Xi6WO5UgNBwVY2e5q3HlA/SVhy9UBPFu2x/S749uMoMEcu3MNzWv9G6vBICpkDeAWDMrzu3da9Jt00g=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 06:22:16 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 06:22:15 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update type of buf size to u32 for eeprom
 functions
Thread-Topic: [PATCH] drm/amdgpu: update type of buf size to u32 for eeprom
 functions
Thread-Index: AQHaql/XIqtO+d/RbUaMfihTAxpT9LGfdVIAgAAv1MA=
Date: Mon, 20 May 2024 06:22:15 +0000
Message-ID: <PH7PR12MB879633D95F8AB88322F93311B0E92@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240520024546.23403-1-tao.zhou1@amd.com>
 <BN9PR12MB5257F610E24EF0C1E055E5E2FCE92@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257F610E24EF0C1E055E5E2FCE92@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=394acabc-8271-48a2-86d2-5da837e1c2b1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-20T03:16:28Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ2PR12MB8831:EE_
x-ms-office365-filtering-correlation-id: 2891273d-c70a-4e63-8366-08dc789531a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?r09Qmbc1iQSe6O+HX6pKvR0xd/Ifv+IFCqm259HAZzeZOZqwq7eOj6CSYzlv?=
 =?us-ascii?Q?g7Gs0DkeFLxiDmyjcli4q+l4vyYYvD2XwqBECuqIGGpAuiFwjC/oWeiPqjyf?=
 =?us-ascii?Q?+IwUVB44vvc04gNh0T0FP9smDqNCsE/HQ+Fb3LA/DMe1SzIlqo6WA++3hsYP?=
 =?us-ascii?Q?Qi0VckoVKgRUKlXg7/7W6K9IXCPSaph6yaHK3VXrwaUl53KOBoHJ838BRFkJ?=
 =?us-ascii?Q?hOVLnjBCIhRgxpRXhHrqUP/ozs6LWDCEsHfqbovQ8AvYOFe67UUGSCt9TIMK?=
 =?us-ascii?Q?8YHyDYK0/ME816u2kOPUn4wYsJUhR/RpRHMpzwtTMu94oNzAf2Awd9hb86a+?=
 =?us-ascii?Q?we+5o+6hFReszvH52oqyKhGtZyOS7+x/q0VhedeldeNaIdFAdSVCVlDhHItf?=
 =?us-ascii?Q?SkyyfmDjhCtjb3chGOl/M0qUEcKc85GgrdfMOaloV48VVuE8Y6JP/ipTqG6X?=
 =?us-ascii?Q?zwi4q4BMq4H4Cv3nuT68oR3lnLrPQeXrz6BkbaGeLx2diEra5YMABXgUcLLY?=
 =?us-ascii?Q?sEtW55TnnpghswELyiDP16EmOxFy63pbl20GhTCZlbl853QUkH8T9inUwSPQ?=
 =?us-ascii?Q?0OBXzwOlUxaOs6nl3x2JBc04elD9utztJqQieqMEEH/D3UX4aWnPZE3M4CuR?=
 =?us-ascii?Q?b2PFjpCwF+DwfZQpJ6E9R+ScWpFO6rSAziosH9aG7hhm1N1l8K0ewa2yrMpM?=
 =?us-ascii?Q?EFgxHIy7WvKAr4tMC+FjLw/HtJ7SBUjkTymUcKOW2h8/XjIyBveOqWcp2VpY?=
 =?us-ascii?Q?g5vo5hKObvNa6cSeVPm4buFb9NjjPxhuL0gyPDtVEq+dn2/n67/HrbrL4NF0?=
 =?us-ascii?Q?Qp3NcZ81sLQVWlda+TRWhLEdYVYs1MG6vHpwioYEGFXEa9o+qI8h9nZjMuLm?=
 =?us-ascii?Q?Xsu8ojru16GVyCtOgRq5F4WBjKMmweD1tTRJ8xdydXrf0H1RacMMpZVKP2Qf?=
 =?us-ascii?Q?67Z2fLZu/nPxVI07FqMSUi2cM/0kUJYQIIcgB8Y6xN1RM8hnZ/ZWuKkiOElw?=
 =?us-ascii?Q?Dksls7/wSqBoVMjOYgLbwcvUXmxuRYESBBHFMmGk7XeVjTFWAZKaZAItOppF?=
 =?us-ascii?Q?0eRTmfr4g2Oer0ss6+/ZDbI2AUm4IlQ8lHgZ1Yjg4Upi9V3jxqNnp1GyJkmE?=
 =?us-ascii?Q?eaemxJ1eEC9hGUAWViSncJ1BdHw5GdCv8jO8TEnzLmUgKOQZUM3QJwJPdM/D?=
 =?us-ascii?Q?9NAJUcOUG9i/RL6JfAveCJGp5FyL7uaJ1h99D9sjZnJ7tGzKrm463ZXdOaEN?=
 =?us-ascii?Q?HppYZESowuX9dApVrsHMmPDPW9rtA/vwiV7JdbXZoR1r1ar5UWt09ioCopBO?=
 =?us-ascii?Q?deuha5sooNCwKF8DaeJQOsxisa8q3UfusENkLnDu5YMWNw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gbMQVulU77OykBAO6R6NxaI+YjtM3pPK6Wj+4VVYTU3sqyTQcthC5CHw2Ye8?=
 =?us-ascii?Q?NwnVCltfLBYcFZ9tHFet0u54IcU2JwUMcahIymL4ZqZAgywtJewGFuT9z5TX?=
 =?us-ascii?Q?l/Dm2Vjnw34IqYmM+VSItfcUe6dofxSYo6fA0bSeF90WKGjc2LFQxHpO5Wyr?=
 =?us-ascii?Q?EThjI3tIjCavR8bSXI70/uw7BUQUcfPCqg1dscoE0xS+ht8TKLPHtT7vewWL?=
 =?us-ascii?Q?wBMJkv83ROlW5Gd5jfoLvpDFxpUMTNsiEo95TR6v03kURgMyWDQCgMRIuacX?=
 =?us-ascii?Q?NxJkeMo/VAgFMZA+DJmuVvecBm4De/fKPIJ7CiyePksgql6r88AWq5GHAeqy?=
 =?us-ascii?Q?HUupLfs7APLAD5jV8ARACWe+38Ql2nJNAycAMvR94eN1tLLLLCZutbDRP6fR?=
 =?us-ascii?Q?yKDEYqjJOd2ot4hGOOejfF3Bl/zWWKHkq281ufVUze9Zmnog6t//arDQktnm?=
 =?us-ascii?Q?UdO2oYvjmgD0/ddyb439fWcj6StsVPhbZlRr6nPoazFMSLS4Q0xVfXYyiw3i?=
 =?us-ascii?Q?gjbHUG4R+fGMKivx9jipqr0Zca4LTl/luXyQlTGPRVnugaNOAkE4UHkupk0D?=
 =?us-ascii?Q?BnO7KtVQMIAyQvmseZhJbpKq9ydBu14C35PfS2OT2UcuuqY1MxpO3gmodagj?=
 =?us-ascii?Q?q/TllJAOJ/eSeHcvYd6VZFwinnE1KJkJx/89wJD7MIFJNl1JTo0tIKtGzIeF?=
 =?us-ascii?Q?rKn+DCjkXFIE7XZvmVYNYJ5z1+gLCkmPnamgSn8l5R94Qbot7Bcd0fo2EhyF?=
 =?us-ascii?Q?Mo0aYpgfuvjFfP2OOk15HO6OefjLw+4uIHe9+wgQmN/sljdl3GauAiE3F2LE?=
 =?us-ascii?Q?oLSFRkdOg97guDrxn1B/GnQ1RVPIf0zchGlaiftVtnt5Ja/lS4D86Zgxj95U?=
 =?us-ascii?Q?rst/sK7EVNZf9CiPSVLxHGMZ0TeHJjKezEXwGxKWExJSil4OyKP5m15p+B8s?=
 =?us-ascii?Q?NFSUa1lKiFCMXIZFMYAiB6Ny47P00mr4l/XNPdXg9lPTLsbZ8YXH/XYT8mCL?=
 =?us-ascii?Q?ho3yXOwipYX+UC9BCT5rwlrzAcOwjxc9Cx+kqrK2LlaIYPIMGvU//cTF18tX?=
 =?us-ascii?Q?znVZmcxAPNYfk8FbjSBLQrzK0AzuIDDo9vRSom4JLzkdjC+07wR2W3zMkPoX?=
 =?us-ascii?Q?zaqfqX5YAtXRPyYfTivqQA88DAa5Y6qYpBdu97tVL6fgFWOy/zpYzYSgKgI2?=
 =?us-ascii?Q?6frbJmKp4oalhewE9jxfPuQZxRbRiq2S4fIq8ZjYguA9qyNi9owfipwDTWZP?=
 =?us-ascii?Q?SkKI1N2kGgkQpyMjwxZq/TpkXlM2OHupRNv4Mhm+qBFJpfWBwtfEyEf/22FD?=
 =?us-ascii?Q?3/nqJM/vQqKUapCVXIsCQ4bLVyj2jkw61aPNvkGFaIX5YqtDV5Ap1TyuNQmo?=
 =?us-ascii?Q?jSBvbvuDuJ+4cBHi0yQT9rz6QQ4bOSdJXXf8dH2verVkGmZ+z5GHTwnJC7t/?=
 =?us-ascii?Q?6EJs7tTPDyS/3d6mnFyXDGB5tfcptABEkKNht0kNdmVlKDd3RtxEreKSYlgr?=
 =?us-ascii?Q?xvlHpDsh/f4Yw5ulP16FLATKzkE6PfLKTFCF7+LbJkT/X9NcpBAA14aXnvVA?=
 =?us-ascii?Q?abR6kR04Suz3z7pyN5o=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB879633D95F8AB88322F93311B0E92PH7PR12MB8796namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2891273d-c70a-4e63-8366-08dc789531a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 06:22:15.8078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLkeNu1Yk3zkfU6EinxJLCC3Xk91JYR3fGEi6sJGJ+f3qXid0lNdc9UZCIDZMBRY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
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

--_000_PH7PR12MB879633D95F8AB88322F93311B0E92PH7PR12MB8796namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


The limit variable in amdgpu_eeprom_xfer is not 0, so the buf_size will be =
cut into smaller pieces, u16 is enough for __amdgpu_eeprom_xfer.
Anyway, use u32 for __amdgpu_eeprom_xfer and make sure the msgs[1].len is l=
ess than U16_MAX is better, will create a new patch for the purpose.

Tao

      _____________________________________________
      From: Zhang, Hawking <Hawking.Zhang@amd.com>
      Sent: Monday, May 20, 2024 11:23 AM
      To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
      Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
      Subject: RE: [PATCH] drm/amdgpu: update type of buf size to u32 for e=
eprom functions


      [AMD Official Use Only - AMD Internal Distribution Only]



      Hmm... but in __amdgpu_eeprom_xfer, the u32 will still be cut to u16.
      __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr, u=
8 *eeprom_buf, u16 buf_size, bool read)

      Regards,
      Hawking

      -----Original Message-----
      From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-b=
ounces@lists.freedesktop.org>> On Behalf Of Tao Zhou
      Sent: Monday, May 20, 2024 10:46
      To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.or=
g>
      Cc: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>
      Subject: [PATCH] drm/amdgpu: update type of buf size to u32 for eepro=
m functions

      Avoid overflow issue.

      Signed-off-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>
      ---
       drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 6 +++---  drivers/gpu/d=
rm/amd/amdgpu/amdgpu_eeprom.h | 4 ++--
       2 files changed, 5 insertions(+), 5 deletions(-)

      diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_eeprom.c
      index e71768661ca8..09a34c7258e2 100644
      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
      +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
      @@ -179,7 +179,7 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapte=
r *i2c_adap, u32 eeprom_addr,
        * Returns the number of bytes read/written; -errno on error.
        */
       static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eepr=
om_addr,
      -                       u8 *eeprom_buf, u16 buf_size, bool read)
      +                       u8 *eeprom_buf, u32 buf_size, bool read)
       {
        const struct i2c_adapter_quirks *quirks =3D i2c_adap->quirks;
        u16 limit;
      @@ -225,7 +225,7 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter =
*i2c_adap, u32 eeprom_addr,

       int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
                       u32 eeprom_addr, u8 *eeprom_buf,
      -                u16 bytes)
      +                u32 bytes)
       {
        return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
                                  true);
      @@ -233,7 +233,7 @@ int amdgpu_eeprom_read(struct i2c_adapter *i2c_ad=
ap,

       int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
                        u32 eeprom_addr, u8 *eeprom_buf,
      -                 u16 bytes)
      +                 u32 bytes)
       {
        return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
                                  false);
      diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_eeprom.h
      index 6935adb2be1f..8083b8253ef4 100644
      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
      +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
      @@ -28,10 +28,10 @@

       int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
                       u32 eeprom_addr, u8 *eeprom_buf,
      -                u16 bytes);
      +                u32 bytes);

       int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
                        u32 eeprom_addr, u8 *eeprom_buf,
      -                 u16 bytes);
      +                 u32 bytes);

       #endif
      --
      2.34.1


--_000_PH7PR12MB879633D95F8AB88322F93311B0E92PH7PR12MB8796namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - AMD Internal Distribution Only]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
limit variable in amdgpu_eeprom_xfer is not 0, so the buf_size will be cut =
into smaller pieces, u16 is enough for <font face=3D"Calibri">__amdgpu_eepr=
om_xfer</font><font face=3D"Calibri">.</font></span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Anyw=
ay, use u32 for __amdgpu_eeprom_xfer and make sure the msgs[1].len is less =
than U16_MAX is better, will create a new patch for the purpose.</span></fo=
nt></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Tao<=
/span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"DengXian" size=3D"2"><span =
style=3D"font-size:11pt;">_____________________________________________<br>

<b>From:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt; <br>

<b>Sent:</b> Monday, May 20, 2024 11:23 AM<br>

<b>To:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; amd-gfx@lists.freedesktop.=
org<br>

<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>

<b>Subject:</b> RE: [PATCH] drm/amdgpu: update type of buf size to u32 for =
eeprom functions</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-right:5pt;padding-left:41pt;"><font face=3D"Calibri" =
color=3D"blue">[AMD Official Use Only - AMD Internal Distribution Only]<br>

</font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;"><br>

</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">Hmm&#8230; but in __amdgpu_eeprom_xfer, the u32 wi=
ll still be cut to u16.</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">__amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,=
 u32 eeprom_addr, u8 *eeprom_buf, <b>u16 buf_size</b>, bool read)</span></f=
ont></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">Regards,<br>

Hawking</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-----Original Message-----<br>

From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
<font color=3D"#0563C1"><u>amd-gfx-bounces@lists.freedesktop.org</u></font>=
</a>&gt; On Behalf Of Tao Zhou<br>

Sent: Monday, May 20, 2024 10:46<br>

To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org"><font color=3D"#0563C1=
"><u>amd-gfx@lists.freedesktop.org</u></font></a><br>

Cc: Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com"><font color=3D"#056=
3C1"><u>Tao.Zhou1@amd.com</u></font></a>&gt;<br>

Subject: [PATCH] drm/amdgpu: update type of buf size to u32 for eeprom func=
tions</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">Avoid overflow issue.</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">Signed-off-by: Tao Zhou &lt;<a href=3D"mailto:tao.=
zhou1@amd.com">tao.zhou1@amd.com</a>&gt;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">---</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 6 ++=
+---&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h | 4 ++--</span></font=
></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> 2 files changed, 5 insertions(+), 5 deletions(-)<=
/span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eep=
rom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">index e71768661ca8..09a34c7258e2 100644</span></fo=
nt></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c</=
span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c</=
span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">@@ -179,7 +179,7 @@ static int __amdgpu_eeprom_xfe=
r(struct i2c_adapter *i2c_adap, u32 eeprom_addr,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp; * Returns the number of bytes read/written;=
 -errno on error.</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp; */</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> static int amdgpu_eeprom_xfer(struct i2c_adapter =
*i2c_adap, u32 eeprom_addr,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 *eeprom_buf, u16 buf_size, =
bool read)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 *eeprom_buf, u32 buf_size, =
bool read)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
onst struct i2c_adapter_quirks *quirks =3D i2c_adap-&gt;quirks;</span></fon=
t></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
16 limit;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">@@ -225,7 +225,7 @@ static int amdgpu_eeprom_xfer(=
struct i2c_adapter *i2c_adap, u32 eeprom_addr,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> int amdgpu_eeprom_read(struct i2c_adapter *i2c_ad=
ap,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; u32 eeprom_addr, u8 *eeprom_buf,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; u16 bytes)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; u32 bytes)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,</span></=
font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; true);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">@@ -233,7 +233,7 @@ int amdgpu_eeprom_read(struct =
i2c_adapter *i2c_adap,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> int amdgpu_eeprom_write(struct i2c_adapter *i2c_a=
dap,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; u32 eeprom_addr, u8 *eeprom_buf,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; u16 bytes)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; u32 bytes)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,</span></=
font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; false);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eep=
rom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">index 6935adb2be1f..8083b8253ef4 100644</span></fo=
nt></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h</=
span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h</=
span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">@@ -28,10 +28,10 @@</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> int amdgpu_eeprom_read(struct i2c_adapter *i2c_ad=
ap,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; u32 eeprom_addr, u8 *eeprom_buf,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; u16 bytes);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; u32 bytes);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> int amdgpu_eeprom_write(struct i2c_adapter *i2c_a=
dap,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; u32 eeprom_addr, u8 *eeprom_buf,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; u16 bytes);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; u32 bytes);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> #endif</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">--</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">2.34.1</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
</span></font>
</body>
</html>

--_000_PH7PR12MB879633D95F8AB88322F93311B0E92PH7PR12MB8796namp_--
