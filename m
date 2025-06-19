Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF2CC7115B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 12:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D288A10EA1E;
	Thu, 19 Jun 2025 12:56:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hQ2naWtu";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F50310EA1E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 12:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0MgzlqVPW+x9YGGkNgBnTkcbb/6bbTtTa9a5q8VlA6+twatAk5ZKg5xxJ5ou08iplKcOg0LfFE4ziSC5mKGlqwpYIOicIONdl1GGxygW0zljQ6viMc+sC50qQx+aICUqFAxn1bp+XvN89wRtQGquWpm1/NOMm8dkJbT5F8lqRqBmMln+uC0Nbqwv+Byepdn3g3rDYeTGTFUzqw/fbLmKH3eW0AOgRPQAetAU7qVuwUfhZJPFkJiPFCu/t/uirGIyTkjaf/hHfREA5UBJ/J3cfQzFCX5zreMIIl+Lz3tpnOmH8c6+0zKEny9fzCQI3BDDd6U6zV/pWh76mGE8D+W7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCoRWXNhgqoMPrnw0z3GvODxqgDvTtcO+Hjll+dUS7U=;
 b=PrzpJwM8QLx7cz597cIbPURIBNUU7PiWrDm1Hfpb2SFcpjmWnUkPdi0JHBQIhGx4E3L3w1qOxYZ4B/j/ryQG3nKR1kg9CdXJZp0FlJ8hULtmfDDUrWQnXX2RU/jXrb61guCcoZevCVHfERmwp0INT6lBrqjsK/xewcxHMIWxnv87z94pL0Vg68wexrxTDW5ymqJHFqWtKxmk0BNhvKOA9B+ZrNZ3xq9Z8EZVQNAi/lgGIUZgYImmjEXgP/IGa28HWBrwV6Tbt5jufkf78Ir9mAdbKRwVXgcM62zWVXK/OegIbx74XnqHQZ1fUm67oazF0ytpxJGaBKKYiBXPuzsWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCoRWXNhgqoMPrnw0z3GvODxqgDvTtcO+Hjll+dUS7U=;
 b=hQ2naWtuIgbr5r1LEU0OqqzNKSCIb1PpM23pM1siU9/IvJERDTCN1YPjmdGHs3Ayv/2jXbH4+Ax1OZeKUx/O34LeH2K22hNS2Yv/cR+rNaQP/ahmH4+F9vdyBuM2A2NNlSUkmBtoym1qmKUOI6eFHwVGSCPLeUBul8lf5wUQo20=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Thu, 19 Jun 2025 12:56:42 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 12:56:42 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2 06/11] drm/amdgpu: track the userq bo va for its obj
 management
Thread-Topic: [PATCH v2 06/11] drm/amdgpu: track the userq bo va for its obj
 management
Thread-Index: AQHb314tqHpcMP3aHE2t/tU8Y5VJ2LQHfOGAgAL1xJA=
Date: Thu, 19 Jun 2025 12:56:41 +0000
Message-ID: <DS7PR12MB60050D7B9515C8446A00035CFB7DA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
 <20250617080151.1093481-6-Prike.Liang@amd.com>
 <CADnq5_OC_Hej2okXWu53UtJgYU-=ga+DobZ-reaintt2eCjqjg@mail.gmail.com>
In-Reply-To: <CADnq5_OC_Hej2okXWu53UtJgYU-=ga+DobZ-reaintt2eCjqjg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-19T12:50:19.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM4PR12MB7741:EE_
x-ms-office365-filtering-correlation-id: 2cd3f12f-d086-4565-fd22-08ddaf30bcf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UGVxbmpCK3RKNFU4WW5qTWFHVXkzUFozVFF1TE5iRDg3cy9oWWZDVmFseFZ1?=
 =?utf-8?B?QWZVRm1KcXRDZkxFKzVrbHJpMGl5NE1oeVRNMzVJcVBwK2NKTmEwVnBveXpv?=
 =?utf-8?B?bVVvNkhzdjJLY1c2ZlI1WGorQVBCRmJlaVhyNW1aN0RoaVVOUDlNRWliOUt1?=
 =?utf-8?B?Q1UxckNOcHF4Z1hOUFBveDAwNU5rdzNiNFFFSXhrVEJCMmk4aG8vdWRzbmhn?=
 =?utf-8?B?Q09EQjlpUUJXT3htblVSVmc4VllyZGE1VERWUDJia2pIM3d5N2FacFlwVlN3?=
 =?utf-8?B?czArZ0I3QjR5TTNhTjhBd0Zoa2U4YnpseUp2L2RETWNGRHlqMnhSQWY0VFJV?=
 =?utf-8?B?RUNvbVRiOUQvb3A5ZTdzRExkcTlHNkEyTWRJQWdFQlJUY0JpS1FDMWJJUVEv?=
 =?utf-8?B?VUV5bTJBRFRrMzlrMUtTdmFZa0NuUWdHNzdFWjA5bHJWRWNzR3IrOEtVMU1R?=
 =?utf-8?B?dC9nYTJjeGFzamVNNXEyY3VQWnRIeUdzME5nT1FGL2FjbFpYbmp6TGVyczQ4?=
 =?utf-8?B?cVFJVjdORkZ4M21sMlIwbzE1QXhob01FS2cza3ZnTndEbjZQM2hGWGhNTUpO?=
 =?utf-8?B?TmIwei9tUHJwMWxmRjhVTi9uOE9MVmJXcVg1ZmJzWTllRUFqZHM4R2J1aGg2?=
 =?utf-8?B?bXlOc2JvMzhjWkpRQ2xUNFF5QkVKelhrSU9wTXczNVd0RFlhdWQwMU9FUTJo?=
 =?utf-8?B?ME5nWU5JdWgwL0Y4NmZiNEU4dzFHMktJbzdDTzZQaWRRNWRpWmxSMmoySlNN?=
 =?utf-8?B?SXQ0V2xIWWxjbkdKRThFL3d2ZFFtZlZMVFA5NEY1ZVRlb1AzakI4UmUrVzJr?=
 =?utf-8?B?S1lrSms5UEpyK0NiMUZXZnQwZFM5Unc5aUhvS0NRTGlXdUgxbFZIaDgzMkRX?=
 =?utf-8?B?Y0RBNC93WC9kak15Q2paaEJZbDRhS3A2c0UrRm1tMjlMYjBCd29LVk9rNjA3?=
 =?utf-8?B?S2dlS3Q5REZZQytzeXN2ZWU4K1haRTA4TGJ3TGdMVmZhMWJ3TUNyTHBQTi9L?=
 =?utf-8?B?cjJoV2hhMDBtemtKeENiUGFtRmxCNC9jZzRXSWNUZjJudlZkNWpOaFRYTzNC?=
 =?utf-8?B?SXpZNXNDOFlQMVdscnVWYkVZcnBObGcwc0JiUGdUUHFkWnlta0EvM3FsY3dV?=
 =?utf-8?B?TnA2dEhUSGdnbjNlWThpT0l6cGRVWDVsWFVTNWR2eFZlL09nOHV4UXdJOEly?=
 =?utf-8?B?d1RBVXhONTFpeU1IOUZKNlJZYnNhYWUwM2VKMkF6S3Uvb0g1OS9yY1Y5M2hn?=
 =?utf-8?B?UzBYdlNqQktzc1ZQd0hZWElKdTZqeXRqZHJVeVptUnBmdldQbWs5N21TUCtl?=
 =?utf-8?B?WjEvODE4Rkg4ZWtCb0RzTUJDbFo5dzFadUN4UEtVUkp4b3plZUgxaGVlMmRE?=
 =?utf-8?B?UFNITUx1T1lzUURFOFNON1NzYXp4amRvRGRlN3FaRTRhbUg0QStKNTkyT2gw?=
 =?utf-8?B?cDhiVWVaQnovNDU0YTdIOC9WWVNYcE9WMGd3WXhrT1hnaURIaXowT2pyMllI?=
 =?utf-8?B?c05XTXMwTzh1bE54cUpkdTFOYktsTS9FK3dKWXFQaEZscWNvWEhaNlU5NTZM?=
 =?utf-8?B?eEpiQXpEOGFJeWYwb1ZxNnZkNGNzMitsRVAyVzI0Y0l2ZXdvZm9oY0p3cDY1?=
 =?utf-8?B?SVI0cDVIV0dMSlhxM0RVR202QzdlOWpLZDl6YS9Wdk01VXhWZmRBcE1BekI5?=
 =?utf-8?B?L1VKRmV1a3I5SXZibVVOdE5IZFdvTGQzU0pQK2ZmTkI3S2crMUZhUVpsa0dS?=
 =?utf-8?B?bGE5YTBmZlhxeCthSno1dWtpcUhFMWZHZ3hYZXZOQ09sVi9iSjN6WUhSOWZQ?=
 =?utf-8?B?T1NuNWxEdXM2Y0k5cXMrZjgxaE9ER054dDFFcDFrRnJhM050WGhrdit1VzFz?=
 =?utf-8?B?MXp2WmFrY1VoOG9SbmxwS0hNbk1jclFHNGw3TWlmZkVyZG9LanlrbzB0dlhM?=
 =?utf-8?B?NXZkaVdnYWFtMnNGL1BpaUhzWU9YSi9ualZ2LzNYN1htejVNQndnMFBabXRw?=
 =?utf-8?Q?6a4VIXPETz8bPOJah6DJmdYifTTSGc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0NvSTNtUFdkcjJ3dVdaeXhSc2dwcnViTEhXN2JwbmRoQUY2RnZKVEkwcmFX?=
 =?utf-8?B?Y3RWeGxxRkhkeGxaRW9QbDE0TDFXSm9EQVFNYk1hQzc5UG1OTGZ2K294OXJi?=
 =?utf-8?B?MURLR3RRbWpPU0I0RWlpN01PWnV1djFtLytOL2JPL3Z1U2Fjd0NPdnJtT1Jk?=
 =?utf-8?B?TFhyUmQ3OUU4MFNGdFhmb1Y2bHh3LzdScDlIM29DL2Y5TVEvejhPU1FjazMv?=
 =?utf-8?B?OGN2WXdSR2JZNFpEendTN1E4aUgxNVBDTUl5VXlpY3JEQm5CZEZhM0o1RVRK?=
 =?utf-8?B?WWhQK2JXN25EcHIwQUlqQmxoNnUweXdOZTdLTUpyMlBNYjNnRVFxNnMxN3Y3?=
 =?utf-8?B?Smo3cEttZi9kKzlEbUx2WXNMV2xKWUJPUXNrYUR6L0g4eTRLVDhaVWdkNUxk?=
 =?utf-8?B?RlkxMkVvcFRTQjhKaHpSdzFid2ZVSUFZTGFJYjZEWnZRSzA0d1drSkpjVkh2?=
 =?utf-8?B?SUhabjFKRXV2Rk1NY0krZkgvT09uZHdxbldGNFBJRjZSNTJPQTAybUVIdEFl?=
 =?utf-8?B?Si9wZFBLbWowbEhhU2lGdUxma2MyN081K3MwVzJabG9jaVB4RFJSUnB4cHNa?=
 =?utf-8?B?QUIybGR2WTI1RjRSZksxOVo4NU9PbG1vbGlRYmVzeVNqbldJaEVkUEEvZ3FD?=
 =?utf-8?B?Yy84T2YwMG5xSDl0THBOZG0xZXZjMzh3Rk1KeUxCQ1BGSldjNEZHSFBzU2lh?=
 =?utf-8?B?dFJYSUhwbmdOdlRXR29XR0xKeGlHNDRUb1Y4V05hNGJVV25zNmtVa3FCbUly?=
 =?utf-8?B?dVdJQ1hacjRsdHQzWHU2aVZrZTZVZXZnZG52Q1dFbHI1alg4bThBWkdTc0l5?=
 =?utf-8?B?ZFM1aE9HUWJrc1YyZ0xJbi9xWVNsalUwZUhGTlEwQmJ0cHZkSkorUGtud3JQ?=
 =?utf-8?B?VFY1YVlDVm9VRDlFdFUvRzk5RzZieGxaN1ltODRxOWNsSVdPdWlQald0NFhJ?=
 =?utf-8?B?TEt5NVJTMlJDNWt1U3pma3hDdkdMTGlacnVnYzdXenZCNTh6Q0NYSFVaVVFp?=
 =?utf-8?B?Ky9XMWJFZmJGRVFpeWV2eE5TRkU3cjZOZERHd3orZHpzbVJJd0VLQk9QaDNJ?=
 =?utf-8?B?dVNZcEJqOXpwU2g4TStTU1NreERjSEZ3Z1hIZFc1RzNJN21CTy9XQXhqWmRW?=
 =?utf-8?B?SmQ0ek1YUUhkYi9kY2FNa2V6Q0h5eHhnRlpuOGJjSGFmb0d2TFJjUExML1Zh?=
 =?utf-8?B?SmUzcm42Q09vbEZWbEFnVkxyUWNSUWpHKzVDeWNWTGpGcStPdXlkWnJSeW9w?=
 =?utf-8?B?aGhTV0FIYTJZUzQ1ekRYTkhOc21XWkpVQXhpTzFBeE00V1BEQ056RThLMC83?=
 =?utf-8?B?NVhhWkF4VGhlOWdiWGdPZnFCZHBJMjNUQ3o1Ynh3WmJIRHJMYjN1dm8zQURp?=
 =?utf-8?B?aWlReWpZRW9YRGpCNVhWOEhwNTQ1dWlCWFo0QW9NYkc1MnE1L1FDL2V2QW1V?=
 =?utf-8?B?c2hKRFVKQ1BuUmdJSnR1RHVoT2FUeU96TXlUbE1BaW1iSVFlVnhXeXdmNS9p?=
 =?utf-8?B?eE5JbTNPbTJYTFh2enVLak1XWEpDcGxaMzJZNTFrRlA3V1dSVWQ0Z1ZXMGUz?=
 =?utf-8?B?RnF1SG13WFYxYkRrd3d1eVdsWVUyMmY0RkN6NUZKWEFUeVNBYWFNVjFLd1o5?=
 =?utf-8?B?dlpVU0VVY1h3c1k5cGNNcUN0MTB5RUVFSDgveGRUbG1wK2lMWUNFT0dwM3o1?=
 =?utf-8?B?Qlh1cHNSQzgxZThSNlQ0Z0ZmNzdXUTVna1hsaVVnR2YwaENuVGczckVIK21k?=
 =?utf-8?B?NEZUVU05Q3doRlNrais3Q0lNM3p2N1BtQVY4WmpxbGZhS0dPVGQ0TGIyeHZ1?=
 =?utf-8?B?Zzl3SW42cEFhdUxoRExDWnZLd3o1bkk4SjhjR0VXdE5Ub3hTd1hTeU91Rkow?=
 =?utf-8?B?RWJvSHhRaEFPemFyOGQraGg1bzNMZ3hVWmlJbUthdm5mQmxSejhwb0V4R2VT?=
 =?utf-8?B?am1ETTRKZElYTmg1dzdnZ21FR2hJbUhtcTBJLy9xb1RCSytaNFhYSmpSbllr?=
 =?utf-8?B?RkJwNXN3TGVaQ1NHSHVNbTM5YzNTUURWaXRPaVlrZFlKbGpobGZ6NzNPSUJQ?=
 =?utf-8?B?TUdaanlZakZGL0MrejB3bmZaTFhuVWRzdzljUGRGZHhCcEpxTXNpdFNQVkxM?=
 =?utf-8?Q?rOLM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd3f12f-d086-4565-fd22-08ddaf30bcf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 12:56:41.9808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UDLSqfFwcF25QBKGb8bUBSqdeZ2jjdxNfC6+1Whyn8GusKqiCOH7N7quy6WM+nHO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+
IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMTcsIDIwMjUgMTE6MzggUE0NCj4gVG86IExpYW5nLCBQcmlr
ZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBL
b2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyIDA2LzExXSBkcm0vYW1kZ3B1OiB0cmFjayB0aGUgdXNlcnEgYm8gdmEgZm9y
IGl0cyBvYmoNCj4gbWFuYWdlbWVudA0KPg0KPiBPbiBUdWUsIEp1biAxNywgMjAyNSBhdCA0OjEy
4oCvQU0gUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
VGhlIHVzZXIgcXVldWUgb2JqZWN0IGRlc3Ryb3kgcmVxdWlyZXMgZW5zdXJpbmcgaXRzIFZBIGhh
cyBiZWVuDQo+ID4gdW5tYXBwZWQgcHJpb3IgdG8gdGhlIHF1ZXVlIGJlaW5nIGRlc3Ryb3llZC4N
Cj4gPiBPdGhlcndpc2UsIHRoZSBrZXJuZWwgZHJpdmVyIHNob3VsZCByZXBvcnQgYW4gaW52YWxp
ZGF0ZWQgZXJyb3IgdG8gdGhlDQo+ID4gdXNlciBJT0NMVCByZXF1ZXN0Lg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jIHwgMTcgKysrKysr
KysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEu
Yw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiBp
bmRleCAyODgyZWY4ZmU3MTkuLjJhN2VjN2RhZjNkYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gQEAgLTQ1OSwxMiArNDU5LDI0IEBA
IGFtZGdwdV91c2VycV9kZXN0cm95KHN0cnVjdCBkcm1fZmlsZSAqZmlscCwgaW50DQo+IHF1ZXVl
X2lkKQ0KPiA+ICAgICAgICAgICAgICAgICBhbWRncHVfYm9fdW5waW4ocXVldWUtPmRiX29iai5v
YmopOw0KPiA+ICAgICAgICAgICAgICAgICBhbWRncHVfYm9fdW5yZXNlcnZlKHF1ZXVlLT5kYl9v
Ymoub2JqKTsNCj4gPiAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAg
ICAgICogQXQgdGhpcyBwb2ludCB0aGUgdXNlcnEgb2JqIHZhIHNob3VsZCBiZSB1bm1hcHBlZCwN
Cj4gPiArICAgICAgICAqIG90aGVyd2lzZSB3aWxsIHJldHVybiBlcnJvciB0byB1c2VyLg0KPiA+
ICsgICAgICAgICovDQo+DQo+IEkgdGhpbmsgaWRlYWxseSB0aGUgcXVldWUgd291bGQgcmVtYWlu
IG1hcHBlZCB1bnRpbCBhZnRlciBpdCdzIGRlc3Ryb3llZC4gIEkuZS4sIG9uIHRoZQ0KPiB1c2Vy
c3BhY2Ugc2lkZToNCj4NCj4gZGVzdHJveSBxdWV1ZQ0KPiB1bm1hcCBWQXMNCj4gZnJlZSBCT3MN
CkkgY2hlY2tlZCBhbmQgdHJhY2VkIHRoZSBhbWRncHVfdm1fYm9fdW5tYXAoKSBhbmQgYW1kZ3B1
X3VzZXJxX2Rlc3Ryb3koKSBjYWxsIHNlcXVlbmNlLCBhbmQgdGhhdCBzaG93cyB0aGUgdXNlcnEg
VkEgc2VlbXMgYWx3YXlzIHVubWFwcGVkIGJlZm9yZSBkZXN0cm95aW5nIHRoZSB1c2VycS4NClNv
IG5vdyB0aGUgZnJlZSBzZXF1ZW5jZSBsaWtlIGFzIGZvbGxvd2luZzoNCnVubWFwIFZBcw0KZGVz
dHJveSBxdWV1ZQ0KZnJlZSBCT3MNCg0KPiBBbGV4DQo+DQo+ID4gKyAgICAgICBpZiAoYW1kZ3B1
X3VzZXJxX2J1ZmZlcl92YXNfbWFwcGVkKCZmcHJpdi0+dm0sIHF1ZXVlKSkgew0KPiA+ICsgICAg
ICAgICAgICAgICBkcm1fd2FybihhZGV2X3RvX2RybSh1cV9tZ3ItPmFkZXYpLCAidGhlIHVzZXJx
IG9iaiB2YSBzaG91bGRuJ3QgYmUNCj4gbWFwcGVkIGR1cmluZyBkZXN0cm95aW5nIHVzZXJxXG4i
KTsNCj4gPiArICAgICAgICAgICAgICAgcj0gIC1FSU5WQUw7DQo+ID4gKyAgICAgICB9DQo+ID4g
Kw0KPiA+ICAgICAgICAgciA9IGFtZGdwdV91c2VycV91bm1hcF9oZWxwZXIodXFfbWdyLCBxdWV1
ZSk7DQo+ID4gICAgICAgICAvKlRPRE86IEl0IHJlcXVpcmVzIGEgcmVzZXQgZm9yIHVubWFwIGVy
cm9yKi8NCj4gPiAgICAgICAgIGlmIChyICE9IEFNREdQVV9VU0VSUV9TVEFURV9VTk1BUFBFRCkg
ew0KPiA+ICAgICAgICAgICAgICAgICBkcm1fd2FybihhZGV2X3RvX2RybSh1cV9tZ3ItPmFkZXYp
LCAidHJ5aW5nIHRvIGRlc3Ryb3kgYSBIVw0KPiBtYXBwaW5nIHVzZXJxXG4iKTsNCj4gPiAgICAg
ICAgICAgICAgICAgciA9IC1FVElNRURPVVQ7DQo+ID4gICAgICAgICB9DQo+ID4gKw0KPiA+ICsg
ICAgICAgYW1kZ3B1X3VzZXJxX2J1ZmZlcl92YXNfcHV0KCZmcHJpdi0+dm0sIHF1ZXVlKTsNCj4g
PiAgICAgICAgIGFtZGdwdV91c2VycV9jbGVhbnVwKHVxX21nciwgcXVldWUsIHF1ZXVlX2lkKTsN
Cj4gPiAgICAgICAgIG11dGV4X3VubG9jaygmdXFfbWdyLT51c2VycV9tdXRleCk7DQo+ID4NCj4g
PiBAQCAtNTg1LDYgKzU5NywxMSBAQCBhbWRncHVfdXNlcnFfY3JlYXRlKHN0cnVjdCBkcm1fZmls
ZSAqZmlscCwgdW5pb24NCj4gZHJtX2FtZGdwdV91c2VycSAqYXJncykNCj4gPiAgICAgICAgICAg
ICAgICAgZ290byB1bmxvY2s7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiArICAgICAgIC8qIHJl
ZmVyIHRvIHRoZSB1c2VycSBvYmplY3RzIHZtIGJvKi8NCj4gPiArICAgICAgIGFtZGdwdV91c2Vy
cV9idWZmZXJfdmFfZ2V0KHF1ZXVlLT52bSwgYXJncy0+aW4ucXVldWVfdmEpOw0KPiA+ICsgICAg
ICAgYW1kZ3B1X3VzZXJxX2J1ZmZlcl92YV9nZXQocXVldWUtPnZtLCBhcmdzLT5pbi5ycHRyX3Zh
KTsNCj4gPiArICAgICAgIGFtZGdwdV91c2VycV9idWZmZXJfdmFfZ2V0KHF1ZXVlLT52bSwgYXJn
cy0+aW4ud3B0cl92YSk7DQo+ID4gKw0KPiA+ICAgICAgICAgcWlkID0gaWRyX2FsbG9jKCZ1cV9t
Z3ItPnVzZXJxX2lkciwgcXVldWUsIDEsDQo+IEFNREdQVV9NQVhfVVNFUlFfQ09VTlQsIEdGUF9L
RVJORUwpOw0KPiA+ICAgICAgICAgaWYgKHFpZCA8IDApIHsNCj4gPiAgICAgICAgICAgICAgICAg
ZHJtX2ZpbGVfZXJyKHVxX21nci0+ZmlsZSwgIkZhaWxlZCB0byBhbGxvY2F0ZSBhIHF1ZXVlDQo+
ID4gaWRcbiIpOw0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCg==
