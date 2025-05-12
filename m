Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4714C3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 13:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5300A10E05D;
	Mon, 12 May 2025 13:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jglTYhCH";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B2C10E05D
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 13:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0nPCggNpb4eRaAo3GfSY/JVEqLDB6fUX7EknqlRj1sgnJMOUpu0iNBf7VQS2dGj/hS9LGJhTff38qqWYYairQU13hkn1lmUUpPLUFEgqpth/1ziYh6nbNNy85lTOeU/NXxka4+9CYpeO3+aHXFtsaTnQci6usINRSa372A/FewDUYFzjpzL3vkSfjqb4eGR4Y+1R62pAx2BU1md717nUdv8YhML+Xsh//zMfQrN+75nG2V0zNcqSfUw13FVjBfhwZJwB3i3SXGtbvQroYd2rE774Q9CdZJM9A292WK+MHUtke6MNXAaXvc2lF0/mJd/kkp0cpFVZ1gZWnRVOfrNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxFkXHRC5fhhkok1PS7E2xm0xInC8WlVm6D1rSUdjcQ=;
 b=KHsz6+M3Qpk9PVplEpHaWYiaYidGTDrhjobl0anBllCWJtH5oTHZJo3o3Zm1t//m6HOm+lLN0lHN6rz6QwsGnpYjx0/s9MR6fdbbcxksT/npWwqGy9C5GbJortb5mUh1NJb9Vg9fu9dSAx6yluLaHAV3rEh4Mm2tW62C4FpqMeNCtPCKb/S4TFtpZZibKnbJoMcPw6W6AzUL+8XAOdRNtVued1q4ws0s65UnlRJPmIsp4QuI5wAhuU6qdafvS2jrb1NwdDYjx5z8Oni/WNhB5qmMvg9gFjw6W/bDkYrQdSULSnr+hsEoq7c/VNW2EGl9p2XIU+K64yuOc+2Kiw22Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxFkXHRC5fhhkok1PS7E2xm0xInC8WlVm6D1rSUdjcQ=;
 b=jglTYhCHmp4kP9WiQVdYKiMCFMFRbZjcK3U57AoOOMYEXSdka5Lb0Qb6HpQhsAUxq632CYGIIE9A40g1/rL0ewnzhTacp+B4gJ3CuL137ceHdxU9VCSahp/LZBgjIDJ9byRyZOOe4AdCNnVbRPjdNgrAcaIEWitSBcpzkwqvFJo=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 13:30:05 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 13:30:04 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wu, Ray" <Ray.Wu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>,
 "Wu, Ray" <Ray.Wu@amd.com>
Subject: RE: [PATCH 00/14] DC Patches May 12, 2025
Thread-Topic: [PATCH 00/14] DC Patches May 12, 2025
Thread-Index: AQHbvvnDofDwH6V51ECxCKPHOQ4rqbPPBWfQ
Date: Mon, 12 May 2025 13:30:03 +0000
Message-ID: <DS0PR12MB65340E98A545CBEA64CB94AA9C97A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=8d9a672a-e3a7-4044-ba14-6b5185ce2eb4;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-12T13:28:30Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SA3PR12MB7807:EE_
x-ms-office365-filtering-correlation-id: ff8b22e2-3253-489d-9f47-08dd91591aac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?9IW7o25fuYYVfHSsG7tTXBEG/JTVpBGCaJVYadpL++bh51NF7TzcWXYxvs?=
 =?iso-8859-1?Q?YPcq276O2V29T8AeNAhmp7BCg1l+cGpjj7N9V2Sxb5k0cDWQu9+fLE4x9o?=
 =?iso-8859-1?Q?5p3OJaCkT5o50oyLYVW9lplgxLqMr58tr4x8VnGRTt63Y1QoLbtns40tly?=
 =?iso-8859-1?Q?7tRc8zA7du8Sb1eOxlKJd6+PfcDrIj5ncdY/vqtqrzirL9u3k0j/9XwqPd?=
 =?iso-8859-1?Q?TkXQYCxYE/aTRA9cO0OGlfNtnAQDF+DmY0DYJkmBUQLSIor8AjlMq1NK25?=
 =?iso-8859-1?Q?jqsjDASRaVnik/2GbysOcIp0q2hlGLmYGUdqPCLaIbjkAnX7JDJfY1GCTC?=
 =?iso-8859-1?Q?V4xS/Bwq8DpbCY/EyRmf0307k/02LLYrLi7+Rtw2bjVGU+vU3S0c4Kdx55?=
 =?iso-8859-1?Q?C830UqmrnIqpQFpNsy7NrvBp77ns4bC13Kbu2lxg5DM49LdhTYYiwF1hT5?=
 =?iso-8859-1?Q?6a3CTNGU0bXKpd8WgGmNvh9pTbAKd2CM/DJCS1O7GrjO6lChXJ0kKFXmMw?=
 =?iso-8859-1?Q?6wtqOylC9jM48jTjt3VAc1NVd+cyGY7U+0b/SpPCtg/CfGpy99MFo+9E9u?=
 =?iso-8859-1?Q?vsqAQwQTkCvEFyqMD4D220zRyDtMTRldkRpM0u2PgiE+gjgPwsHONL8B0K?=
 =?iso-8859-1?Q?8NMhuv4ISjLBgCp+JE98nYg1iGzBPelVTjsaxRO30Bic0DTAGhPqTTBvJ6?=
 =?iso-8859-1?Q?7tp0e6J3JHtcv4d5NVdUcdQeYi3iA7yPcxNCxfYN7lTA79JMJV1c5y4xY/?=
 =?iso-8859-1?Q?6brlFSdgU3IcSRwiX/N9ZbvlLgpk1WSGuO8QO/mLgdZm054xANkAxMAaxk?=
 =?iso-8859-1?Q?cn5/MkjbqhhmlwohRwwR7eOePhaguQ2l69Apz491s5/VlqFrw2ONtv+XvH?=
 =?iso-8859-1?Q?gWinWI0K+IKww33t7pJO+floSfDvl2crDcmWOIRZg2+XBRTcDg8nP7vfWF?=
 =?iso-8859-1?Q?1RuBGR7ZC/B9sin1wPH8GKaxrbiZFgcU16egL2LkRWXUA5ZJLSpmEfJUez?=
 =?iso-8859-1?Q?5HpL92bIqrFfCng3GtW/eJ6kCQDsz4OUY/LY5O5xYqncxcbQqh0nQ1pBDy?=
 =?iso-8859-1?Q?bbVmNdgPDzLDr6jdfwH/xYFxXtl5Yz4FcG5xBCZtQ4jHkrFGll/8c/20sm?=
 =?iso-8859-1?Q?dMyKvi7GMc9u10QX6co7O9BR1zZjIsupTsjnT+hQLLqNr4n6YLOS8CkULJ?=
 =?iso-8859-1?Q?BllfDsE5rUNn5sdBeu8AB3Wd3chVBsxo8jJXkxUUYpWFOekql1n7FN+CdG?=
 =?iso-8859-1?Q?56MvTT1x9n76+59AwNVv+weCvxq2jnbK2Ajsg2Gv3xB0FSyDDyNYZTx0Au?=
 =?iso-8859-1?Q?D7hAjomTOJmlk+INVQ6AaGOIyssed8BFhyslIDSkeCorjlL+OtDFxtCFA6?=
 =?iso-8859-1?Q?UANUP40ba9wsK2z8SgzgYv1rRBhE3zEWcCaQJeanQ0W22Xi2eIdo+fj06v?=
 =?iso-8859-1?Q?oIuUpSO2ACy+ZUCMpOhs+l+adCDG33GKIjwoN8Z+eSYRDzsROSRdWpxtjJ?=
 =?iso-8859-1?Q?UntFu0EiIQvuU2i7TPBBsOMOKDZbUSbl6DF5SL1Ha8NQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nfzx64gcl5xYH0BnnIsTGK0A8NlzOu38aA/9YWfkb8xRRckX8txw/GqzUJ?=
 =?iso-8859-1?Q?vytO+LUAzNrZBejHq3fpDvostU7tcvzsVSw8HtSSywGz1sz4uPjUxcNoGs?=
 =?iso-8859-1?Q?E1m36QiEuONSKnG/mD4VGmKJX0umSFr5WJSeL/aOenqx2nimdtltFN83YR?=
 =?iso-8859-1?Q?zaGv0rvLVHPZEj0iKXLeU9kCKurvlKW/cqoE2LI4SV45RXLi03w4LWU4nf?=
 =?iso-8859-1?Q?IKSVxe6MmoanTh4KfplOLwWq6nJXW7Y0I8om3k5RpB9tt1N6hkuxBk+new?=
 =?iso-8859-1?Q?sg7t5wN+xsdd4l+IEHpzs6Ggb6/tQqOoCy5GawRHBmm/LaMUpOxOsqYObW?=
 =?iso-8859-1?Q?rX6RdnyZaWPtulmd4F5Ya04HCcLlHA29lvrFGv4MR07o7gZs25/9xk+Z2i?=
 =?iso-8859-1?Q?LNorPSob1vugL6ohXGLFAT9QM/2cvaWIYoWrWnlD8adZTSlTL2ci+b/80C?=
 =?iso-8859-1?Q?oOtTD7Ra73OMC68zDtelgJ4QySdoUu7ncNWBTVEnMgtWz/lVPkpyF91upe?=
 =?iso-8859-1?Q?GORVtQ4Vktuq/sRwsCBNqgO2/U03kBsSEi9i8C+USfVcSthldevRIRWTtJ?=
 =?iso-8859-1?Q?FFwapsH2XcSmKMvzQsJ/WQ/mKLI1B6k4lKiAWfVJUd70KN1fmz9XVJjMMf?=
 =?iso-8859-1?Q?79QmwtWOydSO14CbIZX6khXYMgPu6WXDnKJGfOEtwzmsP5lDSn6H3o/1LQ?=
 =?iso-8859-1?Q?1mhRvW7aVNl3aPkqDrmnTTu1Mwc+g7oXHq/Hhkk90mRZahnmQBCjx5e/SC?=
 =?iso-8859-1?Q?86OKkZS0vlQJdWqHiNriQD/QUk3ZHRbzp8h9ZO7C6+HWTRhsQS8ohTOpJB?=
 =?iso-8859-1?Q?mAG+38/mr3AR9uRIEFOSuGyVmhYZpWs0cZ8VnkF5zziQjLpDhKIW2RMITt?=
 =?iso-8859-1?Q?NZ5AtxORVdKkvUF3LM0oJBI/kqL41I8ak8JtKFVaFC0PztIODx386LiRj2?=
 =?iso-8859-1?Q?J+9bpsbUT6rZj9FtPNE5f+vQOv/NLXJPWyKAdVGgWpuUfz4NHTbEHzoJB4?=
 =?iso-8859-1?Q?Eqa4M+yzONLLz+ID9Q6DdDTTeewpatmKmx57xle1tFbb7p60E8ZAQd52bd?=
 =?iso-8859-1?Q?jXUWkApnESFg/x51GmOpmn/2VYCoTk0C+B6qQ81hn/7tcy2g1AOgHakhQ8?=
 =?iso-8859-1?Q?Vr5EI9hYq2G6KswutEND0ePZmXptCxjTees51tFuXpU46qQeIosIA8kqbZ?=
 =?iso-8859-1?Q?zL9P+eUd00WkwE+SXFRBKqneIqJ8ZPG5RvT4RNIXGkP6LsmDCl95yd2kTJ?=
 =?iso-8859-1?Q?9phY0AcJlWoHonmhqVV6SD8ZTl3RxIlXSb9qFjgCOZS/FAWnHq1UpmgtX5?=
 =?iso-8859-1?Q?U7HSimVN1CrRWHHDHJJYgkUxwJhqKv1D9ussxHCO/XmtXiSRUxGIobYJ8z?=
 =?iso-8859-1?Q?HbhwWYg5i4Mzrl7QZsGG99ICGUfj7q6gLACNWMbYLPgdCM/mDlbN2HXRgC?=
 =?iso-8859-1?Q?t6S6rX7NifnY9cxqTurDwpQATaJNl67w5m0/E1SA4CsZwfP940cKBWglCs?=
 =?iso-8859-1?Q?uRxvUGYx4Htq3cKkY32gFd6ObzPx/euyrO2UetmSqoDhUQS2DMJ2Leo+Eh?=
 =?iso-8859-1?Q?W75Q+TXEY3u4xozGLYo1apaOBNHi9zmhGs4G+xEJLSWbZKqADvA7xZad+Y?=
 =?iso-8859-1?Q?ahNy0zMB+3ygY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8b22e2-3253-489d-9f47-08dd91591aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 13:30:04.1669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQFA4+v6M4Y/w9pZs9jiNhB6pi0wljnKM/l2V791ow2xBcpgZNR8Gt8iYtKFZnp26RmuntvQv67kcMiZ9AT6YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807
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
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - 554=
f79d8cf32cd7a3352b9a2422834db6643e9f9 -> dma-fence: Add helper to sort and =
deduplicate dma_fence arrays) with new patches added on top of it.

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
From: Ray Wu <ray.wu@amd.com>
Sent: Tuesday, May 6, 2025 10:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.M=
ohamed@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Hung, Alex <Alex=
.Hung@amd.com>; Wu, Ray <Ray.Wu@amd.com>
Subject: [PATCH 00/14] DC Patches May 12, 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
* Refactor DMI quirks
* Fix link-off issue triggered by quick unplug/replug
* Fix race condition when submitting DMUB commands
* Correct reply value when AUX Write incomplete
* Backup / restore plane config only on update

Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Aurabindo Pillai (1):
  drm/amd/display: check stream id dml21 wrapper to get plane_id

Dillon Varone (2):
  drm/amd/display: Backup and restore plane configuration only on update
  drm/amd/display: Fix race in dmub_srv_wait_for_pending

Gabe Teeger (1):
  Revert: "drm/amd/display: Enable urgent latency adjustment on DCN35"

George Shen (1):
  drm/amd/display: fix link_set_dpms_off multi-display MST corner case

John Olender (1):
  drm/amd/display: Defer BW-optimization-blocked DRR adjustments

Mario Limonciello (1):
  drm/amd/display: Restructure DMI quirks

Michael Strauss (1):
  drm/amd/display: Add early 8b/10b channel equalization test pattern
    sequence

Samson Tam (1):
  drm/amd/display: disable EASF narrow filter sharpening

Sung Lee (1):
  drm/amd/display: Program triplebuffer on all pipes

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.10.0
  drm/amd/display: Promote DC to 3.2.333

Wayne Lin (2):
  drm/amd/display: Correct the reply value when AUX write incomplete
  drm/amd/display: Return the exact value for debugging

 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 159 +---------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   9 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_quirks.c  | 178 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  46 +++--
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |  14 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |   3 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   4 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |  20 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  13 +-
 .../dc/link/protocols/link_dp_capability.c    |   8 +
 .../dc/link/protocols/link_dp_capability.h    |   3 +
 .../dc/link/protocols/link_dp_training.c      |   1 -
 .../link/protocols/link_dp_training_8b_10b.c  |  52 ++++-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |   4 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  14 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  50 ++++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  58 +++---
 .../amd/display/include/link_service_types.h  |   2 +
 24 files changed, 439 insertions(+), 221 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c

--
2.43.0

