Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C80DCCA47B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 12:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0628A10E783;
	Mon, 13 Jun 2022 12:41:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D51ED10E783
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 12:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGZgL4Fecgd8hoSAdKYeGNzJmuLasNZ3I0KeGAPrICqjyfp0pKO24dLom//QMCVZiFezCkxEhc1AcXgDN7POIkY5gK8kkaiLYzX+/sf6r9gpcnkOLq1xmtEqrRPEOjBighoZ7nneet2Cvl/Rt6wU+6Fx4HTB7KrxlU447xmISX1Bm/ynPPGP1kSB5rgaRVd7UoP2YFqUFWmOWImwIp0HvLXCEig0ggFsJNV80NtCsRuw8QVEfLOcl6lzoObSySBQOb6Z59HydK3IiZNdqrSRarUZlGZuRz9Jky0cWCoqCWOpTIgG/olsbqMsiQCdRhpjFmAyiOKa3YIbpdpeMJkDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7imfbzDUIdBOMaIMd/4yyfkOa4sgzb4QnXcQLnNLs5Y=;
 b=gcCJ1MHMfRRRKDT2aHsv9K+lH4kaEKPQqfNrgV5D8YawUKHx/G2g+h5q11UXDJ5QDvJHwYEjCgcjR0wg8jYrUB4mIIJp88jmhFu6B4/kUbdMPOVCLsq2vii/aMA6NzHHDwJcaPF6v0VULpkcID2Giw3OopU2p/idbpXA0Q+1v4rrFNGKhQ/cLPjYuAlGuuwzsk+zbHIXq9rNKKc6OdlUQZeRr3iW9QmbpaaWt6LA6M/WVMmcOWWIXLWY2TcaQjetaRE/rvjEmWPONsCP3IEGOylDowgA47a4/MAMY6726AaC6RiUHpFuy/HlfVkhu96eVO8s2jOvvF5B3/TcJKv2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7imfbzDUIdBOMaIMd/4yyfkOa4sgzb4QnXcQLnNLs5Y=;
 b=tPYaG1JOvNzoYnHpT60GywHOpoNrRa1ORibLGQT7Wwv5eX2UzpI1GVCpD/uNeSsNm07A6QDYaOy62K2bFCxzuL6hzgSkfyAcUChmTqsjSE06IE2fQyCXmiguchbao+JKhEAaBF9oXNrPIvggC2V5I2zBsSQgfkdPq2+QdTFqy3Y=
Received: from MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13)
 by DM6PR12MB3497.namprd12.prod.outlook.com (2603:10b6:5:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 12:41:50 +0000
Received: from MW4PR12MB5668.namprd12.prod.outlook.com
 ([fe80::4911:d6fa:f15f:a139]) by MW4PR12MB5668.namprd12.prod.outlook.com
 ([fe80::4911:d6fa:f15f:a139%5]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 12:41:49 +0000
From: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel.daenzer@mailbox.org>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock
 switching in games
Thread-Topic: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock
 switching in games
Thread-Index: AQHYfQw0Xr/HBqbSIUS87kOqaeZ4Da1NKhKAgAAhNNA=
Date: Mon, 13 Jun 2022 12:41:49 +0000
Message-ID: <MW4PR12MB5668A72B83B72BD7EDB29BFB96AB9@MW4PR12MB5668.namprd12.prod.outlook.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
 <20220610205245.174802-21-hamza.mahfooz@amd.com>
 <3c4a7856-dc93-8933-0904-0b6f2d270bc1@mailbox.org>
In-Reply-To: <3c4a7856-dc93-8933-0904-0b6f2d270bc1@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a80b2e01-8128-412f-ec20-08da4d3a15e2
x-ms-traffictypediagnostic: DM6PR12MB3497:EE_
x-microsoft-antispam-prvs: <DM6PR12MB349732B369952B9BC4F3D8FF96AB9@DM6PR12MB3497.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b3rUbA4vG6hXBL+MFV1vyDQl+EOF8bPGvhKhDvl6tHS0EFp0pMfR8SXe0zjxjl+fzp7LdBEHmNIw5DDqCDGDVdP/Zg8L1xLK0UG6mrc4DUai+n9+1FroQKZEhlDpvRoJUKHWQO2f5FI2PttKggtXrpRMOZnmSBiIqPIuzcj8dcnlds8z6deoweVfr3wo/1MtR1IHBo7hnXOrsmOUWQoCZ86hy6GVB+qFTXvGNxUuZvTyegXYebwUUmWQKuqlYcru8YFrCPUs7N3Z/xbs0y4g7SadDA+5Q/cnBeSToJ42Wm0Ao+3mdxVC/r0LGXgPpFhruSL2hZ8z5cWcsDC0GTUFfgecjaI6WYj3IlYBorts88ijuQYIE3uLPdrStVuXj+pQ2HKw1K5MhGkWc2VSFKFDhyCrULV+ZuMds6iCITZy+u9JCIAlQ7f+b7MpyNzqpDOW2tsqH5izqlE5/0I1cO+vcVsBWjyrJGPz7a5sTQLuY2zCLytY4eksK6xynS6syLrdmJQaxH7AE7H9NYMBIfdpZHOQEPXNSdVOsONrqONfkSLMXuwryoL5Y6yp3xbX8UWQiZKWavRv0rFD/fu8IVL3vjpRaJ7KEceR3FtK1kUBdzKeVfHYCYOrRX99978d6xYg7MUzu2Ne7bnaTZxdKS35gBDaADGLksAjlbXL20U0O92zxRDpNOqH3JHuRRFPYev0I5m9gmwpcO4jF0BvafvKZi10QNFDu892elUok8n9ay/i9raZwh5fs0+5c4Bpj9njpfjNilD7l5IP3NV7aZzC7ttChu+gefcBUB7qHm/s0Cw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5668.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(45080400002)(86362001)(71200400001)(966005)(508600001)(186003)(66574015)(316002)(55236004)(2906002)(38070700005)(5660300002)(54906003)(76116006)(4326008)(66556008)(66446008)(122000001)(66476007)(64756008)(8676002)(110136005)(52536014)(66946007)(38100700002)(8936002)(26005)(9686003)(55016003)(83380400001)(33656002)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?W/xWGT+kCTTCwRyYGQRhAIO9FaCML9V3u7MBT5Z9jnD9im0D2xD8Dy/AVl?=
 =?iso-8859-1?Q?yIkx1nIsXW0eL+86SomlSKFLSpwf9dl1KkOiTwXoGNJrLTHxqHKPyAA1eO?=
 =?iso-8859-1?Q?t8hDle10X+bLn1MqCRP7RkFkMljoydl2ENcDk3Csf3Q2Av4vNHquVp08sX?=
 =?iso-8859-1?Q?Q//V0eqH65vrvRlvSYZ3tBSLcwJvxxkwAjsV9vQlLjHZkOUY1N9F6Btqeh?=
 =?iso-8859-1?Q?g0jP1YU0T/q4lyjsrfo+KXR5Ul4EPQcDU5yhUpdzlsEDlG3E2Z9nExU0mO?=
 =?iso-8859-1?Q?JogF+jA/uXp5WfqLc33LSx4U5+HSz8jKU4A/Nt4ZFM1KiIJKK2eE8V0G+F?=
 =?iso-8859-1?Q?8jPUFUf6YFn2e4HMctVXqhhRoF3B3h0tkGDfGSrz7axF/Bk2NOVjIIjWks?=
 =?iso-8859-1?Q?yV2YHGOjkdmuIx2tJOMEXnJLi9cpAouya6hv6CTTsAqgtA0eGlcMWDX5cY?=
 =?iso-8859-1?Q?9JlitYeupotdEa4Aw6jTro5utMItygngmLL4WZWxFULqCYSSA3X1QZW3cx?=
 =?iso-8859-1?Q?ES5RpqKdLlvLzRsBU4yxefXC+65RqPIZiPu/aI+d90QjYmdBTcvMbv0Mkf?=
 =?iso-8859-1?Q?eZaej5me3wJBXGI4iIqQUwIdKMenZJwB7OcaQVB+rLvphIiIHwZeFmAVZT?=
 =?iso-8859-1?Q?DJGUp+Qfnv3s/4r+R+TA7p/zJ/tNfrPIqyTmZREbBy3SkMKCJ4J0NJdkMs?=
 =?iso-8859-1?Q?6u4ZmoO3n7P7bLJM11Hl9VIbi1++hNyk2HqnDSpcf6+7l8uyOQplPnA/Ve?=
 =?iso-8859-1?Q?W211CREIdDvoe9hpgwLgw5neJEs0pup+K0s9jwJBWuUrZApdm0XvG/D8cU?=
 =?iso-8859-1?Q?MSZutzR7s6p/EUsgpDpOy1lJGvHK+OBLdp9xyffjAvc398l0/r3ZjerxsY?=
 =?iso-8859-1?Q?oghf+FFruza2UX4w7/ryuCxh6HRal3tHF5JiYEazgyfiWB1TZJitiO2ctv?=
 =?iso-8859-1?Q?52XaS0/goJzUiPdGKjFbx2ypWZqRYFrSlK1zZUpfR/+YOEgKgeuGegzzkN?=
 =?iso-8859-1?Q?tUB0Mi3oPy4HiW187opLhpz4rc1nFIpvwkrnfgwLeRlX5kc2BJYqXVVjKS?=
 =?iso-8859-1?Q?B6CJCW0+CKJB2kiTwaLXWiprXmNW/ySMFijNkC47Im9387YywI8RG+QiLN?=
 =?iso-8859-1?Q?rLLgqhECASsR2WOZydZlFsoUW2coyNbj42d5XTuS4yV/WDoFe/Crl20K0o?=
 =?iso-8859-1?Q?OC+9UjqJ9EFaHZeKw5fujaL9qaYvssCliwsnCEoI1UWdE8YBJO/EjAH+3S?=
 =?iso-8859-1?Q?twcC9v+GegQPRRi+Nc8ezxmTLsMs3OWWChsk122gIks49pCbOXRrzKQtUe?=
 =?iso-8859-1?Q?6Smg7sBsg7UGL5FfIYwTrJBfUO0D8UoOImFhY792xHnIwlGIwM6yf9HW66?=
 =?iso-8859-1?Q?c4lb+2KBthdk6BO6kdIEKOoqP4teuK0KNnVNE5QV6o5hImvg9wge1bS+Tm?=
 =?iso-8859-1?Q?yQ+xkZqogS/sZ7V4ZhPdlEW95+qG9KRYqB1hSMW4YNFj+jIwr4gISvKxVP?=
 =?iso-8859-1?Q?YmvbyXOPfAIXqmFabNnn5+4t5uplWDvJKsIKlFICR4gT3XDqJ454gIXQ5O?=
 =?iso-8859-1?Q?PuATWEoDxRGcRhtMlbkzDqGNqycQ0KfEu4E4D4VWrk3yocaB+tvMcLpBGZ?=
 =?iso-8859-1?Q?d0p4UG6YcqRDK2ktcgCl5y4+iMX/a9aj5Igvu8BZX68bmO5L1PXLHbuoLn?=
 =?iso-8859-1?Q?lqhCfHHVnyPQvpqYSWv5Kjt83lQc3bU0yq5Z3sSJNuI+Gyk4+WYrvYEgBW?=
 =?iso-8859-1?Q?2Ou1zoSBdESL8X/OfsfGfrpGoRw0sBhPZLnq7yrk+WsHF4ghlP2glJuCIi?=
 =?iso-8859-1?Q?X7D8iqmJYg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5668.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80b2e01-8128-412f-ec20-08da4d3a15e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 12:41:49.6356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rPegYLsabFWdEZyhd7oqYGDBc7tR1h84dGDIoDmd/mKdCy7/6+mbhGMN0qjHCNLw/6OZ0EtrREXW9Y3MlPhWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3497
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Liu,
 HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Vanzylldejong, Harry" <Harry.Vanzylldejong@amd.com>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

Can you please elaborate on why dynamic memory clock switching can affect G=
ame performance?

BR,
Chandan V N


>On 2022-06-10 22:52, Hamza Mahfooz wrote:
>> From: Harry VanZyllDeJong <harry.vanzylldejong@amd.com>
>>=20
>> [WHY]
>> Game performace may be affected if dynamic memory clock switching is=20
>> enabled while playing games.
>>=20
>> [HOW]
>> Propagate the vrr active state to dirty bit so that on mode set it=20
>> disables dynamic memory clock switching.
>
>So dynamic memory clock switching will be disabled whenever VRR is enabled=
?
>
>Note that there is ongoing discussion about how Wayland compositors could =
usefully keep VRR enabled all the time, as opposed to only while >there's a=
 fullscreen application like a game. So "VRR is enabled" likely won't be eq=
uivalent to "game is running" in the long term.
>
>
--=20
Earthling Michel D=E4nzer            |                  https://nam11.safel=
inks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;data=3D0=
5%7C01%7Cchandan.vurdigerenataraj%40amd.com%7C005764271a144b5832c408da4d293=
dee%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637907136793233201%7CUnkno=
wn%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC=
I6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DNSiOtjfwkelxkZMRFLzFs1mFPvosOFZnqrcNvR=
b9J6E%3D&amp;reserved=3D0
Libre software enthusiast          |         Mesa and Xwayland developer
