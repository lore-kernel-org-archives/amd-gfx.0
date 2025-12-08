Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CBED3ABEF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 08:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0265910E078;
	Mon,  8 Dec 2025 08:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DoMUJUQI";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010047.outbound.protection.outlook.com
 [52.101.193.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2125710E078
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 08:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moZ50+s+9HWUPTuirgdYIeql2N77rDMELEAQ1TMMcCIW5ur+qcrcrKiX32J3cxOECZIoD+ayTUwlA2a5HKfbmNBgK1UhCU9hY9ZBrciOrYhja0aXUG2SRV1XsoudPeoNFHS+XC8IE/vzHzK/RLPGyCiIOb5czoKDuzfzXOv+lLyH7kT+oCg+35y64zJxMkOsrirjFZVuwFDAbQydyLWXJocFau01cbzCHrDbTF/Vy9tQoAYPXgCMRD9tPertUOF7CEI14dmW/ezx/THTRZkgSq0mS2nLniFzd88wdqhzNXn+qNXWuxGht+42g9yA6RgzJDLeoEbu9xWYXOk2yYyHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjdBMz55WcaUNSfzUPcVTjT5lIkLT9IExUJqPXI6LjU=;
 b=pHBwsTj7VVgFpVHKy0wCPs8TPO01ptj20nYbHoqqOZ/FhT0wzLWPuQkgIPgYQJcxYSDMUaSkQMTIEM3bU1eRnA5eOueFIEbFNWrIGd8vDV1pF3lzXVteCSBDZjSZgV8KySejtnRkJF2dYXai9ATfpGSdY5BTHxlvHbWDP1DZNoeilaW5A/BQcqTDH1pEhc6e5sMEjGPFnsh3RFlhX1myLFg/LditJycb4c45dLQpWcGyETin3Ilq/fz+FOIuD/Lnb9jjNpdPS3nnAjXx3TqSP3xqMMCwOBKLMfFCqh4SygEZZ1bg8HmnoNR6bRM2mguaqwlFRQn9ct8OfZ+9U0g1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjdBMz55WcaUNSfzUPcVTjT5lIkLT9IExUJqPXI6LjU=;
 b=DoMUJUQIPlpL52RxxTvDazMgrbwKNOH73tW9vBXbsvk9DmBs2oeKQATjwFdLLt3gCpQVkIKp9moR9y7H9UtmP2iPgnpipjM/yfV7fiNtq8MjKeZWP/SPxXQMW2Yh8Ott5kVrt8S7XKZYAXCcvM2fxN1AI9e1GRLqsMBtdgW8aJs=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 08:03:11 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 08:03:11 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: Reduce stack usage in
 amdgpu_virt_ras_get_cper_records()
Thread-Topic: [PATCH] drm/amd/ras: Reduce stack usage in
 amdgpu_virt_ras_get_cper_records()
Thread-Index: AQHcZeDdQlQ2095fwk6A9nMlsXbF6rUXZmaw
Date: Mon, 8 Dec 2025 08:03:11 +0000
Message-ID: <PH7PR12MB87969A1A77C82B6154B2DB12B0A2A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20251205121510.408539-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251205121510.408539-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-08T08:03:03.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB8426:EE_
x-ms-office365-filtering-correlation-id: bbfae6ca-96cd-4ee9-7286-08de36303b74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?aDV2MnpEZVhhRjd1VW9MSHBMb1ZEVFBXTmRYS2kxWFFHM0ZmbHNXWFZGN3JW?=
 =?utf-8?B?RmM4S0JkYkl0amtrbEtXa1Z3S3gvN2diTHJTalVQclJRRVVzUUptRVcwVFZy?=
 =?utf-8?B?Uy9xcDZuRDMxN1VISEd0a3grTHJBRzZwRUJ5MDJBN2JWV0NkZkg5WmkxOE10?=
 =?utf-8?B?dWt2aXZyb3NwNjk0eXpWRkpVbWlCRXlLamdVcGJVd1hkdE05elR0MVgxYlQr?=
 =?utf-8?B?dStyN1hMZk4vM0RkTkx5ZUFUTHhYcHk0Nml1WjRzSExrSTRYL1lEQ3B3NU1y?=
 =?utf-8?B?UTlFaUNtRlU3NmhUeElRY1haaHltWkNmTFVnRVJFTFgxNnMyTG8wVVgwbjJq?=
 =?utf-8?B?aUI5Wm54S1dsYjU5YkhleFJtSlNlNytEbGU4MDRvcWdCczd4S3FuMEppVVgz?=
 =?utf-8?B?b3hSeEx2Y0k4SHcybGxiY25POFBmT0tsLzhTQk1keTdldG04dFF1ZU5KbzBp?=
 =?utf-8?B?eDJ2dCtvTWd6TmVzZjRxTVlMbmI0NmNDN0UrMjUvcmxIclMvbEZ0Szhod21r?=
 =?utf-8?B?UlV2MG9rN3dmbUlwRGVNeXZFcFR1VEZJdGR3eG96UDhlNXV3ZFF3NHZBTVFz?=
 =?utf-8?B?R1RLS3R0T2N5N3FRY2ZJY1psMmthNzd1TnVDZmoxWThORFkwamU2dWJnZ2Nu?=
 =?utf-8?B?OWl1SC91eWp5WWl4TzVNNHBHUklYOW02cEtDZFY5d0EzTzBVVlhISTFWS2hj?=
 =?utf-8?B?V2dSOCsyd0JIb0I0Q3NaLzhLcmlSL0tTVHduVmZ4WHpIV2hVak1YQzJyQU5W?=
 =?utf-8?B?LzNXK1ovQVAxUzFUN2VsREtCS3diWmRwaXhDOE00OWtPN24vR3haYjhMbktt?=
 =?utf-8?B?SDJlR0h2TmlZekNGVER3NTB3ZDE1ZmFXaVQ5d0NaNGhFSEg1ckJadzNMenZM?=
 =?utf-8?B?NitjUzlQZE8wWU4vSFJLZWdSMXYyWS9oMmtGVHBqclhBdElRZHMvM25rRGN5?=
 =?utf-8?B?TzRiNVJac1ozcFpESWR5RllqMnNHZ1JnZDJQZ1IvVkNFR1hXa0trTHlJbnht?=
 =?utf-8?B?WHp6R1M0QWxJVmNMYit4TEN0UTJ4aHY1a29iNFFaN2hHSTg0TktGK2JkaFBm?=
 =?utf-8?B?RUhZZ3p3bWlhS1M1aGtldnIxa04rdXQ0V2VRMDlOVEVMM2JpOE1jRHVMT29n?=
 =?utf-8?B?L0tNcnRIRjZBRW8vWmxsL0hSbmJ6dmdiZFFUMmNpQmpzRUZwMHNQNFFSek04?=
 =?utf-8?B?cVNlQlJvTTY5VE42ZERuS2dZTTBlS1l5cTZ1Z3lmMC9WT05MK3VRcngxdXla?=
 =?utf-8?B?WFNBYUZVS1U0NEt5dlFKYytMTjJNcDRGVldHNEIzRHBaMGgzYTM1QVFDK09N?=
 =?utf-8?B?N0J3WFJ2dlRQT0lwUEpYQkFtTmdVMm1OOUpYZ1A0dEJJWXZPZk5IdGJmQklV?=
 =?utf-8?B?YTkwZEtVSyswQVJId3kzZW9ZZmtDRDhxWTNaZDRqcTh6UGFZK25zazRMVXlY?=
 =?utf-8?B?YUZyYmw1dkVMRTAza0NkeUJaajB5Q3VJVlIvYW9BQ2dHNVFvWEdzOG92eHBk?=
 =?utf-8?B?VitWbkJ3RzRSUHh4S1hjeEJqK1c4bWcyTCtiMHpraTdtS1ZXUjUzdnhmNDhG?=
 =?utf-8?B?Q0k3VmpkeHM4Znd3T05KTnptMEcvcUpaeWNIbTBrMXNKQWlXeGdkYmRBbXJr?=
 =?utf-8?B?YmE5eWNQaDN5UWRTRjZkMkRNaS80NGs5M1lyVnVYTmNxRXlObEpwUzBwNzNz?=
 =?utf-8?B?OHpTWkY1b2NtMUFMbXZ1U3c2alk1KzZSd1laZGMvMUY3SUQzdGdyRDlGOTA1?=
 =?utf-8?B?OXJZYUtkakR2aGRKRlYwOGdYUXk2blFHVWNQTHpreDdIWm5KK3J6THNMTlQr?=
 =?utf-8?B?RHczNmszeEQvWkx0ZkVJUTFsa3YyTXFwZjZXVGpJbmJ4Vm1sSFg1a0dXeVpJ?=
 =?utf-8?B?NmtvRVNaZit2MXg4bzBuYzByYnFYcTdGVFJEY2pMVTdJMk1xd1VFVTZMSXls?=
 =?utf-8?B?cnJDTjdKNURwL3BKRk1GOHdYdnZ5alRZUGJiWXFkaDVYWXE4OVZsVFRxa2J3?=
 =?utf-8?B?ZmhuV0h6aVZHcjIvNEpTMzJJbXlyYkk1dVgwcTJUYnVVMUNKTkRuSlYxckZs?=
 =?utf-8?Q?onv/oH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0tSVEFteU0va2hYQXIyNC90THVNYUZDMGlLV09mVzRCQW15SGhSekxwempv?=
 =?utf-8?B?L01WdkpoYjM5SXpmbldkMlpxWVR3UXNUSCtBVkpHTHozU1MvTEpqRjF1cGZP?=
 =?utf-8?B?cDc1alQ1K0lucjcxZTB2bXpuSmRtVCtGNjdNbGtuRW5hREFWbFN3RUlYenc2?=
 =?utf-8?B?NDR0VDAwQzJTLy9PeEszVDJjcjlqeWs0U3NBRk9pWWl5TmVOVm5JM2J6UHZh?=
 =?utf-8?B?d0tITUtSM0ZNQi9HYzk1eXN1WklVUFlFUkM5RGNGcXFWM0YyWjJQMkxsWW91?=
 =?utf-8?B?aGZ0d29DSzVTY2hVV2xxV0VZdTFJczlzdk5nejdDRWxXQU94UE9iakx6OTJx?=
 =?utf-8?B?dmxsRUJWd3NNb24zMXRuSGVONFJiR2QvcDVITksvMWtLMURicGd0bEhFblVC?=
 =?utf-8?B?ck8zYlZNNHVSdXpDVU5aN1I0OE5INUFaRlpZNVRtNUhFSXd1UWJIYzhwWlRm?=
 =?utf-8?B?UVV2N1A4R3Bjd0dHeDEwVVJ0RDZPbTBOaFlyZFRkK3A0K2h5R3ZsMUFFdy9R?=
 =?utf-8?B?MmZSRTR4VVNGSGJpdnNra0pRZW85NVpRQ2xjL28vb01kYUpjMDhlNnh6ZThr?=
 =?utf-8?B?d1FVRmNRclR2YVBvcjZ6MitCdEFrMjJBd0I0N1IwTi91cmFQMVQwdTVlc3Ji?=
 =?utf-8?B?ZGVtV1RzTGVHRmdxbzQ4dFVGNVVzWHBicUdsREM4ZjRSL2pSeEN4OU9tSjRS?=
 =?utf-8?B?eVg5RU1jK21XcVVDbE5wRitma09DSUpLV1pkQy82emFDdnh4OGQvNnVLcElI?=
 =?utf-8?B?cEZCN1ZubDdhUmcwVnNpenR5OTBBKzZncjQvMzMwK2cwU1Q5MzlROVBKUmRN?=
 =?utf-8?B?cVRNQjJPNE9aTzdNdGFDME44eWEvQkdaRHBTRVAvcVFRVy90SW1NWmZ6WHBy?=
 =?utf-8?B?ODB6d2tkbFBUZ21MSS9YUmt6SUtTcGhTTENtdWhLWjAwL0tpMkt0N3Y4TjIr?=
 =?utf-8?B?empqcnpUVk1EeXFnYVVydjc4enN2QXRrMDVXaG9laGR5RHF2QUNzYk5yT0kw?=
 =?utf-8?B?WThyNUFqOENrbWRmNHVKYlcrVDd4OUtBVnk0d0NuUmp4OFNTQk1MRVZrL2Nn?=
 =?utf-8?B?NGlrbmRWZ2lHT0JVQWRkemV3QUFBdVJYb2ttblRaamRGWFZQRUk3cVl2Qm5m?=
 =?utf-8?B?QlZFNmsyblJDcVBLNFZuRnp2aUJuUUNsdmwxZmhhNHRJa1Vnc28xSTlpSTNU?=
 =?utf-8?B?K05lK1ZsVVM2QlFDOTlSVXZac0ZFSUxaRTRhTmtPb0pIRjRnRUY0UGo0aG1i?=
 =?utf-8?B?VXdlNndLL3g0SU5GNTZpcDJFQ1lWRXI0TWVNTVVKa0ozMmFGWkNTYU9BZmhs?=
 =?utf-8?B?NTZqanlsNkJXQkFaQ0daR3NVVWp1MU9GUTV4ZmRzRFg1Y3hwLzJVdzRLUlZx?=
 =?utf-8?B?dENKQSs0dUJVc2N6Q0tmZ2VvTld5S25odWxwalNZL0FIUjViV05YWnlQLzRx?=
 =?utf-8?B?TCtlcUFIOUhpWWZQWXVIY2pBbTFCMUZSY1FvL1NQajVMMVg0aFZLTFlabGRK?=
 =?utf-8?B?aGxGQ1lxQy9RZS9JYUt5ZlM0eGxsSDh1aXVhb0pucUdOUENvaHE5TVErNWsv?=
 =?utf-8?B?SFM0S2x2L044dmZBdndVeUFCMHBvdi9IcytyMk40L1gzeC9QNDdlWk1LbFVT?=
 =?utf-8?B?T3RoWGRBQlJjUUZrY1gwa282S09wOTFCMnIrZVBqazZxa1VLVEJHUXcwK1ZW?=
 =?utf-8?B?UURCOWR6MjltMjZXZ1NFUk1MdnJUVWg5NWJOYTR1Z3dxeHVCc1Fqb2xISG9k?=
 =?utf-8?B?N3hPb1JsUjZIZ1hvK2Q1dFdMU2pzMFkzWnZnQ3FEMTVWRWNGQmlJeHF6WTRx?=
 =?utf-8?B?WVFYZVd5WkVpM3YxdGttWUtxWnNxVnFQanpRcWlHQWxvZjR1dWpmWjRjYWtV?=
 =?utf-8?B?bzdjRjZXNThodEJyZVdNSFQzd0YrbFZnZ3ZabFJ2Y1VCMjdraUYvZFJOd0dQ?=
 =?utf-8?B?djZTK2pxNDlJeE9iMkMweUV4cDN3NGNVd2h3Vi94M1c2aDRDcEx5djBxWjlL?=
 =?utf-8?B?SFc2Y0dnK2gyOVNWMG9BQmpnbHRlZlI3TEVyZTlNNUNSc0FlMldLUjlzakls?=
 =?utf-8?B?d2JDZ2xoN0R4UVVnL3BvQ09lR3JOUWRJRCs5VENWZ2lCWm9wNTNSTi8xS0tl?=
 =?utf-8?Q?bbAI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfae6ca-96cd-4ee9-7286-08de36303b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 08:03:11.6637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zbyfR2fKe2tA8eGF89vZhzzyNtugq5AYmwKTB2mty2xMiQ+ZwnxhHPetpT4y+T7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426
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
Cg0KUmV2aWV3ZWQtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5J
VkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgNSwgMjAy
NSA4OjE1IFBNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQu
Y29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0K
PiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNB
Tg0KPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IFpob3UxLCBUYW8NCj4gPFRhby5a
aG91MUBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIXSBkcm0vYW1kL3JhczogUmVkdWNlIHN0YWNrIHVzYWdlIGluDQo+IGFt
ZGdwdV92aXJ0X3Jhc19nZXRfY3Blcl9yZWNvcmRzKCkNCj4NCj4gYW1kZ3B1X3ZpcnRfcmFzX2dl
dF9jcGVyX3JlY29yZHMoKSB3YXMgdXNpbmcgYSBsYXJnZSBzdGFjayBhcnJheSBvZg0KPiByYXNf
bG9nX2luZm8gcG9pbnRlcnMuIFRoaXMgY29udHJpYnV0ZWQgdG8gdGhlIGZyYW1lIHNpemUgd2Fy
bmluZyBvbiB0aGlzDQo+IGZ1bmN0aW9uLg0KPg0KPiBSZXBsYWNlIHRoZSBmaXhlZC1zaXplIHN0
YWNrIGFycmF5Og0KPg0KPiAgICAgc3RydWN0IHJhc19sb2dfaW5mbyAqdHJhY2VbTUFYX1JFQ09S
RF9QRVJfQkFUQ0hdOw0KPg0KPiB3aXRoIGEgaGVhcC1hbGxvY2F0ZWQgYXJyYXkgdXNpbmcga2Nh
bGxvYygpLg0KPg0KPiBXZSBmcmVlIHRoZSB0cmFjZSBidWZmZXIgdG9nZXRoZXIgd2l0aCBvdXRf
YnVmIG9uIGFsbCBleGl0IHBhdGhzLg0KPiBJZiBhbGxvY2F0aW9uIG9mIHRyYWNlIG9yIG91dF9i
dWYgZmFpbHMsIHdlIHJldHVybiBhIGdlbmVyaWMgUkFTIGVycm9yIGNvZGUuDQo+DQo+IFRoaXMg
cmVkdWNlcyBzdGFjayB1c2FnZSBhbmQga2VlcHMgdGhlIHJ1bnRpbWUgYmVoYXZpb3VyIHVuY2hh
bmdlZC4NCj4NCj4gRml4ZXM6DQo+IHN0YWNrIGZyYW1lIHNpemU6IDExMTIgYnl0ZXMgKGxpbWl0
OiAxMDI0KQ0KPg0KPiBDYzogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPg0KPiBDYzogSGF3
a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiBDYzogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdh
bSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gLS0tDQo+ICAuLi4vZHJtL2FtZC9y
YXMvcmFzX21nci9hbWRncHVfdmlydF9yYXNfY21kLmMgICB8IDE3ICsrKysrKysrKysrKystLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc19tZ3IvYW1kZ3B1X3Zp
cnRfcmFzX2NtZC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvcmFzX21nci9hbWRncHVf
dmlydF9yYXNfY21kLmMNCj4gaW5kZXggNWU5MGExODcxNTViLi5hNzU0Nzk1OTM4NjQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc19tZ3IvYW1kZ3B1X3ZpcnRfcmFz
X2NtZC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc19tZ3IvYW1kZ3B1X3Zp
cnRfcmFzX2NtZC5jDQo+IEBAIC0xODMsNyArMTgzLDcgQEAgc3RhdGljIGludCBhbWRncHVfdmly
dF9yYXNfZ2V0X2NwZXJfcmVjb3JkcyhzdHJ1Y3QNCj4gcmFzX2NvcmVfY29udGV4dCAqcmFzX2Nv
cmUsDQo+ICAgICAgICAgICAgICAgKHN0cnVjdCByYXNfY21kX2NwZXJfcmVjb3JkX3JzcCAqKWNt
ZC0+b3V0cHV0X2J1ZmZfcmF3Ow0KPiAgICAgICBzdHJ1Y3QgcmFzX2xvZ19iYXRjaF9vdmVydmll
dyAqb3ZlcnZpZXcgPSAmdmlydF9yYXMtDQo+ID5iYXRjaF9tZ3IuYmF0Y2hfb3ZlcnZpZXc7DQo+
ICAgICAgIHN0cnVjdCByYXNfY21kX2JhdGNoX3RyYWNlX3JlY29yZF9yc3AgKnJzcF9jYWNoZSA9
ICZ2aXJ0X3Jhcy0NCj4gPmJhdGNoX21nci5iYXRjaF90cmFjZTsNCj4gLSAgICAgc3RydWN0IHJh
c19sb2dfaW5mbyAqdHJhY2VbTUFYX1JFQ09SRF9QRVJfQkFUQ0hdID0gezB9Ow0KPiArICAgICBz
dHJ1Y3QgcmFzX2xvZ19pbmZvICoqdHJhY2U7DQo+ICAgICAgIHVpbnQzMl90IG9mZnNldCA9IDAs
IHJlYWxfZGF0YV9sZW4gPSAwOw0KPiAgICAgICB1aW50NjRfdCBiYXRjaF9pZDsNCj4gICAgICAg
dWludDhfdCAqb3V0X2J1ZjsNCj4gQEAgLTE5NSw5ICsxOTUsMTUgQEAgc3RhdGljIGludCBhbWRn
cHVfdmlydF9yYXNfZ2V0X2NwZXJfcmVjb3JkcyhzdHJ1Y3QNCj4gcmFzX2NvcmVfY29udGV4dCAq
cmFzX2NvcmUsDQo+ICAgICAgIGlmICghcmVxLT5idWZfc2l6ZSB8fCAhcmVxLT5idWZfcHRyIHx8
ICFyZXEtPmNwZXJfbnVtKQ0KPiAgICAgICAgICAgICAgIHJldHVybiBSQVNfQ01EX19FUlJPUl9J
TlZBTElEX0lOUFVUX0RBVEE7DQo+DQo+ICsgICAgIHRyYWNlID0ga2NhbGxvYyhNQVhfUkVDT1JE
X1BFUl9CQVRDSCwgc2l6ZW9mKCp0cmFjZSksDQo+IEdGUF9LRVJORUwpOw0KPiArICAgICBpZiAo
IXRyYWNlKQ0KPiArICAgICAgICAgICAgIHJldHVybiBSQVNfQ01EX19FUlJPUl9HRU5FUklDOw0K
PiArDQo+ICAgICAgIG91dF9idWYgPSBremFsbG9jKHJlcS0+YnVmX3NpemUsIEdGUF9LRVJORUwp
Ow0KPiAtICAgICBpZiAoIW91dF9idWYpDQo+ICsgICAgIGlmICghb3V0X2J1Zikgew0KPiArICAg
ICAgICAgICAgIGtmcmVlKHRyYWNlKTsNCj4gICAgICAgICAgICAgICByZXR1cm4gUkFTX0NNRF9f
RVJST1JfR0VORVJJQzsNCj4gKyAgICAgfQ0KPg0KPiAgICAgICBtZW1zZXQob3V0X2J1ZiwgMCwg
cmVxLT5idWZfc2l6ZSk7DQo+DQo+IEBAIC0yMDUsOCArMjExLDkgQEAgc3RhdGljIGludCBhbWRn
cHVfdmlydF9yYXNfZ2V0X2NwZXJfcmVjb3JkcyhzdHJ1Y3QNCj4gcmFzX2NvcmVfY29udGV4dCAq
cmFzX2NvcmUsDQo+ICAgICAgICAgICAgICAgYmF0Y2hfaWQgPSByZXEtPmNwZXJfc3RhcnRfaWQg
KyBpOw0KPiAgICAgICAgICAgICAgIGlmIChiYXRjaF9pZCA+PSBvdmVydmlldy0+bGFzdF9iYXRj
aF9pZCkNCj4gICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAtICAgICAgICAgICAgIGNv
dW50ID0gYW1kZ3B1X3ZpcnRfcmFzX2dldF9iYXRjaF9yZWNvcmRzKHJhc19jb3JlLA0KPiBiYXRj
aF9pZCwgdHJhY2UsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQVJS
QVlfU0laRSh0cmFjZSksIHJzcF9jYWNoZSk7DQo+ICsgICAgICAgICAgICAgY291bnQgPSBhbWRn
cHVfdmlydF9yYXNfZ2V0X2JhdGNoX3JlY29yZHMocmFzX2NvcmUsDQo+IGJhdGNoX2lkLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRy
YWNlLA0KPiBNQVhfUkVDT1JEX1BFUl9CQVRDSCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByc3BfY2FjaGUpOw0KPiAgICAgICAgICAg
ICAgIGlmIChjb3VudCA+IDApIHsNCj4gICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHJhc19j
cGVyX2dlbmVyYXRlX2NwZXIocmFzX2NvcmUsIHRyYWNlLCBjb3VudCwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmb3V0X2J1ZltvZmZzZXRdLCByZXEtPmJ1Zl9zaXpl
IC0NCj4gb2Zmc2V0LCAmcmVhbF9kYXRhX2xlbik7IEBAIC0yMjAsNiArMjI3LDcgQEAgc3RhdGlj
IGludA0KPiBhbWRncHVfdmlydF9yYXNfZ2V0X2NwZXJfcmVjb3JkcyhzdHJ1Y3QgcmFzX2NvcmVf
Y29udGV4dCAqcmFzX2NvcmUsDQo+ICAgICAgIGlmICgocmV0ICYmIChyZXQgIT0gLUVOT01FTSkp
IHx8DQo+ICAgICAgICAgICBjb3B5X3RvX3VzZXIodTY0X3RvX3VzZXJfcHRyKHJlcS0+YnVmX3B0
ciksIG91dF9idWYsIG9mZnNldCkpIHsNCj4gICAgICAgICAgICAgICBrZnJlZShvdXRfYnVmKTsN
Cj4gKyAgICAgICAgICAgICBrZnJlZSh0cmFjZSk7DQo+ICAgICAgICAgICAgICAgcmV0dXJuIFJB
U19DTURfX0VSUk9SX0dFTkVSSUM7DQo+ICAgICAgIH0NCj4NCj4gQEAgLTIzMSw2ICsyMzksNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV92aXJ0X3Jhc19nZXRfY3Blcl9yZWNvcmRzKHN0cnVjdA0KPiBy
YXNfY29yZV9jb250ZXh0ICpyYXNfY29yZSwNCj4gICAgICAgY21kLT5vdXRwdXRfc2l6ZSA9IHNp
emVvZihzdHJ1Y3QgcmFzX2NtZF9jcGVyX3JlY29yZF9yc3ApOw0KPg0KPiAgICAgICBrZnJlZShv
dXRfYnVmKTsNCj4gKyAgICAga2ZyZWUodHJhY2UpOw0KPg0KPiAgICAgICByZXR1cm4gUkFTX0NN
RF9fU1VDQ0VTUzsNCj4gIH0NCj4gLS0NCj4gMi4zNC4xDQoNCg==
