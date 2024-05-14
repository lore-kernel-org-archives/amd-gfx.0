Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E50C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 02:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03DC510E0AC;
	Tue, 14 May 2024 02:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PKQGjlfJ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A65E10E0AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 02:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2f08G+GZS19huH/opqBcb9M6WNF/kII5/xRbL4xqO6THrK6boYUZBh7BEhoPOiYTAbQocUSVpwmbhtt8Rmznz1fy9LYCSrkFo9krwp6sn4rwPICWn1j7XtnMyCDp7J9BiALD+Z+vvhKjBqCTgWeWhp2G9HehhSpBlpdxtSrFhJk+KwrAgIJLeDkpCB2v3UFyd7AgtPhoHvtvy6aqqzNw1lvEdqyWKtN1Oc99eMtpg97XG4bibGEJVxhaIvPEfo89Jdofj1hogFYBdZbF+1TuYdO0Uqujk7IKHOhOcX5flypw8Vy8ZTXq8JTi2h+t/XF6yUwujQ8rNJ8NOeRiZR6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MqiwBfedZ9W8qG94KgzQu6hYEtTBvkdPsaC+mrJVYg=;
 b=oGUaDvkILgosCBbUTLdnW9IYkVqTBJCIp8KjLRJJ3C1EbyQ0pfcJYCItlRbFrQupyD8QSGRX6b7Upiq6pZMr/GvVriPprm6HNzNTosMM4FCbM4Sk5elSL173gqJcPCSdK79ZzjyS0rcC2wdAj2pV2C1PVgVl6qloVjpcLO0M2GCpY1VS9uF818LH97QptQLWQLHj8GQ6r0TudUWxP+NmYxaq4FdN2UHdmqblG7nVfgDQx1h0SWAeivrJaFJNgtLqlMYyuoUVczOyA0YhyOrisw7Z7Ww6n3bYCHR9AlIdFZDf/Q0bM9/SuoMVDJ+ZrqQfcE3vNCz7+YveAesMwnRBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MqiwBfedZ9W8qG94KgzQu6hYEtTBvkdPsaC+mrJVYg=;
 b=PKQGjlfJxBFn1pjzd05Zf0CJen1DTJT34b+3DVuzmT9sqwO+xPAjkeZE9Zj5odnpMXeK1K296upimLfrgU2wrzp8sxM8lr68PCArt70NaWbtdF7Lm1wRrrfT6jAv/Jv6mgg09Bs7N4f8XnI9eYYjVO0L2R5D4ZrElBDi6Dm//QI=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH7PR12MB6492.namprd12.prod.outlook.com (2603:10b6:510:1f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 02:39:30 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 02:39:30 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 01/22] drm/amdgpu: fix dereference after null check
Thread-Topic: [PATCH 01/22] drm/amdgpu: fix dereference after null check
Thread-Index: AQHaooTtp8OCPcUqwU+sghNeEuY0a7GVD9aAgAD24KA=
Date: Tue, 14 May 2024 02:39:30 +0000
Message-ID: <DM4PR12MB51528E29DDF26DB21C602DD7E3E32@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <1a0b28c7-0b01-4e8e-ae8b-8eb297da1e05@gmail.com>
In-Reply-To: <1a0b28c7-0b01-4e8e-ae8b-8eb297da1e05@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e852caeb-41f4-4207-a6c6-1f06744c908d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T02:24:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH7PR12MB6492:EE_
x-ms-office365-filtering-correlation-id: 7a570783-fdc5-41e2-b477-08dc73bf1496
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NDZRRjE3OTFJOTM5SVJ1bWtTd2owYmlnZFNCZ0htM2JYMkp0N1VOa2VacU13?=
 =?utf-8?B?V2xuVHI3a0hHR3BYcFhMdXZoMExadUE4RXRYVXIyL2RZN2I4RHlZWTgzMU1C?=
 =?utf-8?B?NWoyRGFrblF5c3AvR3NpU1FGZlo5SlRhRWZ0QjQ3dk5OaVpxWVJGeS8yeHVj?=
 =?utf-8?B?aEpzS3Y4b0xvb1U2L2ZsS1RMc295am5WdHdpRFlRdFYrdFg5Vjh2T2VLUG5p?=
 =?utf-8?B?YWQwT0ZVdEFYaUJzSVpXL2NvSnVYbkVUWmpzMVVUSmtzQTA1MHQ1b1AveVBz?=
 =?utf-8?B?cEUxRkdxdjJ2dGV6SjBTWFRBZXVBWDdPam85anJBNXJpMlpMV3RhdTdhcUxZ?=
 =?utf-8?B?NmpCQUpRazJLZCtrYTdQR1R3UWs0UU9DbGVPSDFVOE9FQkRQSmNzQXJSYkho?=
 =?utf-8?B?SFk0WGYyMjBOZW9BT0NJNGVsSCtqRUZLeU9jcjJTQ1NtcjBPekFKZmpyWUVG?=
 =?utf-8?B?S1p2TVRUSWxlVmdJYjJtQ2VWUkI1Wk5Lc0Ryc2kxb3luS0J2Y2hISVZHbm45?=
 =?utf-8?B?bS9vZUJPemhOUUFBNDBML2dXR0FxSnhGWXp1azRkdEV3ZG5naFJOMW80NjlN?=
 =?utf-8?B?b2xqSmMwc2lUN1F4SjF1cTRYalRpaThHRnJnSFNtTm9XcDY2VlkveUF6UVJ4?=
 =?utf-8?B?SmpIK2dwRDBkR2lZbjB5SXBSRnZ4RXVKdDloNGhPUVA5QUxtOGxnTThoRlMw?=
 =?utf-8?B?cnVlU3dQcUYydHhMc2FqWlJXclBCaFhiT3p0YXE2MkJUSVdiNEVkNllUTUVy?=
 =?utf-8?B?MkRWZ0tHY0VXeGo0TkVTM1Mrb1F6cUxaTlZwczkybEs0ZmZwY3Bhb1kxK0ZJ?=
 =?utf-8?B?bWkyVit2dFhKQVhOTGk4c1h6aW1mUGR2VHo1ajQ3QllKSDdvVEw1bmdjVXYx?=
 =?utf-8?B?STdxaG1yZ1JuZnVQN2g1aFdvVUVXdHVJTlZ3R3hQL2Q2SHgvYnZGd09lMDN1?=
 =?utf-8?B?M1lHK3dnWUxKdFI3ZmVxUG5mV3JSQnR1clRoY0g3MEt2c2laUnBhWHhsNDEx?=
 =?utf-8?B?UUJsTjNGT1J2bGovSGtEY3U2eklmUno1cllSdGFlYXJJWWJhVXhzVmc0V2kx?=
 =?utf-8?B?ZmZVcUxhM2JnMGsrWFk0MzZGNXZKMURTRnoyWSt3bGJPMTAwaWN6TzFmR2ZQ?=
 =?utf-8?B?QldKY2hnNERQSlpFdXpiQ1M4YVJGKy9LNjRyTzJtRndRRkxYZk00eGp6NTRK?=
 =?utf-8?B?OHh3UFh4QmFmYUNJVDc3dk4wdWRaTUQ1c1hHTncwckNXc0NHR3pyS0VLZjFK?=
 =?utf-8?B?MFRkOGdUb2hnL0pLa3JVUmsySVZWVk01bXp6akdidGJQU3JxNUVDWVlRSndw?=
 =?utf-8?B?MmRZU0YzQzViY2NJdEJkdHlkaWNKS2pSZlVNNU9vSkIrZ0xrbndWTDFWcDVq?=
 =?utf-8?B?clNkWDhiVG9ZV3E0VFNnWXpraHZHRC91dTJpd0hpMm1rVEd1a1g4TUlsOHVr?=
 =?utf-8?B?NjIyN0NvK2R2NHBFL3N3eDVvK00vT1Ntb1dpcEJ1M0s4TDkxS1ZCZEhJUnBX?=
 =?utf-8?B?YUliM3lhTE5aeFE0WitVNkhmMVlBNUc4TGRaMlByRVlBZVA1Nks5eFZnbFNK?=
 =?utf-8?B?WFBZZlJBN05BRlBUVXhsdmlod0M0RXlaSFQ1d1RFNjRzcERLdVg3WG9lWTR6?=
 =?utf-8?B?WU4zSTl5aWZ6MTZDdGNpZXhoN2gyOUl3RENDVTBhcTNSNC9MVWE0akVHbGp4?=
 =?utf-8?B?dFM0WTltTUJDb0JES05talA1UDFRSm1uVk9ZdUNMQ1Zwc0wveFV2R21uS29u?=
 =?utf-8?B?OVlWOFZNYlBlYVBmaVY1L0VFU2tzT21icmFxUzRFMEhkNm9GUjZRUVdZeFNh?=
 =?utf-8?B?Sy8wK1RrbjQ1enJpek1VZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnNYdnFmMHdWUGU4aUNwU0V5anpxRkdWVXlqT3lRZHlFYnNMUzhzMGVBOFQ2?=
 =?utf-8?B?c2dETFFORVkvT1E4a3JOWktNbXlxN2xjWVNHQ21PRE9qZEU4eG8ydmEyd1p0?=
 =?utf-8?B?S3ZqeThWaGlSQ21VTnU3RlRzcWFKSFBpRFpwRjVqM3hQMjl1RkgrZUNjYlBC?=
 =?utf-8?B?U1pmN1BuVndRV3lVa0VxVG9nMng0M2w5eEEwdHNlWThBS0pkYWJRK0FlUTNT?=
 =?utf-8?B?RE1HUEpRRDF4Sm1oTFJIK2c2bmZCNlBZVXA1Qlo3Y2JiV2I2eGtyYzZSWmxn?=
 =?utf-8?B?V1J3YVd2RDFyL2pMWXFOelpraTRhTThYa1Q5YUtsa1gzY3g3eHEvWVJ3NlVK?=
 =?utf-8?B?azM1dCtMKy9udk5hWlZ4aU9lOGlNaDZxV2IvVDRNMnFiZmxOWk9Yb2h0OVlt?=
 =?utf-8?B?clF4L0dCanJLa2hOTkwrWWE2dFYzOWJ1Nlh2czVPV0FBc1MwamFNdlU3d3Yr?=
 =?utf-8?B?enRWdS9yeDNNSGhUOTZqdGtTcTBkYW1pdTlUaWxmRU0xeFJRSXh5Tkx0NG9p?=
 =?utf-8?B?ZU5leXUzN054UDJsT0QzR0R6by94c0V4K2ZuaGJ1em04TzdsVGF1TUp2QjM4?=
 =?utf-8?B?M05WVG5QeXd2VUxncEhyUGJ1bExLd2d6Y2RwVVlWMGNibjhkQ2x5ZGV5bEFk?=
 =?utf-8?B?ay93OFVCT3lJU3AxQ2h1MWk4N1BVTGRVYzFWOTc4dVBoalpCUlNSSEhCblo5?=
 =?utf-8?B?RVJKNnBrdXJGUVJmT0tFU21IVms4enNWWG54dnVOdE9yNnhsRG5sYTB2RTZj?=
 =?utf-8?B?d2VrNUpyVk9iMy81MWFjNERaY3AzMHNDYkJyd0tPSWc2TFVrWmptYnhCYnJp?=
 =?utf-8?B?WmVjQ2RXVWtabHdzc3BOdFRBeG5oNHZCdGZHRTVheDlwK3owVDYvb1VoWEhL?=
 =?utf-8?B?V1p5dWhxNnFYNEdDTTRjYUY4bXJIVmRiNFRIYzZ6Ukk2OHdKeENScDRMR21P?=
 =?utf-8?B?YlYvZEpBZFhCQ1RrUmJmL1M3RkdMcGtXZmJRenBGbnkxekZ4Qy9VNVlDekdv?=
 =?utf-8?B?NVQ5Vzh3aDhVczYzNFlHOTk2UDlQWG1qek5sTnA5cjdOdXhaNUxnUTJ0elpP?=
 =?utf-8?B?NGNveFVrbDlRWld3MXFWaHQvNUovS01sM1p2eEszbnlkQTlvdG9hMkZ6WlJ1?=
 =?utf-8?B?M2pESE1wSTF4MDdJOU5ERk4zc2hVRVlhZ3Jmc3VXQSt1eVc2VHRTb1NNQXN6?=
 =?utf-8?B?MExLcDZLOHFFN0xEOEtESU1FQU52K3NPWUljZmRCa09RQzlUVnVRMGUxSTc4?=
 =?utf-8?B?RlJPM0czMFFiZTZaa0V0WnA3WlhWWEpSdGgwa0dhdGpuMmxORFpINGFpRnVt?=
 =?utf-8?B?Y0p2YnBxdFZuS1VNWEFhWndPRWRCWXhUdTRYdnFvaFhtcm41Zmc2bDByeHRr?=
 =?utf-8?B?ZFFDMFVMN2tYcm9udVd5ZWcvVFA5RUY4czlzQzBYazRTNmg3ZnVid2p6M1g3?=
 =?utf-8?B?SEJybFNxNlB2SWhxNGZtT1hxd0x5Z1czT2ExTEZJcENDck51bkRvOVRkcDBS?=
 =?utf-8?B?VFc2SFduVmtTa1IzR0NuMUhUWG9lc3VpRWZodWtqQVBrWk51SmdpSmJqdnBE?=
 =?utf-8?B?TVhXZG1jTWFLQklzMjJDbHFHL2crTnpMSmx0VE90bkNBdXFQVG5XSUg5KzZt?=
 =?utf-8?B?Q3ZJYzNwU1JuZ3N0K2dQN3RrWmt3M0ZBOHNsZ0R2M1JRY1UyTGxnY2kxNlNl?=
 =?utf-8?B?bUp5RVRpVEU0bGhORit2T3lYSGxwVGdqUHdNVmwwRVc2YjlBaDRYY0FKR1F0?=
 =?utf-8?B?VjFUbjFQMlpaWlhBcWJqYVB1T2NDcmh3ckRYYzBCSTYxZFZnWWZZRm1xWElY?=
 =?utf-8?B?LzJ1V1hKbkJ6RUpDdjdwT2NZdXBSOTBBYlkrdUl0VDU5bThBQSthckZzRTBB?=
 =?utf-8?B?cjdJQXVRaGpqd1dNU2FIcys4S1l1M0c4am1FTE00b0UvRXZjdzBmam54dkZZ?=
 =?utf-8?B?dUs2QmlYU2FmNk9xUXY2QzFVTTRCQkNjS0NNeDVSMmIyeVRyZnZKTCt2eU1q?=
 =?utf-8?B?MlVmU29oVDl3ME9sdmV2T0FiU1JMeXdYWCtBRko4YWVXUTBSSzFWcVZBaWFU?=
 =?utf-8?B?UW90dHhNdTE5MHU5MWZuZDZmNlhkVmNCUHArWFFGUS9SUHJMRHhxejNaRmR0?=
 =?utf-8?Q?+JoA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a570783-fdc5-41e2-b477-08dc73bf1496
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 02:39:30.1093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KmiOYSuWlCZcdTj2nVc4NZHxSB51JyFbIukkq8pzWEtiGAbf7A3c+zZ89OA5t9W2U2RkNhHjxfPkcyPdish4/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6492
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
Cg0KSGkgQ2hyaXN0aWFuLA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQpTZW50OiBN
b25kYXksIE1heSAxMywgMjAyNCA3OjQxIFBNDQpUbzogWmhhbmcsIEplc3NlKEppZSkgPEplc3Nl
LlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBIdWFuZywgVGltIDxUaW0uSHVhbmdAYW1k
LmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMDEvMjJdIGRybS9hbWRncHU6IGZpeCBkZXJlZmVy
ZW5jZSBhZnRlciBudWxsIGNoZWNrDQoNCkFtIDEwLjA1LjI0IHVtIDA0OjUwIHNjaHJpZWIgSmVz
c2UgWmhhbmc6DQo+IGNoZWNrIHRoZSBwb2ludGVyIGhpdmUgYmVmb3JlIHVzZS4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogSmVzc2UgWmhhbmcgPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDIgKy0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBpbmRleCA3N2Y2ZmQ1
MDAwMmEuLjAwZmUzYzJkNTQzMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYw0KPiBAQCAtNTcyNSw3ICs1NzI1LDcgQEAgaW50IGFtZGdwdV9kZXZp
Y2VfZ3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgICAqIHRv
IHB1dCBhZGV2IGluIHRoZSAxc3QgcG9zaXRpb24uDQo+ICAgICAgICAqLw0KPiAgICAgICBJTklU
X0xJU1RfSEVBRCgmZGV2aWNlX2xpc3QpOw0KPiAtICAgICBpZiAoIWFtZGdwdV9zcmlvdl92Zihh
ZGV2KSAmJiAoYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4gMSkpIHsNCj4gKyAg
ICAgaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikgJiYgKGFkZXYtPmdtYy54Z21pLm51bV9waHlz
aWNhbF9ub2RlcyA+DQo+ICsxKSAmJiBoaXZlKSB7DQoNClRoYXQgc29sdXRpb24gbG9va3Mgbm90
IG9wdGltYWwgdG8gbWUuDQoNCkNoZWNraW5nIGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9u
b2RlcyA+IDEgYWxyZWFkeSBtYWtlcyBzdXJlIHRoYXQgaGl2ZSBzaG91bGRuJ3QgYmUgTlVMTC4N
Cg0KSWYgYXV0b21hdGVkIGNoZWNrZXJzIGNvbXBsYWluIGFib3V0IHRoYXQgd2Ugc2hvdWxkIHBy
b2JhYmx5IGRyb3AgdGhlDQphZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgPiAxIGNo
ZWNrIGFuZCBjaGVjayBmb3IgaGl2ZSBpbnN0ZWFkLg0KDQpbWmhhbmcsIEplc3NlKEppZSldDQpn
bWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgaXMgb2J0YWluZWQgYnkgcmVhZGluZyByZWdpc3Rl
ciBHQ01DX1ZNX1hHTUlfTEZCX0NOVEwuDQpCdXQgZ2V0dGluZyBoaXZlIG1heSBmYWlsIGJlY2F1
c2Ugb2YgIG5vIG1lbW9yeSAoTk9NRU0pLA0Kb3IgdGhlIGtvYmplY3Qgb2YgeGdtaSBoaXZlIGNh
bm5vdCBiZSBpbml0aWFsaXplZCBpbiB0aGUgZnVuY3Rpb24gYW1kZ3B1X2dldF94Z21pX2hpdmUu
DQpJcyAoYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4gMSkgZXF1aXZhbGVudCB0
byAoIWhpdmUpIGhlcmU/DQoNClJlZ2FyZHMNCkplc3NlDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4u
DQoNCj4gICAgICAgICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCAmaGl2ZS0+
ZGV2aWNlX2xpc3QsIGdtYy54Z21pLmhlYWQpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgIGxp
c3RfYWRkX3RhaWwoJnRtcF9hZGV2LT5yZXNldF9saXN0LCAmZGV2aWNlX2xpc3QpOw0KPiAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKGFkZXYtPnNodXRkb3duKQ0KDQo=
