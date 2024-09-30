Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3A4CE8355
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 14:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C88E10E526;
	Mon, 30 Sep 2024 14:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qJ1ghPCj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100CA10E526
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 14:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0lELEIR8ZExtfdwiws0SoB6In7ZpHM51YCoa0b1bUGZkQ0rqA1swibs0WQ6wUeCParEwt1oNfQ0PFvaS8T5g9CN8LG1O+54GrdmFIVcDpW38sL0iTp+VRWMpo4vSI/x8l+iMXgDJEhctOuB6EZFlm9cLW/sqfedUQivt7g9kfl0BV28XKLDLFn8Sf8Pv51wVz3x4wsoVxTCT1WaVwlSqECimuQtCP2UPiRDK3vi5Ph/lUGOYSll3AtHI43mEr42hh9+sVWavIWSEmFzSCV7pJcGrpGAP/k23cgXBimXY5Vhgo4zfxtLNoo6wtAEcMSg4XLrdos2G+tzBhbR9hKsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4REV0Vk/TobfGmGi5Eb5C3nK4uTnHT6gX57vAzyn4s=;
 b=INYZUN+Ec+gfRFYbs7emYnbRhcSjCl8krGJjbXOstDU2s0FRfzuOo+xOrn9Ot/kuOo6J+9Kdf9GkZhjZ2p/UkjWmWuaaIVzUkoyQaMzdABpTPvtxa6m/Jk03ZLKjZb6eSB2UookDiAULkKlO9X4Is8f04ZKpO4uElVQcMCufdOzhmXU0guTAqxHKxLVNl09P2BgqDEuWdnOXCwJhzVtB22BAjs8N8iRUYb72FmytRkuC1Qk9OAuBjhjWPnpdgTW3JBZjvzMuUhywDyMP31UmpWxopVuTmWm95oNuYTYI4rBL1lLFvuBEvsEJwXnut4/mJbY6VsmV5B4u/WjB0JaEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4REV0Vk/TobfGmGi5Eb5C3nK4uTnHT6gX57vAzyn4s=;
 b=qJ1ghPCj7Or55gHu4b62xKV7rRMSaFDXdTaOQf1WDQmNRtulLzkkLk8AxiHCSYzRA3H55PsbshGxPv8sr2YAzn1cJLoVQ6BW7CELTyUKkHu+Y//5oybBTBzRlIbnJNVBUpkrR4uKToH8fySeUj2LURS/FApQHsdIxVuLk98HYqs=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.26; Mon, 30 Sep 2024 14:52:59 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 14:52:58 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>,
 "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 00/13] DC Patches Sept 23, 2024
Thread-Topic: [PATCH 00/13] DC Patches Sept 23, 2024
Thread-Index: AQHbEP7ujDIn+mleHEWItfz0jfD9kLJwbleA
Date: Mon, 30 Sep 2024 14:52:58 +0000
Message-ID: <DS0PR12MB65348E01FCA1FF5C053DF8759C762@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240927170103.102180-1-Jerry.Zuo@amd.com>
In-Reply-To: <20240927170103.102180-1-Jerry.Zuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=dd052429-355a-48db-b217-0e670b6075a4;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-09-30T14:52:51Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DM4PR12MB5964:EE_
x-ms-office365-filtering-correlation-id: 2fdc9225-e618-4990-b547-08dce15f9307
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0zvD/lnXo7VTVGEzKaK+z1Ng3dkzDWQXk8Lm3Ug8Xt5KXMC0ZPnmS6NmsE?=
 =?iso-8859-1?Q?8Yg9JB7+ecBwaF2QmNVxjKqe9c5IZr85lQ7Q4HMida+JDdoccEjZ2dGchO?=
 =?iso-8859-1?Q?37HQjW2I5SfZ4USvhGU2ycXut4raw7PAqP56J0UVMohSQTwqtGAMjH9jl5?=
 =?iso-8859-1?Q?cQQUxhZVWh4pQd1/q6VxKiJ5FE+VsQC/m/cU5iBa6On5PGsEjbIO4VuSg+?=
 =?iso-8859-1?Q?g8SVtXSQZwfrwW/ZYMs4mD7wJ7Ua/jaDZjMHwEdnlyJ2FwfjRdPMXVmXyN?=
 =?iso-8859-1?Q?kG1uQHlyF6gjOYvggFK/G/Dh8Uw4PGKE6tBrUtxN/duHojNfv+46ELUa02?=
 =?iso-8859-1?Q?vRMVf4G+ebEdZZbM8b1jFtrna/ybqnczGufHS8gh+jQADSCve0Opl2DXdm?=
 =?iso-8859-1?Q?lqmKPfnL6+ocXEKQRzZd4UZ4JWuHJBuwaqB9xJ7dxOS8/etRlqKx7z723B?=
 =?iso-8859-1?Q?BGxylompdqf4r2cIczwjeQFyZNLk6uuRiZ/tMqT2Gr3IuKRG/iKje5ewWf?=
 =?iso-8859-1?Q?R7Mc3tqAZp4ijkxaLbArvHXa4wJJ2tQh4i2Zdrt7TbycYl25jXM4XTeOjV?=
 =?iso-8859-1?Q?qZIoumq1P/x5U615gW3GRPSPQFwQCcncn/DgG+rU/hjpCRUMhgrNrTC/Qe?=
 =?iso-8859-1?Q?z4AERU+/Tw8PgXspylP9TBZYiFHlip92mhBDY3as98UmT606Vu9urZs2hf?=
 =?iso-8859-1?Q?IZO2HBWpy2fS8TqV6weKc9FLdT4Uvy0oLJTz/dpv3Nx5KDuQW54a5nzwtq?=
 =?iso-8859-1?Q?Fenu0u+msVlhMXzynTAhVE6M8RLIJ7TheyGuHs6ruusvcC4MevVQWEn2Fq?=
 =?iso-8859-1?Q?XEVyZ2bcPZ7YD0UhB4nBLjHvehqlF4yc/LqZEgqSZk7x8T7vJRCJLMTKey?=
 =?iso-8859-1?Q?c803qkzSEr17/Bhw0Pyo+0Ce8CKTNrhTCxnI5grbnJDM/uaQ8bUFbm5j5y?=
 =?iso-8859-1?Q?YkTLjsJOcYteKM7eZznxzfh3loKChcEDZYFrkR87n9APGTQICK3uOZVSis?=
 =?iso-8859-1?Q?irMmYNB1xjlaNCeJtPYxfjc3rg4CgYM4bbC6xphijKjJ1jtVgEdnuVxxh8?=
 =?iso-8859-1?Q?gQ5Li1gv5BkvEV+GgFSix54L4wUVNE/3JymsDXW0yAL8FlD4BpIFf910fL?=
 =?iso-8859-1?Q?ECOA9YWjjZ7IsBGAN1VqubYANEPssmYjUVREmFIszlwZMjuFEZROL0r/iY?=
 =?iso-8859-1?Q?drqJUDcXYSc5uOVHUe/AYD/WyCnrvkQl6HABnludC6HOG3bX9TbGm4CbWW?=
 =?iso-8859-1?Q?oInJOKmxCucRV3quEkCFmQJZIBGairWJ96gjYD8GvXjOWHdy9Xn5v+n6Q8?=
 =?iso-8859-1?Q?KSjt+JPtu2idtgXVXbSIhARDRoVOlqci+qdMKYBXsfpd008zGHvVn/DuiD?=
 =?iso-8859-1?Q?UWPZIfJvXUAlsACf81xRMjsuATEM7icZ31oUVVh0lRR8Wr94UrvOVwNu4o?=
 =?iso-8859-1?Q?B+Y3Bq6dmTGAKJsODzvzr0K/VuLt5ZGJdEJeEQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tkdFEIxKkD9zN5wE5bPJY0yWdgODH20GmFfymjhj6GhEneUnUyKsEdRjhk?=
 =?iso-8859-1?Q?soOWZngeZEhSfR31EnjQ1cXVOxR4VAkhXiRZdDLxfR+j9K376SPOVHSdiF?=
 =?iso-8859-1?Q?B6CjDjakxtSVrghE6N69hMP5bRuxlokjT0tbhc4CNl1IYofoJhKfTWirb5?=
 =?iso-8859-1?Q?yGogeKiOZiFUBUH0qz3m/1/K9lQwPwC0qSLuQ1vds42eQLMz0xse0hKpcr?=
 =?iso-8859-1?Q?19ID+UnP+hKP0mNyymvsdqhQJbOMhOhX4C8NOeCPYo5FQNfAaqs0pz+gxu?=
 =?iso-8859-1?Q?sbR6N0wi4EuLwPX2R4ZIwR71GMBTrbh2a3VvlwJz15Phj+XfjW26qPiFkB?=
 =?iso-8859-1?Q?BTDjjzlUR6um9D3Ru7X49YZt3reQW3utfpRhFtdtbRhOdef59pwtriT+7A?=
 =?iso-8859-1?Q?cKkACSaGE+B0n/dsKMDAq50Vo5gQalt/xruJzj1gjnySQ7BQWzA3eO9fDg?=
 =?iso-8859-1?Q?97oJE70wOFdpzQAFKBSHBts4NUdNux+foCOvazWhEMUisidXNr6+SBknr9?=
 =?iso-8859-1?Q?KWnnaiWmJDx5Lc0xL/w6VHtUdMUxpBBEW4j403w7mitSarpSoHzPfky7HN?=
 =?iso-8859-1?Q?NQbCRtPCbuWDlshQ0NPaqG7HBeSB62kaA9r1z24KhUPD3utUC1J1XZWH/b?=
 =?iso-8859-1?Q?NDzNd+KZory4KQo0CRrNuePxKHpj6WbTjTxlUyyPFd6DkFAyklLsZIFQMC?=
 =?iso-8859-1?Q?XstO0yTZ9kVcHvQL0j0a9dlu9DhsGedBMYtVHfZqGqFHqitXoUm7C4UNfP?=
 =?iso-8859-1?Q?t+iPkPsx/PTZJKVhmF6BtcOw5Vj3kL5Ixz/fm9BsvEbNZkDKU5Pzd4J9HD?=
 =?iso-8859-1?Q?wSpFtgZwMfHF6HBaFIIu8cuCRLRhSgUG7/tDv7bnCvXLReXrDK+MFH2sI9?=
 =?iso-8859-1?Q?xnnLu3PLIaeDuuS9LhimBdBF8clz6dos2PeRdrzJb43S7HCCrZgsj3Aqps?=
 =?iso-8859-1?Q?eoxxTMaSHRHAOklCLMBeszvpfAcPiXlKewf0dkxKGxDegX6fumVRI1iPjV?=
 =?iso-8859-1?Q?1NW0Oc12IfkNfgfliNlHw4fnWpZmOlmkQf4qJLE6ENPaXvudGZibtMtE4v?=
 =?iso-8859-1?Q?z587kv8P2HALf50TMTPReFm5GzDn3ECtEEAfX/Yxf2VO06jIDsXYrKuTHm?=
 =?iso-8859-1?Q?Bu5KjurqkZ4BJ9lIkdkHjvmYp3racZGNlriC2XrpU16f8yT/sXfJ5OoNbI?=
 =?iso-8859-1?Q?qj875sh7Ql6P9s6WSwO7bgn8eFwbdGCo20s3I7ayJ51//EDdpU/q5KK/Y+?=
 =?iso-8859-1?Q?hDrNkdeaRMHTcT58zQ6H9JVkqMJXZUS8s1wCRFDDA3gHgGWAWsVRNyu9be?=
 =?iso-8859-1?Q?tuJtqrxLMyYQp1IpjGw2UhWwoCU/khwFtwnMf8yCIJNyXjN6f+CorjQBlV?=
 =?iso-8859-1?Q?4FfoZuE0866GRzi6yVxsW4Nz+fO4qjByH6rDm3Q0U3PhKm1lFmbcJFlAHh?=
 =?iso-8859-1?Q?HlqVp/Gc6eRB6E5UDJqy0XCVlMN5nh1/YLjMWz8eH0PBeTULI2BYwxljyi?=
 =?iso-8859-1?Q?vLO2GBII3bXinDScbAIVfLPzCPNTpyz99PYYbTiw3aLVuO4KFfAz7QKKNC?=
 =?iso-8859-1?Q?4arDn4QqvtZ1Hwura2Tcg37cxzGih+64epsCxKh8o/y8eRf3eyU7JO9QPb?=
 =?iso-8859-1?Q?uYD34CpxgUWMA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdc9225-e618-4990-b547-08dce15f9307
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 14:52:58.4623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdXQxEAHDw0y8QcS+l84Odvz1mJCzxquXvNOre7t8HQ8aBjQvCbBOmw/19e/xIn1zw+8zbOYyy7cGFfR1PFANQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964
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

[Public]

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
        * Single Display DP -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz displays=
, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 1x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * PCON -> Club3D CAC-1085 + 1x 4k 144hz

DGPU
        * Single Display DP -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz displ=
ays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - 3a1=
5ba63cd49d7957196a0759a81a7c289c5fafb -> drm/amd/display: 3.2.302) with new=
 patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>



Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
Sent: Friday, September 27, 2024 1:01 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <H=
amza.Mahfooz@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Ro=
man <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (T=
om) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zae=
em <Zaeem.Mohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, =
Daniel <Daniel.Wheeler@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>
Subject: [PATCH 00/13] DC Patches Sept 23, 2024

This DC patchset brings improvements in multiple areas.
In summary, we highlight:

* Improve brightness control
* Add support for UHBR10 eDP
* OPTC required only for DTBCLK_P for dcn401
* Fix TBT monitor resume issue
* Code cleanup

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (3):
  drm/amd/display: Remove always-false branches
  drm/amd/display: Eliminate recursive header inclusion
  drm/amd/display: Removed unused assignments and variables

Aric Cyr (1):
  drm/amd/display: 3.2.303

Dillon Varone (1):
  drm/amd/display: Configure DTBCLK_P with OPTC only for dcn401

Liu Xi (Alex) (1):
  drm/amd/display: add more support for UHBR10 eDP

Muyuan Yang (2):
  drm/amd/display: Change Brightness Control Priority
  drm/amd/display: Introduce New ABC Framework for Brightness Control

Ovidiu Bunea (1):
  drm/amd/display: Add IPS residency capture helpers to dc_dmub_srv

Paul Hsieh (1):
  drm/amd/display: Add logs to record register read/write

Ryan Seto (1):
  drm/amd/display: Adjust PHY FSM transition to TX_EN-to-PLL_ON for TMDS

Taimur Hassan (1):
  drm/amd/display: [FW Promotion] Release 0.0.236.0

Tom Chung (1):
  drm/amd/display: Fix system hang while resume with TBT monitor

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  48 +----
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  78 ++++++++  drivers/gpu/=
drm/amd/display/dc/dc_dmub_srv.h  |  39 ++++
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |   1 -
 drivers/gpu/drm/amd/display/dc/dc_state.h     |   1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   6 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  84 --------
 .../dc/dml/dcn30/display_mode_vba_30.c        |   9 -
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |   3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 187 +++++++++++++++++-  ..=
./amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  11 ++
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   6 +-
 .../link/protocols/link_edp_panel_control.c   |  43 ++--
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   8 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 157 ++++++++++++++-
 .../drm/amd/display/include/logger_types.h    |   4 +-
 18 files changed, 521 insertions(+), 177 deletions(-)

--
2.34.1

