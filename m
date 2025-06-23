Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7645DC77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 13:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05FF510E137;
	Mon, 23 Jun 2025 13:11:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wbJLHqcs";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3794E10E137
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 13:11:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYkpj3gNaW5gdD3+2m1I/Pf0sB0RTqzg/RiuW+sdarfEXFMNts+JSdS7KaEpmoW/MyseRY/lRjtM7vh4Rey2O+9n3kQ1Yxb7tCCnp3xrDe/MLXNhTUT0rB0lTHmiy6DjYlDp5XNx/UINn0T42WH+tEAAR5M/Wibq+yyuZccV+NCgotG4tyFzrd5FsUppROILznxSG7vKnGTEYlSwfZzBLRen92wmSQBDaJrhLc+RFkJSPhbScibRWcOLuqSa7lM1lI/ddyIanug43DhLfQGX0UmP/Eu5ImtSQegiad0QQkPZnXc5VLydYM8G9OV3hpO9QMGhQh6t0y36BRCRPPplbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0VUIpvwe5fPWEKzq1ATEe4piM/G2y8IijoBJ/BJoUw=;
 b=mnvKQ8t8L31BAJRD/CzLMsa7lEDjJ81YVM50vwP8VC6GOrrWh+2J5mgY+VI3a4YDkpaDSnknjfSrTjN/p1n2qC2L3p2m5rxQJcmg7ax7KhDyCRtTgckkI0yfArd8Qi3d3bkGGI13x8p8UJWZEhDNZZusVpi2x/vYhSd6hzhOiKJcOqUvt3bj8nTLNtq2tiGWFzQsDocFDgueBkSmQK6r/1ZqlyVzYmdZMOcrM7T5YEav+B8HhcB1cueOEtmD2R5CXa1jRT1Q7HA/+zEoZk/YVUE/cqjJIVlv9hoc2p913Z8/VYVbCVbcm0CNnbBXrhNQhMsIV+Ru0qMGWgDegsNUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0VUIpvwe5fPWEKzq1ATEe4piM/G2y8IijoBJ/BJoUw=;
 b=wbJLHqcsQhU7/xnBQE1Vmbs7zSHOtrnQ89tNTidczBAdiLwHywdFtw4IwHaY9cnggWcmeIIx7hhLmiOnIHNMPdK95GgVAF89InD5JJRCkZnrYEvz4AKQpuhO97XqJtQtnK1RPZkBvUgkjLvuY5cS1RabpA/LVktsGVlS5vxXgFc=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 MW4PR12MB6708.namprd12.prod.outlook.com (2603:10b6:303:1ed::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Mon, 23 Jun 2025 13:11:40 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%5]) with mapi id 15.20.8857.021; Mon, 23 Jun 2025
 13:11:40 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 00/13] DC Patches June 16, 2025
Thread-Topic: [PATCH 00/13] DC Patches June 16, 2025
Thread-Index: AQHb4GlVjGjvg0iB8U+hdYc48zkF8rQQv3fA
Date: Mon, 23 Jun 2025 13:11:40 +0000
Message-ID: <DS0PR12MB6534F34F2E48652242404D939C79A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
In-Reply-To: <20250618153936.6472-1-Jerry.Zuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-23T13:10:51.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|MW4PR12MB6708:EE_
x-ms-office365-filtering-correlation-id: 0585f424-e616-4f9a-a6c9-08ddb2577e2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wRI7PPKciqi21tnR+9p7Iw9SgSeWy4JcFIUCpyP7d03TsQnAhpF2MtarKQ?=
 =?iso-8859-1?Q?jugYj4cNkxi5mk5aO/oKiecjXF4H9pFHRWt7ViMmjdy5yYd6HFr2SJ98sN?=
 =?iso-8859-1?Q?4xV+UMRqom09aibpTMoJ7WAhKnlRNRfoe8Lx3xOgO2oz8PIc97F2YMEIA0?=
 =?iso-8859-1?Q?gKqRwHAAXbQ6OTZfpEJsZvqmqZZxpxLKo/QaRZViuFFeCoob4H3/skPnMb?=
 =?iso-8859-1?Q?ztX1i7vAG2tzHr9Agb1LIMjgnY39L9FWLY/Fb4yhvs4xv8ep6JLn+Ejcoo?=
 =?iso-8859-1?Q?j1ZNU9bfUveON1OB320mJ5o8oiqQ+pV+SYRaUwBPaEet+FoELC733j3wRb?=
 =?iso-8859-1?Q?yh2PiV/7xH9uZF7C4Od3wfkn5k2g1tpUjUPsP5QD6zR4XkP+n5bwIVo+mQ?=
 =?iso-8859-1?Q?1lcW3N3FbajurIYFjz14jldq79/xtKYDrP8zkaqJBOQrUvV5y+uglmLRfn?=
 =?iso-8859-1?Q?gYXla6dZQtXqijgpphhIYue9FQAuGF0hdDKNt5RjXBHnvXeIBhbTSguefg?=
 =?iso-8859-1?Q?U+7fjKk60hbV5QCyiTghzrdaIG5um58mb0PCBiC3x8DPurkdOMctm4i/Wa?=
 =?iso-8859-1?Q?YJ+Uakqt7AvAO6Nm5n5eDHRXyC/hEH1DmgrZ8MdBQkkX233LHL01KdquHY?=
 =?iso-8859-1?Q?HGZVoY3nxih2F2/It4+dTNCU1uBV1iKXjxB5ihRMnXIaOf0aEnTQCVogJB?=
 =?iso-8859-1?Q?YKQx5MbPro072/qtbR0wbVnYfRd+STLn11k5X3nQOOcbIy7TgNdcJHC3Nq?=
 =?iso-8859-1?Q?GUKJWItoxxnQjYzdx4F4+kTkjgfj6SfJeQEBDRryY7c5hXChvwEeRizB1M?=
 =?iso-8859-1?Q?xLlb/aRe//Z8cH9KgAIVAkOsyK7pW/KGZT4A6AcmwGZuxnbbKCo5Vrmvc5?=
 =?iso-8859-1?Q?XtX1iNNOgh7pv4uiZOf4E5SIjp8tYx85KQwGUdG50gr9qqb6ZTM18QcCHz?=
 =?iso-8859-1?Q?eh3gs/C1Z/+NykyPTP5zpla2xoJ5uvhw6Bgf3KQgIvtfHslPjhooZN+Eos?=
 =?iso-8859-1?Q?pXqCVayzmgQJ4goltHMxR8SNCCsWnIYrBroqkgomxs9Tr77VN7xU9emnOP?=
 =?iso-8859-1?Q?7b40oN92rfnodGqFPFx8u+jj+oO5FfmVkdoMOEpx/GAtse39OwsAxizBTI?=
 =?iso-8859-1?Q?DsCHn4Up6ch3sfG/bTCb0efPZOwVw6sHNo39B8Zf6INW0EtJLVoo41mQxN?=
 =?iso-8859-1?Q?ALflXK0dCGF3msdlIZcO2/AyOGRdFIxIstBsPxIzkZ77EVxjUAgg/hm+3t?=
 =?iso-8859-1?Q?IAhwn7L39geGcwPEItmCMPAunfiropQByPYZ4EJO34gMlwtJcHU6X+6ziV?=
 =?iso-8859-1?Q?EOlSxy0h/mP0XiKAgV6OClah9Jm5xHH+1bwcluJ+udH7GWzzCk3oWLSLGD?=
 =?iso-8859-1?Q?cwr78goT9EWXfk0+XN0HT+V4Bn7B28Jsm/ZNqnRBn7USt3xRzNW+ITbz7P?=
 =?iso-8859-1?Q?vw97D8LO+AH9bqCSVBMlCOi8z6eI8njXuMUSd+31VxGh58/3RvTa623sUS?=
 =?iso-8859-1?Q?fcpcTGv+BOMmd5Re8sPUzzPC9fbc0B30BNwKhw8mpwkg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?epuj2yqR8yB/rVl+paf/E00/CsdS2NXbcJJy0AYWJfpAm8oXtIFGx8KJX1?=
 =?iso-8859-1?Q?Q3yicKNiZkaqe6gUzrbC1G/m2/5nwMIVq9sAcaX83cAz7KnGeCNjCzVUdn?=
 =?iso-8859-1?Q?8vLrabzgRAp3KzVf+PjUwFIVuEfmQY/HKJR7PvqZUNSPbwKFSQ4RKsf9B8?=
 =?iso-8859-1?Q?4vlf3q6duVeChfcTAXDBF6zNXle8p3O+7LhFAGILTBKBKtRXz/tLpoSFZD?=
 =?iso-8859-1?Q?Z0COhKlC0YDCuvRCYrgWUnoZuE0O/s6bXBvS4G6ayIiVWUFKDLh2obWupV?=
 =?iso-8859-1?Q?kwY0CCAw/sp4Mpf9X6mt/S6NEZAIaaQNcHQxui28oUBMxYSpJOmWQU9hxr?=
 =?iso-8859-1?Q?/yfgoI6+z9NK6VsUrZwwVjPGrBMA3YjejK62YvfVp/6oOpJ7ljeDJr3VrU?=
 =?iso-8859-1?Q?ul4JCHlFDCXEy2uJ0c8UIOlBLoRxxvVssDWvyTqVO8fCz+IBiWeWiaDVN3?=
 =?iso-8859-1?Q?07w9ES3iHu/UW+2Fm5AK7obeVEWa4C7oRA268rIHusq5mksXzveZv8UERA?=
 =?iso-8859-1?Q?oluPnxFpZFwyU2t9QOSYQJv1xfJEePm9zIElR+/q6tQeT52KjzL9oi46yz?=
 =?iso-8859-1?Q?1R8xXsjz74GSXWLpAcnLNfydiThnp4Au0nCXRepBisFHmDciTuy3dacPhK?=
 =?iso-8859-1?Q?6rkplaGG6M22n69ClExxYwAgqgllwyeAdMjVCCtqNFVX6BB6pQGYc3+/j+?=
 =?iso-8859-1?Q?hNOn/bq3P/n8Edj6/ndnpmX3wUSuLrrp/Gg4/m9IpHQ20DHngUf+6TpyIM?=
 =?iso-8859-1?Q?8bUEhkv92J1t5sagCrYPKrp6VmhK09pz4FIDeoARrft9dhoPu81QepMb3Z?=
 =?iso-8859-1?Q?+7PXVnQPFinfOt2xTNWf9qKXT4/EOjF8fcvdYexjjWq01Oi4+D1Y1SabRY?=
 =?iso-8859-1?Q?wQNAwAGaKmJqzEoTaBIDnYHyaf2sxLPAUqQhbBGg7i1/v/q8TMza7/5xmj?=
 =?iso-8859-1?Q?e5Ck5rbCyNzY77wh07Brq8f4wOUbpI8g47MdhGC6aR7ua5vx+Gxe4AyLub?=
 =?iso-8859-1?Q?K0ytdd+QNwNi848wEH4/AdLA3dC+hElJVwD3plePDFF/1pQC62Ru5hzBDb?=
 =?iso-8859-1?Q?22Zmj0p1ljELjDKHGr/Ojw8B3qz+X/ZKLXrEqkm7jlr7Cn+u/9NP45U7/7?=
 =?iso-8859-1?Q?AszjnM7x+mhPy/6wXMoFdN2iDXHNqz5KtLo9Qb0kb/hrG3+fAnTh5w8G8H?=
 =?iso-8859-1?Q?hAh0neVjowWo/JgvzNW25YjCi1bqxMgRxVMk/wi9NuJzRqTvrI04agSs7w?=
 =?iso-8859-1?Q?69SZBwdgKnmcomeGcH73Vzfk7EvUoDydTid2q7YcahuVs4V2zcbhGTsoBY?=
 =?iso-8859-1?Q?aGkHRlPQT4jB/uV7A6ZFKD04pBGJtzEv3DG23PBccDlLDhq37rTGT37N6a?=
 =?iso-8859-1?Q?ap6pgqI4IK6ZEQFoWMq0cKkalJ8RT5we4i6Ze044A3R0kGls8BAjQlmOnf?=
 =?iso-8859-1?Q?IrfhtlxGBedjc0T2qOprHyV3GhqgKNxHa282PbzABVrVoSrKQ6NXBHzFW0?=
 =?iso-8859-1?Q?I5KxJ5Ut1GgofYyQ/HoDnMfwhhSGcrVb2kR7n+WEJ0aB/QLniUQxijI+Bb?=
 =?iso-8859-1?Q?YsNWI6ivdR9oOgZUZulYs+2igA5L2UEDnhEsTTuYZc6NK8IxsKNxvv8zpE?=
 =?iso-8859-1?Q?xmqTz2Ld48QN4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0585f424-e616-4f9a-a6c9-08ddb2577e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 13:11:40.5105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJG7/ilAO1rlss14nyz2y6/KSGFcpgK1ykS6iqkZWrm2DjqkE8UiLOxBYAIZiu0xWgPNF2LCKrtiid4JsC7G9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6708
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
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 77f=
ce53066ba8b9e4c5d3b93349068a4ab109ca9 -> drm/amd/display: Promote DC to 3.2=
.338) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using KDE Plasma and Gnome.

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
Sent: Wednesday, June 18, 2025 11:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; Hung, Alex <Alex.Hung@amd.com>=
; Zuo, Jerry <Jerry.Zuo@amd.com>
Subject: [PATCH 00/13] DC Patches June 16, 2025

This DC patchset brings improvements in multiple areas.
In summary, we highlight:

* Improve USB4 bandwidth validation
* dml clock calcuation with EQU Prefetch included
* Tweaking udelay time to fix "failed to blank crtc!" error
* Add LSDMA support to DMUB
* Fix Coverity issue

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Initialize mode_select to 0

Alvin Lee (1):
  drm/amd/display: Removed unnecessary comment

Austin Zheng (2):
  drm/amd/display: Include EQU Prefetch Bandwidth For Bandwidth
    Calculations
  drm/amd/display: DML21 Reintegration

Cruise Hung (1):
  drm/amd/display: Add new DP tunnel bandwidth validation

Fangzhi Zuo (1):
  drm/amd/display: Rewording Mode Validation Result

Ilya Bakoulin (1):
  drm/amd/display: Add num_slices_h to set_dto_dscclk signature

Ostrowski, Rafal (1):
  drm/amd/display: LSDMA support

Ovidiu Bunea (1):
  drm/amd/display: Add DMUB IPS command support for IPS residency tools

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.16.0
  drm/amd/display: Promote DAL to 3.2.339

Wen Chen (1):
  drm/amd/display: Fix 'failed to blank crtc!'

Weiguang Li (1):
  drm/amd/display: Remove redundant macro of refresh rate

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 +
 .../drm/amd/display/dc/core/dc_link_exports.c |   6 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  16 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 297 ++++++++++++++----  dr=
ivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  77 ++++-  drivers/gpu/drm/am=
d/display/dc/dc_dp_types.h  |  15 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   7 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   2 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |   3 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   1 -
 .../dml2/dml21/inc/dml_top_dchub_registers.h  |   1 +
 .../dml21/inc/dml_top_display_cfg_types.h     |   2 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |   1 +
 .../display/dc/dml2/dml21/inc/dml_top_types.h |   4 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  46 +--
 .../src/dml2_core/dml2_core_shared_types.h    |  99 +++++-
 .../dc/dml2/dml21/src/inc/dml2_debug.h        | 149 ++++++++-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   6 +-
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   3 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  10 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 +
 .../drm/amd/display/dc/link/link_validation.c |  85 ++++-
 .../drm/amd/display/dc/link/link_validation.h |   3 +
 .../display/dc/link/protocols/link_dp_dpia.c  |  15 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       | 169 +++++++---
 .../dc/link/protocols/link_dp_dpia_bw.h       |  27 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |   2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  10 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 101 +++++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   4 +
 .../amd/display/modules/freesync/freesync.c   |   2 +-
 35 files changed, 970 insertions(+), 203 deletions(-)

--
2.43.0

