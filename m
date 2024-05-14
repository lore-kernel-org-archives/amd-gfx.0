Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCD3C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8743410E063;
	Tue, 14 May 2024 08:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xnxA2P2s";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61EEB10E063
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SB3bNfn5pXLpAxSzYGnbu965U0rDlt3zhBIV+Mehxsvy3y5KyjiahMbPFP1HNikRve8cYRonONNeYTF8NDeheYirbGf2T34qMQ4RoxYklMTe6TPBrGdQTB7DwShH3e/kXGbJYGbXpV7+mzddRw5h7K+Dqj1M+3TrVkHFlw85M2O1JRcJLaGiVLZYAZxZNjFTBNjiCrSJVWAxoUgEHinaf9wbs1RPsV2H5m1fjrBpZsxGyW4g6Y17gUK+XKNfmjP7FnIS4GUhBvJ7D59TPj7KVT10/n4ik9CKcL/+A78a/IjUknEBFAHAV/fW/SO8Z92anFtQJWWljYbt5YhF4zK8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XobDkf+UQjshedKKwl3l7nvoAV33UV8HkqiaoEhlm8w=;
 b=fI6wfmgrp/p1WJLro2vqi+UMX8fJiUb2qB7cPCXOC5qV/sY+zYUYWKGEnVmjw+Ra+7RBKL0rMIoe+fC5d50lg/YTWhDSLY/LEzgx6L6NIb4vIc2XLnCTHm9n7zseushQh/9HlRZPkoYwjYtRWNntNvhKokFNwj3UDDOP+V3fBG14zECW33zWi8yFCyTsr0LrzmlCU8W8z8Pb6zvuEghu3/lv2eg8KKFcBEzYGGFzTU0qFV+FxDwT7e/n4/8LEo83EyOYIGU2Fnib1oMQZ0f8YfYN3IV6Qa1Uv3nkN55V5M/HG/SHjjzz2BPo4MxrgkEQmLHBeI3AuLdKSHi5BcFJWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XobDkf+UQjshedKKwl3l7nvoAV33UV8HkqiaoEhlm8w=;
 b=xnxA2P2sLhSnx3FN/N6Daqb+CW+t/LsWY4s1FLoeFpbl23rVJ+/Rw1zQA9yqHsnjrug71rTNDqKeeP+SPznQ0uNfJaoaEh6iCoeBboJ/kNLZVxi44dc6BPnkPxOIrqqsvvC7QjAIIfvhOKD75N4ZwghaKmnnyu346Ks5Q59DN0I=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 08:13:01 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:13:01 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use the slab allocator to reduce job
 allocation fragmentation
Thread-Topic: [PATCH] drm/amdgpu: Use the slab allocator to reduce job
 allocation fragmentation
Thread-Index: AQHaorG6Scuc3VpcmUaVSzwKhiE4xLGQNAOAgAYgqKA=
Date: Tue, 14 May 2024 08:13:00 +0000
Message-ID: <DS7PR12MB60058CA25A0C67B2AC809C33FBE32@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20240510081145.4081645-1-Prike.Liang@amd.com>
 <fe0c458c-7c1e-481a-acda-6a58dc49319b@amd.com>
In-Reply-To: <fe0c458c-7c1e-481a-acda-6a58dc49319b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e1a17cc5-56ef-4683-a6bf-791308537585;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T07:04:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM4PR12MB6110:EE_
x-ms-office365-filtering-correlation-id: d526caba-e5ba-4a74-5a27-08dc73edac00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NFV1bnBrYnA2SVJGTXFYZnRJVmhTb0duVEdibWVvb3JSaVJWRHVBYkVzRTF1?=
 =?utf-8?B?TzUzcC80SGMwQnJTSklqS09XRkpQc044QkFmK0lDaTUrUkpMZGlRS09BcjBG?=
 =?utf-8?B?UWhwZURaTmJGWFVBeE1VQUhpVUdkRjBZMXJCVGZhdDQwWVR1NEI2R0pMejFJ?=
 =?utf-8?B?V05sWGE1WkFaOXlLaEppSjZZZmtmTk8yWTBmeHVkYXh5V0luSTZOUDRub0cy?=
 =?utf-8?B?ODdXOG1PUWs1em5HODJ2WEhOdkZaK1JLdnZDMmFieWdXaVpMZklabEFTV1g5?=
 =?utf-8?B?a3FYTlhTeHpTdWJEVWU2eHdYcGJHaTEwVVJlVnVyNXVGZW1SN3loak9wdUtN?=
 =?utf-8?B?alppYURoa3VLbjdGT2Nocnhta3JUV2FPWEQ0Z2RzaFpIRGNESU5ZQ3BmMm9j?=
 =?utf-8?B?VjhpL3FmWmVPbVBTQ0twdCsxUVByOWdYcU9la3lXWkJhZHA5MkJ0ZEsvVndD?=
 =?utf-8?B?dVh1RG9FRWcwSGpFeEFpTnhsTklrVVl4MEpVUk5ZYnR3cVo1SnJPcEF5RHpM?=
 =?utf-8?B?enRYOWVVUnUvSnVEQm9OcXJGblpyVWtaTFRQTWhwcU5BVWhXeDVZaVY1TEdJ?=
 =?utf-8?B?M3VtS09Ec2doS3VwemhHWGhNcUpHMnpFa1hmbVhZek11ZnJnN0szb1pneTFI?=
 =?utf-8?B?aTVXN3MwaGZNNXNWNEQxbHRkNmgvT3UrUXRMVTE4aUVXbmtncTlxNlR0SHhw?=
 =?utf-8?B?M2FiQ0c4ZVVoM0tPakhRcHplZGFJVzVPLzAycmtYYWRHTXR3blo0ZUhxN3po?=
 =?utf-8?B?ZElCTkVmZmRtUC83cTlWT1BieXNkWk5WTkR4Z0Vzem1BRVQ2R2ZHWEtIejdO?=
 =?utf-8?B?ZDBHQ3hJZ3ROSTgrSXFGeGI2UDhGNTU5YWpRZ3k4ZTU2SWZFSVZVMHlubXR3?=
 =?utf-8?B?M21OanB2aHNjQlNaRXlyZC9JZSt3WGg0WGw3bTQyaG9lRzlkbmwzQmdmK0Vv?=
 =?utf-8?B?NTZ1a2tZQStSUnNOSkNlQm1zSjFKZGNKSllPQnhUTXE1VmxydXRWYXQvTXJP?=
 =?utf-8?B?M1grVUpjdFpneS85RUs3ZUpPYzRtc1JQMUZVc2hpTGN3dG9Dd3lXcHAvcVVR?=
 =?utf-8?B?a1NaZVN4bUVLVDZydXFSbzJFSERLUEdRRjAzeVRFQ3F3d1lSMzM5NXh6blln?=
 =?utf-8?B?R1Z3NkF5VEFLcFQ0N3VXcVoxTDFlZ0wvT0JrNVc2YnpsVjU0bXBURUl1NzYy?=
 =?utf-8?B?MWx4ZW9XMjFobExwRGFIckhPd2RjVit4bmNUWGd4WHRycjhpRklDZjZtNUdY?=
 =?utf-8?B?cENDVnh6U3VYOUZpVUhnb0pUdlZiWmtHcDJIY0pzRUozTUtUbWNibTRuMk1Y?=
 =?utf-8?B?eFd3WVpyRGY2bDFmWDR2TWJpQ2hhL0E2V29Sb0NtU0U5dFkrTjNuTHhtL3hR?=
 =?utf-8?B?cnQxbUo5eUhQZkkyNlo5NXBtSzdpQW9ZM1Awa0ZkZ0tvRjg3eExVQy9zL3RF?=
 =?utf-8?B?MmlSUDFLeGR4dUk5RkdLWUJNQm15TStuczBGU1dNaWJqcmppQldHblB2NlFS?=
 =?utf-8?B?QVFweEpBZFNpbjV4UHJmc3crQzF0ZUx2ODk3QTYrOEVLb0FodDVDYmgyZkNG?=
 =?utf-8?B?V1E0c25EUkY2R0I2MDMralF0TFc4alRoMnQvcHhCckRWL2ovcGZHaEJzakFR?=
 =?utf-8?B?RnYvY0RySTdWWVgxb0ovcUNlbGpmNCs3d0szajV4a0M5ZWhUNjJISHFwVjNs?=
 =?utf-8?B?WjJubytTRXd6UnUwR2pZWnZjMnNBdjE2em51a1dvTEZ4c0I0S1FINlA0ejNM?=
 =?utf-8?B?TWNDWFNORll4VnllNVkxc2Qrd0pMeXNIRGdpMUdldUYxckhHbEtIZjJKb2c2?=
 =?utf-8?B?L24xdlcwSW1mNFV3NStqdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlkyTmlrT3lCdjlpMzFjVlQ3RWtFYXVGTmRoQ3QzczMrUmpZQndWQVFnMXdk?=
 =?utf-8?B?Q3NVQTRVUUxNUE53N1J6SEV4b3ljcjFpU24zeEJzbEdvL1hxQVhiei94Nnl1?=
 =?utf-8?B?ZFBjMnhGUVdRa3V0VGx3eWNOanhiak9CbXVrS3d4c2VhRHhhSmhvOVpCbi9S?=
 =?utf-8?B?UnlvR29XbGExeExLWTJFRnpUeVFGaGFja2RMd1kyRWYxYWNrcHdiL2FuK05y?=
 =?utf-8?B?cEY3dXU0R0ZLRmxJL1RlU1RDZlZtSnVGenFkWW9BZUs3MHFvelQySnFzdnpZ?=
 =?utf-8?B?dzVuNWh6bDBmMXFuU2VnZjFWdXlNUWxRRHVOdGhvMDY4MVlaT1VSbzd6K0U1?=
 =?utf-8?B?R3dSdTVBRWJ5M0FrNDVvY2VaMnV2bDdqc3F6Y1dYeVoxZlNxSkFhQTBPWXZC?=
 =?utf-8?B?OEx3dkt0VVphUkIva0RCeWFqTnFGT3ZxbWk4aGRYUTRSUXZndFA2cWZlbi9F?=
 =?utf-8?B?ODgxYnRORk9iRTlKTDM0dDlpSjZUT2RKS2p4ZWVnNnQ3SjdPRzNsQ0l1MCtG?=
 =?utf-8?B?d0JBZUY5N3lRSlBnSENlQ2ZkVGFMbmlwaDhvMkNyVzJweVRPcG5ZZnZjRmo3?=
 =?utf-8?B?VGpFVjdNMVhOb2NtS3NvTFQzSG1OTWl5Rk1VdnlIYlBtaDYvbzUwUEEyc3NZ?=
 =?utf-8?B?NDNCZWdqdm8vVndXZW5DenlzZk5GaFRUTEFQRjFWMXV0T3JIbkxDL2grWUtV?=
 =?utf-8?B?bUVHSGdiZG9OQmpVZ3RSdkpYOFdVNkM0TENCVjUxeG9pWkpEU0dVNGgxUThQ?=
 =?utf-8?B?eXJHMnZSTVdlR1MxZHJxbytIT2tYNk9URU9SM040RjZObDlCb2J3eklOVmlj?=
 =?utf-8?B?OWg4eklET2c2aVdKQW0ycGpldEdoTjhtbnd2OTFFT3M2UWxIZW5NSDRyTWR1?=
 =?utf-8?B?NnJJY1VIdlJra0lGeUZFNUxCRHpiK3hiVDVrcjNGc0NrK1RXK1Bielg0dDkz?=
 =?utf-8?B?Y2NyNi8vQm1aOVZnN21lRWc2QTg0d3ZPUkV5ZTRaUFBSZXdna2Q0MnhEbWVS?=
 =?utf-8?B?RjhnUjZjNEVzbW1uRjJrN2FScW1ZRitab1U0cW5aUVl4NTFUQmVCYVdMQWJR?=
 =?utf-8?B?WWIyTUNlUGJtbFg2QmxXQTNPVE8xZUI5bHpoUXZWNkNBSmp1cUtCVUpxT2VM?=
 =?utf-8?B?MUxPclN2K2tsbFdscUJZUm5iaWpIU3l0TUt1dzI4S2xUeXZqV01mOXFEWHd0?=
 =?utf-8?B?M3l6VlpxT3JSQ1N6ZEFtNGswQ0xrSUhsc2NzMW1mbjEvUkpEUzFPYm40K1pD?=
 =?utf-8?B?UlVKRnJjcW9idGg5VjhhMHdtbGFBS3lNVFc5dUZ1Tzg0QXVIRlNKb2VLZlgx?=
 =?utf-8?B?ZFNiY2kxVGxYUVc5MGdkQnRtaUNDQ3oyZEpFM055WHZiRFZlY044L1hOWTkv?=
 =?utf-8?B?YWNwM1FEYXlEV2o2YjRXV0xVTGg3S1RJRERBN0xHNG5GTkRJQi9WT2lJNTdH?=
 =?utf-8?B?eDBIeXVkNkEvWVViMU5OL2ExMkN1NzZHWXVQVlpRS3VoTHB6UDE0VGJXSFVi?=
 =?utf-8?B?UHh0eTNTTGlFaHVIL3U0R3Q2Z3F4UXlCQjhjU1RJS2QvdGpKRTNlenNRM2NV?=
 =?utf-8?B?TTNOQncyZWZOeFpxckV0REdJeGlkbUp6bTBrVVNYOGlKTll5UHdIdEdETndP?=
 =?utf-8?B?ejZxWkpWOGlhbjUwZE9kVnMwdHIyZUozN2FsTzZwVmNtY3NZWUdLQmgyL1Nj?=
 =?utf-8?B?SlU1ZkE2ZnVMTk1OMGVNVGFMbHRENlNMejhYOUxHWGVmVDk3YTB2ckU2b2Nn?=
 =?utf-8?B?aE1iZWI4cEVMRzhLOFBaTmx6c2ZxTWJYcjNOS00xZGNkOXhUTitwYmN2ajg3?=
 =?utf-8?B?cm5GRC9kd3UzUE9GRXNBM3RUbmNETTFPajhLZnQvYTZFYlF5UGNyUUhlSnZL?=
 =?utf-8?B?UFlDU1J3bVo3WnArQ21Da050Y1RHSkM2VnRQS1NzeWdDL3ViMTNLaXlVZ1Fi?=
 =?utf-8?B?THlNU29yMzVWUE9CakY2NHNiZ1B4THJVVHNvR0Y2YXFDeFhPc0xta3lxTlJG?=
 =?utf-8?B?NzhvZWgyR1NhRjUranU3R2h3RXRCUWd3Z25LWkUxOHdoUG9zeUhLOHZ5MXk1?=
 =?utf-8?B?dlRNUEJzUDhyT2dGelhSdW9uR2VPdDZvZFJyeGRLaXFJdWY5anlKTFhhNm55?=
 =?utf-8?Q?N3bw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d526caba-e5ba-4a74-5a27-08dc73edac00
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:13:00.9363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KhiAcX9nwEFmstqzxI6VGp90LnSuToT/3k4pVNijl1ch3xwWeZNW8uGLfGQc3RG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110
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
Cg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0K
PiBTZW50OiBGcmlkYXksIE1heSAxMCwgMjAyNCA1OjMxIFBNDQo+IFRvOiBMaWFuZywgUHJpa2Ug
PFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBD
YzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBVc2UgdGhlIHNsYWIgYWxsb2NhdG9yIHRvIHJl
ZHVjZSBqb2INCj4gYWxsb2NhdGlvbiBmcmFnbWVudGF0aW9uDQo+DQo+IEFtIDEwLjA1LjI0IHVt
IDEwOjExIHNjaHJpZWIgUHJpa2UgTGlhbmc6DQo+ID4gVXNpbmcga3phbGxvYygpIHJlc3VsdHMg
aW4gYWJvdXQgNTAlIG1lbW9yeSBmcmFnbWVudGF0aW9uLCB0aGVyZWZvcmUNCj4gPiB1c2UgdGhl
IHNsYWIgYWxsb2NhdG9yIHRvIHJlcHJvZHVjZSBtZW1vcnkgZnJhZ21lbnRhdGlvbi4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgIDEg
Kw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIHwgMjYNCj4g
KysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2pvYi5oIHwgIDEgKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gaW5kZXggZWExNGYxYzhmNDMwLi4zZGUxYjQyMjkxYjYg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5j
DQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4g
QEAgLTMwNDAsNiArMzA0MCw3IEBAIHN0YXRpYyB2b2lkIF9fZXhpdCBhbWRncHVfZXhpdCh2b2lk
KQ0KPiA+ICAgICBhbWRncHVfZmVuY2Vfc2xhYl9maW5pKCk7DQo+ID4gICAgIG1tdV9ub3RpZmll
cl9zeW5jaHJvbml6ZSgpOw0KPiA+ICAgICBhbWRncHVfeGNwX2Rydl9yZWxlYXNlKCk7DQo+ID4g
KyAgIGFtZGdwdWVfam9iX3NsYWJfZmluaSgpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBtb2R1bGVf
aW5pdChhbWRncHVfaW5pdCk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9qb2IuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2pvYi5jDQo+ID4gaW5kZXggZTQ3NDJiNjUwMzJkLi44MzI3YmYwMTdhMGUgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jDQo+ID4gQEAgLTMxLDYg
KzMxLDggQEANCj4gPiAgICNpbmNsdWRlICJhbWRncHVfdHJhY2UuaCINCj4gPiAgICNpbmNsdWRl
ICJhbWRncHVfcmVzZXQuaCINCj4gPg0KPiA+ICtzdGF0aWMgc3RydWN0IGttZW1fY2FjaGUgKmFt
ZGdwdV9qb2Jfc2xhYjsNCj4gPiArDQo+ID4gICBzdGF0aWMgZW51bSBkcm1fZ3B1X3NjaGVkX3N0
YXQgYW1kZ3B1X2pvYl90aW1lZG91dChzdHJ1Y3QNCj4gZHJtX3NjaGVkX2pvYiAqc19qb2IpDQo+
ID4gICB7DQo+ID4gICAgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9IHRvX2FtZGdwdV9yaW5n
KHNfam9iLT5zY2hlZCk7IEBAIC0NCj4gMTAxLDEwDQo+ID4gKzEwMywxOSBAQCBpbnQgYW1kZ3B1
X2pvYl9hbGxvYyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0DQo+IGFtZGdwdV92
bSAqdm0sDQo+ID4gICAgIGlmIChudW1faWJzID09IDApDQo+ID4gICAgICAgICAgICAgcmV0dXJu
IC1FSU5WQUw7DQo+ID4NCj4gPiAtICAgKmpvYiA9IGt6YWxsb2Moc3RydWN0X3NpemUoKmpvYiwg
aWJzLCBudW1faWJzKSwgR0ZQX0tFUk5FTCk7DQo+ID4gLSAgIGlmICghKmpvYikNCj4gPiArICAg
YW1kZ3B1X2pvYl9zbGFiID0ga21lbV9jYWNoZV9jcmVhdGUoImFtZGdwdV9qb2IiLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Rfc2l6ZSgqam9iLCBpYnMsIG51bV9pYnMp
LCAwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBTTEFCX0hXQ0FDSEVfQUxJR04s
IE5VTEwpOw0KPg0KPiBXZWxsIHlvdSBhcmUgZGVjbGFyaW5nIGEgZ2xvYmFsIHNsYWIgY2FjaGUg
Zm9yIGEgZHluYW1pYyBqb2Igc2l6ZSwgdGhlbiB0cnkgdG8NCj4gc2V0IGl0IHVwIGluIHRoZSBq
b2IgYWxsb2NhdGlvbiBmdW5jdGlvbiB3aGljaCBjYW4gYmUgY2FsbGVkIGNvbmN1cnJlbnRseSB3
aXRoDQo+IGRpZmZlcmVudCBudW1iZXIgb2YgSUJzLg0KPg0KPiBUbyBzdW0gaXQgdXAgIHRoaXMg
aXMgY29tcGxldGVseSByYWN5IGFuZCB3aWxsIGdvIGJvb20gaW1tZWRpYXRlbHkgaW4gdGVzdGlu
Zy4NCj4gQXMgZmFyIGFzIEkgY2FuIHNlZSB0aGlzIHN1Z2dlc3Rpb24gaXMganVzdCB1dHRlcmx5
IG5vbnNlbnNlLg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQpIaSwgQ2hyaXN0aWFu
DQoNClRoZSBudW1faWJzIGlzIGNhbGN1bGF0ZWQgYXMgMSBpbiBhbWRncHVfY3NfcDFfaWIoKSBh
bmQgZnJvbSBhbWRncHVfY3NfcGFzczEoKSwgdGhlIG51bV9pYnMgd2lsbCBiZSBzZXQgdG8gMSBh
cyBhbiBpbnB1dCBwYXJhbWV0ZXIgYXQgYW1kZ3B1X2pvYl9hbGxvYygpLiBNb3Jlb3ZlciwgdGhl
IG51bV9pYnMgaXMgb25seSBzZXQgZnJvbSBhbWRncHVfY3NfcDFfaWIoKSBhbmQgc2hvdWxkbid0
IGhhdmUgYSBjaGFuY2UgdG8gYmUgb3ZlcndyaXR0ZW4gZnJvbSB0aGUgdXNlciBzcGFjZSBkcml2
ZXIgc2lkZS4gQWxzbywgSSBjaGVja2VkIGEgZmV3IEdMIGFuZCBWdWxrYW4gYXBwbGljYXRpb25z
IGFuZCBkaWRuJ3QgZmluZCBtdWx0aXBsZSBJQnMgd2l0aGluIG9uZSBhbWRncHUgam9iIHN1Ym1p
c3Npb24uDQoNCklmIHRoZXJlIGFyZSBzdGlsbCBjb25jZXJucyBhYm91dCB0aGUgSUIgYXJyYXkg
c2l6ZSBvbiB0aGUgYW1kZ3B1X2pvYiBvYmplY3QgYWxsb2NhdGVkLCB3ZSBjYW4gcmVtb3ZlIHRo
ZSBJQnMgbWVtYmVyIGFuZCBkZWNvbXBvc2UgdGhlIElCIHdpdGggdGhlIGpvYiBvYmplY3QuIFRo
ZW4sIHdlIGNhbiBleHBvcnQgYW5kIGFjY2VzcyB0aGUgSUJzIGFzIGEgcGFyYW1ldGVyIGZyb20g
YSBuZXcgaW50ZXJmYWNlIGxpa2UgYW1kZ3B1X2NzX3BhdGNoX2licyhzdHJ1Y3QgYW1kZ3B1X2Nz
X3BhcnNlciAqcCwgc3RydWN0IGFtZGdwdV9qb2IgKmpvYiwgc3RydWN0IGFtZGdwdV9pYiAqaWIp
Lg0KDQpSZWdhcmRpbmcgdGhpcyBwYXRjaCwgdXNpbmcga21lbV9jYWNoZV96YWxsb2MoKSBpbnN0
ZWFkIG9mIGt6YWxsb2MoKSBjYW4gc2F2ZSBhYm91dCA0NDggYnl0ZXMgb2YgbWVtb3J5IHNwYWNl
IGZvciBlYWNoIGFtZGdwdV9qb2Igb2JqZWN0IGFsbG9jYXRlZC4gTWVhbndoaWxlLCB0aGUgam9i
IG9iamVjdCBhbGxvY2F0aW9uIHRha2VzIGFsbW9zdCB0aGUgc2FtZSB0aW1lLCBzbyBpdCBzaG91
bGQgaGF2ZSBubyBzaWRlIGVmZmVjdCBvbiB0aGUgcGVyZm9ybWFuY2UuIElmIHRoZSBpZGVhIGlz
IHNlbnNpYmxlLCBJIHdpbGwgcmV3b3JrIHRoZSBwYXRjaCBieSBjcmVhdGluZyB0aGUgam9iIHNs
YWIgZHVyaW5nIHRoZSBkcml2ZXIgcHJvYmUgcGVyaW9kLg0KDQpUaGFua3MsDQpQcmlrZQ0KPiA+
ICsgICBpZiAoIWFtZGdwdV9qb2Jfc2xhYikgew0KPiA+ICsgICAgICAgICAgIERSTV9FUlJPUigi
Y3JlYXRlIGFtZGdwdV9qb2IgY2FjaGUgZmFpbGVkXG4iKTsNCj4gPiAgICAgICAgICAgICByZXR1
cm4gLUVOT01FTTsNCj4gPiArICAgfQ0KPiA+DQo+ID4gKyAgICpqb2IgPSBrbWVtX2NhY2hlX3ph
bGxvYyhhbWRncHVfam9iX3NsYWIsIEdGUF9LRVJORUwpOw0KPiA+ICsgICBpZiAoISpqb2IpIHsN
Cj4gPiArICAgICAgICAgICBrbWVtX2NhY2hlX2Rlc3Ryb3koYW1kZ3B1X2pvYl9zbGFiKTsNCj4g
PiArICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiArICAgfQ0KPiA+ICAgICAvKg0KPiA+
ICAgICAgKiBJbml0aWFsaXplIHRoZSBzY2hlZHVsZXIgdG8gYXQgbGVhc3Qgc29tZSByaW5nIHNv
IHRoYXQgd2UgYWx3YXlzDQo+ID4gICAgICAqIGhhdmUgYSBwb2ludGVyIHRvIGFkZXYuDQo+ID4g
QEAgLTEzOCw3ICsxNDksNyBAQCBpbnQgYW1kZ3B1X2pvYl9hbGxvY193aXRoX2liKHN0cnVjdA0K
PiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ICAgICBpZiAocikgew0KPiA+ICAgICAgICAgICAg
IGlmIChlbnRpdHkpDQo+ID4gICAgICAgICAgICAgICAgICAgICBkcm1fc2NoZWRfam9iX2NsZWFu
dXAoJigqam9iKS0+YmFzZSk7DQo+ID4gLSAgICAgICAgICAga2ZyZWUoKmpvYik7DQo+ID4gKyAg
ICAgICAgICAga21lbV9jYWNoZV9mcmVlKGFtZGdwdV9qb2Jfc2xhYiwgam9iKTsNCj4gPiAgICAg
fQ0KPiA+DQo+ID4gICAgIHJldHVybiByOw0KPiA+IEBAIC0xNzksNiArMTkwLDExIEBAIHZvaWQg
YW1kZ3B1X2pvYl9mcmVlX3Jlc291cmNlcyhzdHJ1Y3QNCj4gYW1kZ3B1X2pvYiAqam9iKQ0KPiA+
ICAgICAgICAgICAgIGFtZGdwdV9pYl9mcmVlKHJpbmctPmFkZXYsICZqb2ItPmlic1tpXSwgZik7
DQo+ID4gICB9DQo+ID4NCj4gPiArdm9pZCBhbWRncHVlX2pvYl9zbGFiX2Zpbmkodm9pZCkNCj4g
PiArew0KPiA+ICsgICBrbWVtX2NhY2hlX2Rlc3Ryb3koYW1kZ3B1X2pvYl9zbGFiKTsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyB2b2lkIGFtZGdwdV9qb2JfZnJlZV9jYihzdHJ1Y3QgZHJt
X3NjaGVkX2pvYiAqc19qb2IpDQo+ID4gICB7DQo+ID4gICAgIHN0cnVjdCBhbWRncHVfam9iICpq
b2IgPSB0b19hbWRncHVfam9iKHNfam9iKTsgQEAgLTE4OSw3ICsyMDUsNw0KPiBAQA0KPiA+IHN0
YXRpYyB2b2lkIGFtZGdwdV9qb2JfZnJlZV9jYihzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqc19qb2Ip
DQo+ID4NCj4gPiAgICAgLyogb25seSBwdXQgdGhlIGh3IGZlbmNlIGlmIGhhcyBlbWJlZGRlZCBm
ZW5jZSAqLw0KPiA+ICAgICBpZiAoIWpvYi0+aHdfZmVuY2Uub3BzKQ0KPiA+IC0gICAgICAgICAg
IGtmcmVlKGpvYik7DQo+ID4gKyAgICAgICAgICAga21lbV9jYWNoZV9mcmVlKGFtZGdwdV9qb2Jf
c2xhYiwgam9iKTsNCj4gPiAgICAgZWxzZQ0KPiA+ICAgICAgICAgICAgIGRtYV9mZW5jZV9wdXQo
JmpvYi0+aHdfZmVuY2UpOw0KPiA+ICAgfQ0KPiA+IEBAIC0yMjEsNyArMjM3LDcgQEAgdm9pZCBh
bWRncHVfam9iX2ZyZWUoc3RydWN0IGFtZGdwdV9qb2IgKmpvYikNCj4gPiAgICAgICAgICAgICBk
bWFfZmVuY2VfcHV0KGpvYi0+Z2FuZ19zdWJtaXQpOw0KPiA+DQo+ID4gICAgIGlmICgham9iLT5o
d19mZW5jZS5vcHMpDQo+ID4gLSAgICAgICAgICAga2ZyZWUoam9iKTsNCj4gPiArICAgICAgICAg
ICBrbWVtX2NhY2hlX2ZyZWUoYW1kZ3B1X2pvYl9zbGFiLCBqb2IpOw0KPiA+ICAgICBlbHNlDQo+
ID4gICAgICAgICAgICAgZG1hX2ZlbmNlX3B1dCgmam9iLT5od19mZW5jZSk7DQo+ID4gICB9DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuaA0K
PiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5oDQo+ID4gaW5kZXgg
YTk2M2EyNWRkZDYyLi40NDkxZDVmOWM3NGQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2pvYi5oDQo+ID4gQEAgLTEwMyw1ICsxMDMsNiBAQCBpbnQgYW1kZ3B1
X2pvYl9zdWJtaXRfZGlyZWN0KHN0cnVjdCBhbWRncHVfam9iDQo+ICpqb2IsIHN0cnVjdCBhbWRn
cHVfcmluZyAqcmluZywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRtYV9m
ZW5jZSAqKmZlbmNlKTsNCj4gPg0KPiA+ICAgdm9pZCBhbWRncHVfam9iX3N0b3BfYWxsX2pvYnNf
b25fc2NoZWQoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyDQo+ID4gKnNjaGVkKTsNCj4gPiArdm9p
ZCBhbWRncHVlX2pvYl9zbGFiX2Zpbmkodm9pZCk7DQo+ID4NCj4gPiAgICNlbmRpZg0KDQo=
