Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3810EE77188
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 02:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC9AA10E37A;
	Mon, 13 Jan 2025 02:02:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RrHEnFAw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50BDA10E37A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 02:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZi/thIGwRSA1A/wkwnn6oyua82G81DxX2Um6ScmTsnvXz4t7XitYeD8IokWlJGtIB/KGZSlNoQQvuIAfG4dFGX68plpuWzziOn6k23fxacGhW/q/GIcrSj3H/r/vOAAtHaeFAn0Q8XGRlF0vRroyYx3FyuY3/KrD8xdDRn5Ru7q2EBXwWuQOf+MtQg+W3CL3Kdh8sZkPpNbQtpxLUK90qWMSZvZAWlU9N0LAp2kb9Jyst6JxozVhtw4w+VrRPBQlM0fCY2/q6m0FUQIwv0JIXI5UheZzaRt/qsgOBGwD72PPawuKPNEzBwgfODRGemotvXXrIeb49cgjOa9zWNgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rb3XfWdq9WFL24Wwxqb+sBjFJ7CNWIGuYKLhAlO6Lj4=;
 b=nc3Cpm74KeRWvBgrP1/2VGMDdGgKbBtHq0TyTa58trJmiHnvxHCZmwt1N6Ypm7os0HrwiZYziw0Lz/GDri+hOTEVjepXxMW5WKKj2+mB1Gc+IwXXMXRVzqe8wSZcwt7ca00NY6WKAHnkGwS3QzxKduHOq8zgBkQd8Zu9L9qoWvau60VThcP0ZIwLuRXBl+i17E6DmHAZP9YzLRY+7iSWPT9eg4atne7TOn5e6V8dTEWiMfhX1xtej+TG1HB2f3aWl5O6BCo3p2og0L4af4jJiyd3A/NEY6/FXcGQHK19ybCVHJQ3bfeqk/TXeaaxHG+pkzjWa14/xd7kIwbErUEqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb3XfWdq9WFL24Wwxqb+sBjFJ7CNWIGuYKLhAlO6Lj4=;
 b=RrHEnFAwXHke7rB8o99ZR6yOgkPbtDjnF1AeTQrSAnDeTcyX3sjc7rkxcmhfu8TqMP1YqeOo2qRMS1nvOzWJHrBJbCvyGdKL2sEPNIDCWDup0mXBNpKn698VYIEcFcXFfYlpT2e1yp9p1tqxj8EQMz0vz22Dl1t/JUpWUPHuBGc=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 02:02:11 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 02:02:10 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4] drm/amdkfd: Fix partial migrate issue
Thread-Topic: [PATCH v4] drm/amdkfd: Fix partial migrate issue
Thread-Index: AQHbYzQvHzJCYoWgCUmrchJBZU3Wi7MQE/QAgAAdrgCAABNpAIAACxeAgAOltYA=
Date: Mon, 13 Jan 2025 02:02:10 +0000
Message-ID: <PH0PR12MB5417BAEE9D2DBAE64C1C483A8F1F2@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250110074924.1441364-1-Emily.Deng@amd.com>
 <28f8397b-0f2a-4738-22e6-734abc21f0a9@amd.com>
 <7fba9b16-4bb7-44c2-bc7e-d455024ce2b7@amd.com>
 <bd1da61b-0f84-eba0-4a4c-9124429c4eac@amd.com>
 <3f1b9c39-ed9c-42cb-bc8f-fbddb9275a46@amd.com>
In-Reply-To: <3f1b9c39-ed9c-42cb-bc8f-fbddb9275a46@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3a38a521-c81c-4798-aa55-aa4ff957a81b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-13T01:54:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|CH3PR12MB8483:EE_
x-ms-office365-filtering-correlation-id: 53afb3c5-7b06-4bec-d2e4-08dd33764a7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cU41VTgzQ2dXL0hmN2NzS1QzcWoxUkZ0dmpHWFdYMWtOOWtqV3BHdks3T0dZ?=
 =?utf-8?B?VWpvYm5sQ2wrZ3lrbER5ZEt4dEF1blFYN2xoZlg2Y3RhV0lxOVpJUFdOTU1j?=
 =?utf-8?B?VTVzWkc1Q2Q5ZjMwVEdtNzBpYU9XMmx5V2JiMk9lWHVpQWwrcldkVjBrV1Zj?=
 =?utf-8?B?ekZYZExKc3NGSjlQemgxYmt4T3lVWFRFcVVXWnh3QzB5ZStSdldvQThsZVkz?=
 =?utf-8?B?NmQyVXhXQk9hRWNuRDdwWU5wMDR2R2JlcWEwcU5jTTJXc2Q2Wk9INzhKL3pS?=
 =?utf-8?B?Y2JxRXpuTk01enBnN2psN20wYitLcDB0enBPTEwyUlJVbG1HUkorT1c4ditL?=
 =?utf-8?B?N3lWRzdJN21XQ3ZzSStwWVFkOWo5QkxyekZoenNSd3EvS2pzV055dzBOQmU4?=
 =?utf-8?B?bEtnNFRZVG1KRVJQY0l6dExoV3QwQVJ5Q1dTbHplTTZDZTR4OVU5UzB0aFk5?=
 =?utf-8?B?VW1La3FWbDlXLysyYUk1bEhXUEdtcU5UeUNzZzZ5TS9lbW1CRkF0dEZnbkxX?=
 =?utf-8?B?VHBHeGc1dzZrN29wZ0J6NUM2K2VVb0NhVmVXQjVPR29uem11c1VxcXBWNzZp?=
 =?utf-8?B?d0p6K3FNSnh3dUtzLzYycVFyUFplT2NnTEVLeTZoVlkvQlk2L1F4MTMyY3JI?=
 =?utf-8?B?cUw1NjFQd1lEV0M5QXhsMkxia2xrN3hnazhValJjQ3hhWFAwT3lVTzh1YlNh?=
 =?utf-8?B?QmRObVRUdW02VUJhTmlIL05NZFkrRnJPbVl5Tkk5enNqUzF2UnZvNzJqTmc0?=
 =?utf-8?B?UkV4OTlJUW5paUFtejRCMnQwT0pEOXdZY212cXQ5N3hGWGJKbUYzTlp4bGFF?=
 =?utf-8?B?TFB3SjZ4Z24wWkhRbzkyWnplT3VPL0dGazlGZTQwVjRwMy9HOGNRT29IZjVN?=
 =?utf-8?B?SmZlak94TnducHNrMTdtbEtGbDd3aVJ3TmY2dkhnTzhZbUJWbFpEeW1tZ080?=
 =?utf-8?B?VmYrMy9PUGJZZGt5RE9VaWVKczhxTWwzbndPSGtSYUtuZGRWSmpaelpxbjhW?=
 =?utf-8?B?Sm4xQ0o1TjlZcVQ5ajFRdDBEWmpRUFd5OVl2KzViemVQaUY0R1YrdWUzcmlp?=
 =?utf-8?B?cS9ucjdULy9YLy9oZUNtV3pUVnpHeFBHeUNRM0FOWGFFVFpYdi9qcmZBSmpK?=
 =?utf-8?B?TVd6ZjlaVUgrdVJQblVjYzAvazUvWWhVd00vdGNtWHFyODUvRm5iSDNaR1Ri?=
 =?utf-8?B?QlhrdUxsczcreEtQczJjU1h6ZElsNUtLK1gybGdTcnBrMUN0SStPeW96MGE5?=
 =?utf-8?B?cjdqeXlDMERKcEZaYndMdUJtOXI4T2lPNmVGSVVheFd6WkJDOERFNDhyZ2VJ?=
 =?utf-8?B?dTczSUo1aVF3Q0gwdFdGQUJaUVB1MEdGQlhBT1IzQWkxdnNUQmpIeG96a2JT?=
 =?utf-8?B?bmsrejVKanJ0MDQyYVBYMkpWbXB2RFBIVzZrMUV0Z0VnSEJkZ0FTSXhBZTNW?=
 =?utf-8?B?dm1kaHRtdS9lTUdNM2Rma2ExT0crNkhISlRUOHNDaHhZdUUzQmUxSEpIOGpM?=
 =?utf-8?B?dEgwejZLNUVuK3FyVXhMSjVpRkQwbEhWS3ZxYlRIUzBPUCtwVVQrakg1ZjVL?=
 =?utf-8?B?SXVjZkxsY2FjcWRpNTRFQnFWTHJ2MHcvVHZHQU5iY214QVNncTE3RTRHQmNP?=
 =?utf-8?B?ZEN1TVN3Ris3bmFkdmZzSndvQXVubXNJZjg5RmtLa2lQeTVLUnc3bE4zY1Rn?=
 =?utf-8?B?bDJqaEdNVVo4Vm90UEZRbmtnbVdYK2RGWUxaVjArMVVmWi9jUmtxaUhaNlkw?=
 =?utf-8?B?Mys4V0RndENHUGZrTzcydk5YL1VJN0lyWlpSc2V0S21Da2lEODQxKytWWkMx?=
 =?utf-8?B?dEdyV3dKNjMrOGxvaVpDSTRlalV5T0JieXpCQ1pGdGJtUElRR0FhaXlta0xH?=
 =?utf-8?B?OHJtRk5FYm1iZUwyS0RvZXR4SFpXbUVLT1lHaGJPOElGRnNsdVZzbU1HVjNy?=
 =?utf-8?Q?+juh4RyoftRBs6FobAr7cx75C9RAv4sq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjRhQU51bElGdUlxdFpnNjJoOVFTRVp1SGJQMzFlRDZ0TWpRZHdRQUVvVHkz?=
 =?utf-8?B?d0ttQ1ZmU1AxRHJDdDZER2FmYy84cW9Uejg4RDk0Vyt3K0FnYTBKYzFsZXcy?=
 =?utf-8?B?VzU1ZnJ2Ly9USUJjbDE1NmtHS00yMGx0dEFhTXAxVFQ0T0NwUDJYYzZ5Y2Zo?=
 =?utf-8?B?Y25URUVjd2xsY1c2NkVJZzBxczEzMmxhcXF5eHdmOHVjbytpbkhrSGhHRlhj?=
 =?utf-8?B?T1UzT09aTk1Gc2JnK2NzaGxNRFB6cWN6bzZiQ2tFeVRWWEUxTFNtdTYzcHJ3?=
 =?utf-8?B?eUVkOXRQWHNEZUwzcjNzUENXUXJwNTd4Z2hFZzVCSnE3azM3WFl6QlJlZ09i?=
 =?utf-8?B?YVFjVHVlVFN0TzVqZDl3ZG1CNFpqQWVyRlNOZ09GdmdoRi9uY2Q5VGFxWFh5?=
 =?utf-8?B?UUF5bm5FNDh2cnhiTGtXSDJmUHpoZkNvbVhkWjFHazZVSU1zd1U4M1l0Wjll?=
 =?utf-8?B?WXhHVm9RUEptNm84bENHeFJLV3pZaDliOXRDcHlrQlllbFlWZExDd21UZUNX?=
 =?utf-8?B?bFNJS3lHQnkzRWlsZENId0I2L2ZOSjlvVHcwNHc2eGxlYmh4RU1laEFCVzNQ?=
 =?utf-8?B?YzBWa2doY0xyczBDSHE4MU83a0N3V0s2dGRGTXlDSjlrb2k3WTF3QWRRWTdp?=
 =?utf-8?B?SUNIcUlQaktOTHBYTjJLK0JxM3RZYVRPZGRUalljNlZDUVNsSFcvczJJWDRG?=
 =?utf-8?B?dW5LMXNQcmNCZHl4aXRvMExZbkpVYXpxYkRzOEluVHFLNXdwcnpLc2RNejM5?=
 =?utf-8?B?cEtDMWEvditQeWdzN04waVVwZFpjRzI3TGhtVEFZK1E3ZFdqNlBsUFVTTGUw?=
 =?utf-8?B?S3RqWkRiUGJjMGxwK0s3ay8xblh1aEszazVyMjZGeHdiR3pnOW9uRklJNElF?=
 =?utf-8?B?RzNNQWh6cGgreXp0YTZ6V1QwYzY5WmZ1cXRyWUNjY2ViSmRDTzhIdGhPQVNH?=
 =?utf-8?B?YWtyOFZTckFGR2xPN1hiaVUzdkFwYi82RDZPbGlyY0lEVlI2ZjJrb0kySUFU?=
 =?utf-8?B?RUZLTkhCWGxzc0VRNHhsTlhXMEJTS3NwbVNtK2srYWtIZ2daRHRMWWhBMHBJ?=
 =?utf-8?B?TWd4ZW1ObXVCcVVDVXBEK3hja01CSmZkVHA4ejNsUVoyQUc5RER4MG5ENEl5?=
 =?utf-8?B?T0NGeGJ4cEJUWWlrQzBKQis4Q3JjaU4zNDVBcUZHNmZ3ZUFMQ2hFa3RMeTI0?=
 =?utf-8?B?UjJMRkxCVTc0QlhrcUE1cUVXRGxzNGVrdDhpTElrZFprRkU1QkUvSlhsSU9p?=
 =?utf-8?B?L05aUlU4eGZYOEd3bC9lMThxVkJvUTA4bWJSSk03cm1rSWRUb0tudXRNQmhT?=
 =?utf-8?B?Tis2YThsUUpxeVlGRTFYTkdYSXRoK0xKeUc2UExhUkpPeFVLN2RTd3ZMa3h4?=
 =?utf-8?B?TG83RWpnNWRNTmczOEF0YXNWY2RTZGZBNGhTa0tqaW5LREM1OUQvK05VWnJv?=
 =?utf-8?B?MHJKOUtnTXM5b0p5ZmNNQ0VheTJDUmRVeVROL1p1YlhvcFBjTnBqSlY5U21N?=
 =?utf-8?B?cUhhUVQ1Vyt2TG5RaWFmM09ub3FnY09ZOExQM0hHQktnRkVuL3pUcHFDc2NO?=
 =?utf-8?B?KzlrNnJuaUVCRysrTWJSbzBjWXgxUHMxVE9CYXp3YVNxcWtUSWRKV1dxTkFT?=
 =?utf-8?B?N2xSN25WdzJTaDQ2bmp3WDhSR2lJZTVJaU9yNXZhb3hwb1pHSS9nMVVtWXFH?=
 =?utf-8?B?ZXczT3cyWHhEYjRLcW94bC9DMTNoY05FZWJvdjRQclNPU21rU0kxeG94a1Nt?=
 =?utf-8?B?U2pFMElhQ3lwdCtrS1krSXQ5Vi9xdGVZSU90OVZ4bXQzcFdlQXdjK1hqRnNp?=
 =?utf-8?B?Ump3VWx3OGJicmEvZEFXNHdpWHZja2l2TjA1S3duOHVMMG45V2ltNDYvWXVW?=
 =?utf-8?B?NXRFSEtTMzYvWTYrNkYveW0ra3BHa2RJMGFOeEFFaDVWSmZnejQ5bkcvakJ5?=
 =?utf-8?B?QTQzUVpLcCtRTXpnU3VEc2lRb0pQa0tXU3U1L2hLbTVFbDVLSzVhR090ajVo?=
 =?utf-8?B?Y0gvZis2VHU4TlYzUlZVWjFrQVRxZExVN25mbWc3Tnd3blVDWlpWc2ZlN3Y0?=
 =?utf-8?B?MktYeUwxUk5zYnJoTHg3ZkdLL1IzUUJsQ3BEcHVFQ0I3dTRyTmNQd0cxWG40?=
 =?utf-8?Q?JA9M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53afb3c5-7b06-4bec-d2e4-08dd33764a7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 02:02:10.4952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dLVtdcLellG5Iefwqd3eK0TA8MKj/BDNyyi5TSCCWgKQGrItDk1fIhgcXzob8EVX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
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
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ2hlbiwgWGlhb2dhbmcgPFhp
YW9nYW5nLkNoZW5AYW1kLmNvbT4NCj5TZW50OiBTYXR1cmRheSwgSmFudWFyeSAxMSwgMjAyNSAy
OjEzIEFNDQo+VG86IFlhbmcsIFBoaWxpcCA8UGhpbGlwLllhbmdAYW1kLmNvbT47IERlbmcsIEVt
aWx5IDxFbWlseS5EZW5nQGFtZC5jb20+Ow0KPmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NF0gZHJtL2FtZGtmZDogRml4IHBhcnRpYWwgbWlncmF0
ZSBpc3N1ZQ0KPg0KPg0KPk9uIDEvMTAvMjAyNSAxMTozMyBBTSwgUGhpbGlwIFlhbmcgd3JvdGU6
DQo+Pg0KPj4NCj4+IE9uIDIwMjUtMDEtMTAgMTE6MjMsIENoZW4sIFhpYW9nYW5nIHdyb3RlOg0K
Pj4+DQo+Pj4gT24gMS8xMC8yMDI1IDg6MzcgQU0sIFBoaWxpcCBZYW5nIHdyb3RlOg0KPj4+Pg0K
Pj4+Pg0KPj4+PiBPbiAyMDI1LTAxLTEwIDAyOjQ5LCBFbWlseSBEZW5nIHdyb3RlOg0KPj4+Pj4g
Rm9yIHBhcnRpYWwgbWlncmF0ZSBmcm9tIHJhbSB0byB2cmFtLCB0aGUgbWlncmF0ZS0+Y3BhZ2Vz
IGlzIG5vdA0KPj4+Pj4gZXF1YWwgdG8gbWlncmF0ZS0+bnBhZ2VzLCBzaG91bGQgdXNlIG1pZ3Jh
dGUtPm5wYWdlcyB0byBjaGVjayBhbGwNCj4+Pj4+IG5lZWRlZCBtaWdyYXRlIHBhZ2VzIHdoaWNo
IGNvdWxkIGJlIGNvcGllZCBvciBub3QuDQo+Pj4+Pg0KPj4+Pj4gQW5kIG9ubHkgbmVlZCB0byBz
ZXQgdGhvc2UgcGFnZXMgY291bGQgYmUgbWlncmF0ZWQgdG8NCj4+Pj4+IG1pZ3JhdGUtPmRzdFtp
XSwgb3INCj4+Pj4+IHRoZSBtaWdyYXRlX3ZtYV9wYWdlcyB3aWxsIG1pZ3JhdGUgdGhlIHdyb25n
IHBhZ2VzIGJhc2VkIG9uIHRoZQ0KPj4+Pj4gbWlncmF0ZS0+ZHN0W2ldLg0KPj4+Pj4NCj4+Pj4+
IHYyOg0KPj4+Pj4gQWRkIG1wYWdlcyB0byBicmVhayB0aGUgbG9vcCBlYXJsaWVyLg0KPj4+Pj4N
Cj4+Pj4+IHYzOg0KPj4+Pj4gVXNlcyBNSUdSQVRFX1BGTl9NSUdSQVRFIHRvIGlkZW50aWZ5IHdo
ZXRoZXIgcGFnZSBjb3VsZCBiZSBtaWdyYXRlZC4NCj4+Pj4NCj4+Pj4gVGhlIGVycm9yIGhhbmRs
aW5nIG5lZWQgYmVsb3cgY2hhbmdlLCB3aXRoIHRoYXQgZml4ZWQsIHRoaXMgcGF0Y2ggaXMNCj4+
Pj4NCj4+Pj4gUmV2aWV3ZWQtYnk6IFBoaWxpcCBZYW5nPFBoaWxpcC5ZYW5nQGFtZC5jb20+DQo+
Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nPEVtaWx5LkRlbmdAYW1kLmNvbT4N
Cj4+Pj4+IC0tLQ0KPj4+Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0
ZS5jIHwgMTcgKysrKysrKysrKy0tLS0tLS0NCj4+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMNCj4+Pj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYw0KPj4+Pj4gaW5kZXggNGIyNzU5MzdkMDVl
Li5iZmFjY2FiZWIzYTAgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfbWlncmF0ZS5jDQo+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfbWlncmF0ZS5jDQo+Pj4+PiBAQCAtMjc4LDEwICsyNzgsMTEgQEAgc3ZtX21pZ3JhdGVf
Y29weV90b192cmFtKHN0cnVjdCBrZmRfbm9kZQ0KPj4+Pj4gKm5vZGUsIHN0cnVjdCBzdm1fcmFu
Z2UgKnByYW5nZSwNCj4+Pj4+ICAgICAgICAgICAgICAgIHN0cnVjdCBtaWdyYXRlX3ZtYSAqbWln
cmF0ZSwgc3RydWN0IGRtYV9mZW5jZQ0KPj4+Pj4gKiptZmVuY2UsDQo+Pj4+PiAgICAgICAgICAg
ICAgICBkbWFfYWRkcl90ICpzY3JhdGNoLCB1aW50NjRfdCB0dG1fcmVzX29mZnNldCkNCj4+Pj4+
ICAgew0KPj4+Pj4gLSAgICB1aW50NjRfdCBucGFnZXMgPSBtaWdyYXRlLT5jcGFnZXM7DQo+Pj4+
PiArICAgIHVpbnQ2NF90IG5wYWdlcyA9IG1pZ3JhdGUtPm5wYWdlczsNCj4+Pj4+ICAgICAgIHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gbm9kZS0+YWRldjsNCj4+Pj4+ICAgICAgIHN0cnVj
dCBkZXZpY2UgKmRldiA9IGFkZXYtPmRldjsNCj4+Pj4+ICAgICAgIHN0cnVjdCBhbWRncHVfcmVz
X2N1cnNvciBjdXJzb3I7DQo+Pj4+PiArICAgIHVpbnQ2NF90IG1wYWdlcyA9IDA7DQo+Pj4+PiAg
ICAgICBkbWFfYWRkcl90ICpzcmM7DQo+Pj4+PiAgICAgICB1aW50NjRfdCAqZHN0Ow0KPj4+Pj4g
ICAgICAgdWludDY0X3QgaSwgajsNCj4+Pj4+IEBAIC0yOTUsMTQgKzI5NiwxNiBAQCBzdm1fbWln
cmF0ZV9jb3B5X3RvX3ZyYW0oc3RydWN0IGtmZF9ub2RlDQo+Pj4+PiAqbm9kZSwgc3RydWN0IHN2
bV9yYW5nZSAqcHJhbmdlLA0KPj4+Pj4gICAgICAgICBhbWRncHVfcmVzX2ZpcnN0KHByYW5nZS0+
dHRtX3JlcywgdHRtX3Jlc19vZmZzZXQsDQo+Pj4+PiAgICAgICAgICAgICAgICBucGFnZXMgPDwg
UEFHRV9TSElGVCwgJmN1cnNvcik7DQo+Pj4+PiAtICAgIGZvciAoaSA9IGogPSAwOyBpIDwgbnBh
Z2VzOyBpKyspIHsNCj4+Pj4+ICsgICAgZm9yIChpID0gaiA9IDA7IChpIDwgbnBhZ2VzKSAmJiAo
bXBhZ2VzIDwgbWlncmF0ZS0+Y3BhZ2VzKTsNCj4+Pj4+IGkrKykgew0KPj4+Pj4gICAgICAgICAg
IHN0cnVjdCBwYWdlICpzcGFnZTsNCj4+Pj4+ICAgLSAgICAgICAgZHN0W2ldID0gY3Vyc29yLnN0
YXJ0ICsgKGogPDwgUEFHRV9TSElGVCk7DQo+Pj4+PiAtICAgICAgICBtaWdyYXRlLT5kc3RbaV0g
PSBzdm1fbWlncmF0ZV9hZGRyX3RvX3BmbihhZGV2LCBkc3RbaV0pOw0KPj4+Pj4gLSAgICAgICAg
c3ZtX21pZ3JhdGVfZ2V0X3ZyYW1fcGFnZShwcmFuZ2UsIG1pZ3JhdGUtPmRzdFtpXSk7DQo+Pj4+
PiAtICAgICAgICBtaWdyYXRlLT5kc3RbaV0gPSBtaWdyYXRlX3BmbihtaWdyYXRlLT5kc3RbaV0p
Ow0KPj4+Pj4gLQ0KPj4+Pj4gKyAgICAgICAgaWYgKG1pZ3JhdGUtPnNyY1tpXSAmIE1JR1JBVEVf
UEZOX01JR1JBVEUpIHsNCj4+Pj4+ICsgICAgICAgICAgICBkc3RbaV0gPSBjdXJzb3Iuc3RhcnQg
KyAoaiA8PCBQQUdFX1NISUZUKTsNCj4+Pj4+ICsgICAgICAgICAgICBtaWdyYXRlLT5kc3RbaV0g
PSBzdm1fbWlncmF0ZV9hZGRyX3RvX3BmbihhZGV2LA0KPj4+Pj4gK2RzdFtpXSk7DQo+Pj4+PiAr
ICAgICAgICAgICAgc3ZtX21pZ3JhdGVfZ2V0X3ZyYW1fcGFnZShwcmFuZ2UsIG1pZ3JhdGUtPmRz
dFtpXSk7DQo+Pj4+PiArICAgICAgICAgICAgbWlncmF0ZS0+ZHN0W2ldID0gbWlncmF0ZV9wZm4o
bWlncmF0ZS0+ZHN0W2ldKTsNCj4+Pj4+ICsgICAgICAgICAgICBtcGFnZXMrKzsNCj4+Pj4+ICsg
ICAgICAgIH0NCj4+Pj4+ICAgICAgICAgICBzcGFnZSA9IG1pZ3JhdGVfcGZuX3RvX3BhZ2UobWln
cmF0ZS0+c3JjW2ldKTsNCj4+Pj4+ICAgICAgICAgICBpZiAoc3BhZ2UgJiYgIWlzX3pvbmVfZGV2
aWNlX3BhZ2Uoc3BhZ2UpKSB7DQo+Pj4+PiAgICAgICAgICAgICAgIHNyY1tpXSA9IGRtYV9tYXBf
cGFnZShkZXYsIHNwYWdlLCAwLCBQQUdFX1NJWkUsDQo+Pj4+ICBvdXRfZnJlZV92cmFtX3BhZ2Vz
Og0KPj4+PiAgICAgICAgIGlmIChyKSB7DQo+Pj4+ICAgICAgICAgICAgICAgICBwcl9kZWJ1Zygi
ZmFpbGVkICVkIHRvIGNvcHkgbWVtb3J5IHRvIHZyYW1cbiIsIHIpOw0KPj4+PiAtICAgICAgICAg
ICAgICAgd2hpbGUgKGktLSkgew0KPj4+PiArDQo+Pj4+ICsgICAgICAgICAgICAgICBmb3IgKGkg
PSAwOyBpIDwgbnBhZ2VzICYmIG1wYWdlczsgaSsrKSB7DQo+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGlmICghZHN0W2ldKQ0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbnRpbnVlOw0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICBzdm1fbWlncmF0ZV9wdXRf
dnJhbV9wYWdlKGFkZXYsIGRzdFtpXSk7DQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgIG1p
Z3JhdGUtPmRzdFtpXSA9IDA7DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIG1wYWdlcy0t
Ow0KPj4+PiAgICAgICAgICAgICAgICAgfQ0KPj4+PiAgICAgICAgIH0NCj4+Pg0KPj4+IFRoaXMg
ZXJyb3IgaGFuZGluZyBub3QgbmVlZCByZWNvdmVyIGFsbCB2cmFtIHBhZ2VzIGFzIGVycm9yIGhh
cHBlbmVkDQo+Pj4gYXQgbWlkZGxlLiBDYW4gdXNlIHNlIGRvIHsuLi4ufSB3aGlsZShpLS0pOw0K
Pj4gbm8sIGZvciBleGFtcGxlIG1pZ3JhdGUgbnBhZ2U9Y3BhZ2U9NCwgYW5kIG91dHNpZGUgZm9y
IGxvb3AsDQo+PiBzdm1fbWlncmF0ZV9jb3B5X21lbW9yeV9nYXJ0IGZhaWxlZCwgZHN0WzRdIGlz
IG91dCBvZiByYW5nZSBhY2Nlc3MuDQo+DQo+WW91IGFyZSByaWdodCwgYnV0IGl0IGlzIGF3a3dh
cmQuIEluc2lkZSBsb29wIHdlIHVwZGF0ZSBkc3RbaV0gYmVmb3JlIGRvIHNkYW0gdGhhdCBkb2Vz
DQo+bm90IGluY2x1ZGUgdGhlIGRzdFtpXSBqdXN0IHVwZGF0ZWQuDQpBcyB0aGUgZHN0W2ldIGlz
IGFscmVhZHkgaW5pdGlhbGl6ZWQgdG8gTlVMTCwgc28gSSB0aGluayBpdCBkb2Vzbid0IG1hdHRl
ciBpZiB1c2UgZm9sbG93Og0KICAgICAgICAgICAgICAgIHdoaWxlIChpLS0pIHsNCiAgICAgICAg
ICAgICAgICAgICAgICAgIGlmIChkc3RbaV0pDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN2bV9taWdyYXRlX3B1dF92cmFtX3BhZ2UoYWRldiwgZHN0W2ldKTsNCiAgICAgICAgICAg
ICAgICAgICAgICAgIG1pZ3JhdGUtPmRzdFtpXSA9IDA7DQogICAgICAgICAgICAgICAgfQ0KDQpF
bWlseSBEZW5nDQpCZXN0IFdpc2hlcw0KDQoNCj4NCj5SZWdhcmQNCj4NCj5YaWFvZ2FuZw0KPg0K
Pj4+DQo+Pj4gUmVnYXJkcw0KPj4+DQo+Pj4gWGlhb2dhbmcNCj4+Pg0K
