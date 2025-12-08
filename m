Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32F4D3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 13:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4624D10E455;
	Mon,  8 Dec 2025 13:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mh8z+GwE";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013052.outbound.protection.outlook.com
 [40.107.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69CB210E455
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 13:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJntVeoQo5M7pnDJ//5smUwGJW9Fs56DDztNMmmrAKOGsGWurXjJ9lzM8hPpxoVpjhlokjsD2o2Z5+L8dlw2WXpRcMCVAIHuDvWXEY3EpWGcAiDztbPLF3VqVskZ0fa8GK3qcV1VwfQoPEY6Qyasyow0XMRqcEWcifa7Vg/Ky5YeyV5u8d29bWbQ557JDs4QX3GtH8PhOuLBrFzEDUFKkEkxUtx2INWogqDHXhbtZkVuFa7o1iGH2NZPTwaxYJuIaVhUMjgxB0iqkm/9CH3Y+ISITXThCrpnmE1guys4w61AUfeCRUsHZkMP8Q7BPoO28K72YjjTuzLXuIC3SubhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAJqG+XvQuLO6Bq7kcbBurQOL24tP4bNexKa9cYCaP4=;
 b=TSv/3W3kzrnDdJFO7qrxNV79wk2ge+976rh6iU0p79g1sBywLTI9ZTgbTwpb8RiHcB9g3Oxw1j4Ey9asF79rgVj49Eie6gnvtq1vZ5Qil8RtZuKwEUg8OStqnzFWZZ/ONSal5yO+B5uD8zOxCCPwcqQqXuWvAZReJV+zTCWIO7EfPc3pJKAo850Gzse9ezsZy4kptuAGAJoo4OSxasFHFj6NX/UXdv7JEO7UOuTbJt+ZvagGcJ1Pclooe9tHEsIDRksfT/9ZwvHhThB84XhhxT6AlX7oPXFdWRbTBC8vrqqIthzRsJIftQfUMZ6I71RpslJsUYUoH45kuUlok5rS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAJqG+XvQuLO6Bq7kcbBurQOL24tP4bNexKa9cYCaP4=;
 b=Mh8z+GwEJo2X+aOZZZiFwG8CzmyG1WBgnoNBcz83003TIjG7sRq8edOFR4SJmN2tCym5pRCowwWsvw04+EwU9HDJJLuv1jxOPBHhDAMDChDif2kY+59gBPb5swscWasV16EtyusyePvTkOPgukQYzCSY4DpHNgxlNQB4m8hOrME=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CY1PR12MB9674.namprd12.prod.outlook.com (2603:10b6:930:106::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.13; Mon, 8 Dec 2025 13:58:40 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%7]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 13:58:40 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 0/6] DC Patches Dec 08 2025
Thread-Topic: [PATCH 0/6] DC Patches Dec 08 2025
Thread-Index: AQHcY3ZvPtSbIFJAkUaDv3+l71qHDbUXzawA
Date: Mon, 8 Dec 2025 13:58:40 +0000
Message-ID: <DS0PR12MB6534E408BF6E32CF4D6978989CA2A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20251202102437.3126523-1-chen-yu.chen@amd.com>
In-Reply-To: <20251202102437.3126523-1-chen-yu.chen@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-08T13:55:49.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CY1PR12MB9674:EE_
x-ms-office365-filtering-correlation-id: f5cb6d0e-f9dc-45dc-26e7-08de3661e436
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PhUKpyfT9NrEN0OhVVNpf3zG2h3Qfzi9SPhbUEpKVQkPYBE6X+GNkT3KML?=
 =?iso-8859-1?Q?lLb7wNXHcpadsQGlyUvixNB3S2vAZv6bFc0l7kJVt6yqO+g1P5BIWdArNE?=
 =?iso-8859-1?Q?t0ipv9hyKdLw47E+SQIZaNZxcI6tHAxA8bZjXw9EBGQfK8xIm0M0eomTdi?=
 =?iso-8859-1?Q?jL3k3rZMbJSjjVW3DtpzbeRL8G1MJmUOWZ4Q9xXm/0Xrv7xpCn/DjbuPua?=
 =?iso-8859-1?Q?FWi9Z3y7jaEVGGNPepvRn/Pu90o6/Qak0tE1Rc2LQS3ndkOAFMh+yR+x0P?=
 =?iso-8859-1?Q?haA5tmEogUgzytd5hElO8IA0a1Hy9ge8drdAWDmisZZVCqGTWD02AHVjLM?=
 =?iso-8859-1?Q?9brTIZBvcVmMhpFhK4xWki19ET5kI/fvNDhe8iiAeggOdj0aAve3AEjqjc?=
 =?iso-8859-1?Q?wi/8ERT9OWnn4ngub/OdcrJl6MrthM8zwdXYCjmBVfxuiH9lP5jf5wb/ma?=
 =?iso-8859-1?Q?ScYnT4wELNDsxpOjph7mkq6Y4yA2OKOIB0ZlR9GWpUZnZq/9Xfn26N4uI2?=
 =?iso-8859-1?Q?KVPKvJ3RkJm6ktdgWKD51LLHpZLOpZEA08coDF6ZfNNBqZylpXJz+BCqoy?=
 =?iso-8859-1?Q?VzCe1CaUhd6hEFU2JLHtC2k82sQtHk572EbRORiZNd2bTnSr7lp4OtWohQ?=
 =?iso-8859-1?Q?M5yYQ2vy8pDurPQEAAPRv4fz2AMCdryBcZmxtZcwnaFDfHdPpdI1KgE6gp?=
 =?iso-8859-1?Q?Jr/h6wRw4dfYXofPSqAj6vJX/nTSiAvaDHj573/k3zqNlNifD3ea97He6J?=
 =?iso-8859-1?Q?g0wv4Gtlxu7p/lycGIUbTQBpAYaQ/5pdVeTPJzWZFCs9zjx8MxSUbE/9aB?=
 =?iso-8859-1?Q?8fbDriEeasqtMbXw5RZTpjCis5h97FB/pVbQTM8sXfiYayXbcDGNkrnj9F?=
 =?iso-8859-1?Q?/cBdiyVtTUXWBfNH95DB2AT7JBqULeJhIdfGQ6Wgwu/feFt13DEz/ILPU+?=
 =?iso-8859-1?Q?YNi8yK9okSHQ+bMyr8zcCokot2bX6BoBkT2CSFeaK+hYwy0QJvDaa5SJF8?=
 =?iso-8859-1?Q?ypbRetLwwXJA18G0385pYm94bpNQ0D9B8QmMwuQ/rQgCksldPH9+LcHSHz?=
 =?iso-8859-1?Q?CYZ2dF/qOPdMkfiTtIHddab/BSMFQRYR9Rrzmqyi/S17RdRgZIsayfikY0?=
 =?iso-8859-1?Q?csmI3CabSNzZEYaKvL4HJVW7tiHmCwaeiQiIppEWMVkiZzI7Cx6DGliyLu?=
 =?iso-8859-1?Q?ng1j2Lr8M4ikYWSYxhetPY2Dmrvtn56XJ/usBld3pH2AcK5fkK2UBW/E/H?=
 =?iso-8859-1?Q?J4XSgxu92kIrhpezZ8fwrrSa/ES/rlHAz04s3sBbwlFzOIOdlrCWFzcWRu?=
 =?iso-8859-1?Q?t/UBSIAu4IIfI7yDEqRYTd7Q8Jn2Gx5JGwraRDWPs5yaG/Xm4nWoL9wm1d?=
 =?iso-8859-1?Q?qFawqP/pSYpVnT8/o1iIK5WS1gNJnAOXyzxtIQwcCx1VR+zlJW1JslkDFe?=
 =?iso-8859-1?Q?3I1fBQj2wKg2Y2AEkjtogiwchgB1Alfy36cRDcvHDrqZVLfpm3wTwIlA4s?=
 =?iso-8859-1?Q?xDftwFBTwofFF6xgENztYZzCFjp2GZ3xdfsPZ6rhkHNhtPy76vK3bT9uiB?=
 =?iso-8859-1?Q?o+zaMxnaZy+QI6ChRQHqKJlAKUxj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pNbh9nJGkF2b1hZrl7ixK7FMvNX/U9lFnn70JVDPhqF9E2x825VdwqaLxK?=
 =?iso-8859-1?Q?QxU2REJ86kdmd02cW4GIXan+BsmZ3tzeukW8rF+wnqAuVb8UwxRK0tnj5a?=
 =?iso-8859-1?Q?40h2ZT7YEc3VOslbm2k72s+XRuT2ZDIdyAK4a7fA2Jb2+cUAONhpvDfq+5?=
 =?iso-8859-1?Q?ZhZNe9xeiVfZikgg3w0OJPFOnmhCxKHp8Ngb1zRYfct3rryy7M2OKgZp4r?=
 =?iso-8859-1?Q?Z56D3E/J1HzBUqH+s1QR4VmX/9f6vOBc+TanuU/Jlo0E/efyCXaSTV6cHN?=
 =?iso-8859-1?Q?ZL2nUvYHuV2IffQoyIK6xPpA5OEEnhOpLYc0cs8h9ufFcBCEdyABu+pvxW?=
 =?iso-8859-1?Q?FbQdx7ZZN6p+VsuGaZjoiXviYYuwwH0ZId1lafTGz4oLOumPeyeTlJLwKq?=
 =?iso-8859-1?Q?yAfHshjOMOTzkXyvzi1DoDVziwuUI9x2C5XfVJSnwFlUskEXMcX/Lz0NcN?=
 =?iso-8859-1?Q?+e/S2qbe+jVs/pvPZOcFEWOeB5CxrR/HSNBSHUSFOeLXmv2byoT3kiwjtw?=
 =?iso-8859-1?Q?ajGJIJctglb/CVRBrmK3IiRnIXnIqxiZo1Xz9m+6U8nNGrlyy579jtA/F0?=
 =?iso-8859-1?Q?KJBNRTmp7E1CQlbuPFZ9BbIglgX/OaGo3QujJrCMqPrZwQcwWcP878EmgK?=
 =?iso-8859-1?Q?J75K3Y8v0J0IItewLzSgZfGzPQwpaiD2CAArKe4b//jqqIwe4DJJe3oVqL?=
 =?iso-8859-1?Q?j+5uDR9AVWbg2JxFzZhiBTMzuFAPP3ATLajZ8Vptb5j2vvGxhmvQ14/po0?=
 =?iso-8859-1?Q?MK3UJ1Kp2Tj09vpXQx1GZ7jw3K3+nWqX+ct+1LsZL5Tat5h7hfa9uB2JH9?=
 =?iso-8859-1?Q?hnXo35GMRNO0Esxq2Bw1GpuNKrWwHA8zqAD9C7M1tpsW919+La1CTNUBVL?=
 =?iso-8859-1?Q?ktm1nBcJNbU4HbNAyAXX4tLxLn/ddtOK0cOIS2Epu1juNdYeTzDRl2Ac36?=
 =?iso-8859-1?Q?oqUHm1g4qEapi5+AXsYss0OVerN+2eahC/HVhPmabCFSGftRgovsPMsvdp?=
 =?iso-8859-1?Q?4N5ANMYWzHwambo1bfEhaZuZz439CeKl7wxqTTEaD9h5mrawXvbYGsPkpI?=
 =?iso-8859-1?Q?atzp8aG0X4eKpp3KM7Lhv+BKTDoeoNnjuhCWu7igavj029JT431/8KJkmA?=
 =?iso-8859-1?Q?fjyEjq2amIy279XcdBo9tlbh8HO9iEl3Cw4j+wg0xpsTupTPpqEe3ilhBV?=
 =?iso-8859-1?Q?9VOTY5rllHVbUtyBYMYwj0mR2kn7DQknkOrr4OzNO2pzX0dmq7xfLwmnrr?=
 =?iso-8859-1?Q?F1hAj0kJZbocqe4n7YbTqq31K7Zz1cTO2tSwDHXin3NBlte4jMer15nFJ3?=
 =?iso-8859-1?Q?wrnrjg22HooaPvgssd/s+t1molZJMqP3/SDty0DFWCXyuy8SwyazjCf7V7?=
 =?iso-8859-1?Q?lDLNOFuefE7zMJUE/CJbf2zMARVg45rhKaQPYRVKzDu1wHvsRT3ebGPjZG?=
 =?iso-8859-1?Q?nLaL58U3YgvjvinAvUzSHashq9qndpXHEdQk73IbE5z3ukCSmDh7gfT2BB?=
 =?iso-8859-1?Q?4dcWM2Xfw72FCQl6blHtmKRSFJPgBK4WnWMPEZDfpwmmDjJ9JxyWEILz74?=
 =?iso-8859-1?Q?BaBZOr8Z5txqInT4z8/3Y25hY9lrNqntvAWbaqJm6HPErkZDNpSFva+0wQ?=
 =?iso-8859-1?Q?XMTdp8DSqf6IM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cb6d0e-f9dc-45dc-26e7-08de3661e436
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 13:58:40.1251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImDWEf3GXfgD/f6+i44B4AbXQmybCXU5Ab5uf2KY16Ql6m6zBdhCqcBYz0cooShiJWWfdR93yn8mv36aTQYbpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9674
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
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz, 3840x2400 60hz
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

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
        * Samsung ATNA60YV02-0 3840x2400 60Hz OLED eDP


The patchset consists of the amd-staging-drm-next branch (Head commit - 9a9=
bbe98197771f67bb808ea078b3b95b4c1f22b -> amdkfd: Introduce kfd_create_proce=
ss_sysfs as a separate function) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using Gnome.

Tested-by: Dan Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


-----Original Message-----
From: Chenyu Chen <chen-yu.chen@amd.com>
Sent: Tuesday, December 2, 2025 5:21 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 0/6] DC Patches Dec 08 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

 - Defer transitions from minimal state to final state
 - Remove periodic detection callbacks from dcn35+
 - Fixes for S0i3 exit
 - Refactor dml_core_mode_support to reduce stack frame
 - Add additional info from DML for DMU

 Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Refactor dml_core_mode_support to reduce stack frame

Dillon Varone (1):
  drm/amd/display: Remove periodic detection callbacks from dcn35+

Joshua Aberback (1):
  drm/amd/display: Defer transitions from minimal state to final state

Nevenko Stupar (1):
  drm/amd/display: Additional info from DML for DMU

Ovidiu Bunea (1):
  drm/amd/display: Fixes for S0i3 exit

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.362

 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   2 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 200 ++++++++++++------
 drivers/gpu/drm/amd/display/dc/dc.h           |   9 +-
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |   1 -
 .../amd/display/dc/dml2_0/display_mode_core.c | 134 ++++++------
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   3 +-
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |   1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   6 +
 8 files changed, 218 insertions(+), 138 deletions(-)

--
2.43.0

