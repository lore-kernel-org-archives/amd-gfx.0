Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8178CCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 13:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A27710E457;
	Mon, 13 Oct 2025 13:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T1NvnEeM";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E823C10E450
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 13:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6B15xmWGicwgOwI/fXjlsL3NRXqRuK4falFf7KCWcnQRnKyAMsqCtrvlxv/QM0xWUjprZna6IJ3kUNontwEl4L5zBkbxPNoa384MY0r3WBYtWZoUsaLCMKbxbMGQotyoivBKCV4t6xlgmr8GvJyEElGeElIoi+sXBbBtK5NVuyu/ojQkipLazrYq/pnozPmw9R+GByztQUlCTYQCWoiS1KJx2+Q4EAn6wYiW7W90uXdBnhLno5RnxnJxTQczzEhCShk/aNeB3BTalpmb3XLhuFwRUTTZPic7pFYJps2mumTwHs3RZTDwamvjJne93GqzzY8yS4TSXsTNfxdWgKuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=251qyooi7xXHQO0EGcbyIrJYTo5zNtpM6gXwH9Fwbh0=;
 b=dNOhuX4LtWkRLQjMmUMqBjEhJvhbwh9dbwBlIk8Y8BaUD+FgvzvVI4N3t/GnivRP+oUDiG6OuefSb9sdoDwEFo0urC8RXl3Ht8beGmh4qLgWaY5YRaq3+sXU4AyyCeYGHbFBVBiWoTf9ex6m97zlTkN/R0uY+yKWH/tK48Kfrb73fp3cq+qNWuSa1qnRnw/JI0YXsvpqB1nbcb2ast0bbhDt2vAQls/lsC5xL8d4WniWJqyH6Y73DuJOTNCZ1097sAtiug0ktGJ5MWgJh6VEfdQcqG9QmDDgMpkWzMVix3u6gM6Ij3Zp3TYkAd5OY81IN0gTf3/r28taFYtCnU0k2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=251qyooi7xXHQO0EGcbyIrJYTo5zNtpM6gXwH9Fwbh0=;
 b=T1NvnEeMKe+W7LK7cd7fYfupIRw12jyNvQws1uzFh3Er68whFkJApuDgL/ItfiR/H3/8ST7G0spgFDn08COcfomKIHW1xLF2DgPuzvSn0qBmQU+v1J/4P631eJsGkazUq+G9mLEwnvIa28LVr3r8w++H42Ul+znZtGIhBZzRI3U=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Mon, 13 Oct 2025 13:59:20 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 13:59:20 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: Mario Limonciello <superm1@kernel.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Lee, Peyton"
 <Peyton.Lee@amd.com>, Sultan Alsawaf <sultan@kerneltoast.com>
Subject: RE: [PATCH v3] drm/amd: Check that VPE has reached DPM0 in idle
 handler
Thread-Topic: [PATCH v3] drm/amd: Check that VPE has reached DPM0 in idle
 handler
Thread-Index: AQHcO60F9n0wfVQ85EWxZQ7QWAPx2rS/g0GggACWGwCAAAGB8A==
Date: Mon, 13 Oct 2025 13:59:20 +0000
Message-ID: <DS0PR12MB7804BA493A16EFD092EB6A9897EAA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251012191823.856295-1-superm1@kernel.org>
 <DS0PR12MB78042769FD23A8C5346A561497EAA@DS0PR12MB7804.namprd12.prod.outlook.com>
 <46350316-9b32-4495-8e8c-c9672da34156@kernel.org>
In-Reply-To: <46350316-9b32-4495-8e8c-c9672da34156@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-13T13:56:00.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|MN2PR12MB4269:EE_
x-ms-office365-filtering-correlation-id: 7fe54a3f-94fb-4009-b3ee-08de0a60b50a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aW5WdlBMZ0VPeE1MT1VVYnV5OWFzcnJsb3o3ODFuZDFIMVVSNVo3SmVMOGo4?=
 =?utf-8?B?eVR4blRsOCtSNVFkdStEU1BKdVRoZXVER0tPRFU4ZXV1bDVTdzRLL21Fb3Z0?=
 =?utf-8?B?Y3NPNEJoZWNxL09CYlVaMXRXdTNVbXJTSXE5L2VrM1Z4Z0tUN21hQWx3d2pR?=
 =?utf-8?B?T0xrTUJlbW5HLzRsL205N2haTjI2aVYrL2JrL3hSNnhIVkdieWduVmluSXU0?=
 =?utf-8?B?Yms0Vzk0bCtNakdyK2NYNnRuOEJrUWJjS05DVTFYT0xNYVdYNXdUWkdzMkgz?=
 =?utf-8?B?SDFKVWYxVFJBOHBJbS9BekpLc3JzQWY5WmN6Vk1PV0ptZ3NqWWdsWis1U28r?=
 =?utf-8?B?RW1xTmdSdWRSS2R1ZmNnSmp3UFl3L25FbVFwejZ3MzZBTUM5eHlRUC9tQVA4?=
 =?utf-8?B?clNJcGc3YWRPUXQ1MmpXeXBmc0d0ZHVFWXg2UDh2Y1R4UkF5WUdPd0dhSzJN?=
 =?utf-8?B?dWVNMlJOU2tHVEVRb2ZJZ1FST0hIMEdMamd2ZzNnbmdvNDBjOTVyOUNvVkZt?=
 =?utf-8?B?UG90cFoybHVUQXdvb0dPRXkrTXloaUpXMEhQeTRLaVBhQ0lrTjZhWDJLeGpI?=
 =?utf-8?B?TUp3ejJVU01mY2lqMXdDazZIOEYvb3Q5ZGZSWVV5MENWQTZhQXBHWTYxTFJC?=
 =?utf-8?B?RGxaRWVsMm9MY1dZYlVSK2xwcVFlMGhqT1RBV3d2Rkt5RjUwMnNHWnUzbmNX?=
 =?utf-8?B?d2tYQUx6cHdrL3FsWklkZGtDQUNWS2Nlb24ydklDWm5kNEw4VDV6Z1doTVdT?=
 =?utf-8?B?bm1RaFFyYmJxWmNwWnZJRzZndEwwMVYzTkQ4UDNZOHdrbTVwY245dlJVaTVy?=
 =?utf-8?B?MWhKeVpyS05QbmJQdkltYWlNb05yNitkTE5jTDJEWjdNczEvNlk4WE4yT05n?=
 =?utf-8?B?VFNyRzhkQVVCTGF1Z1BzTGljbEhZclNRdFd1VzlLa2x3ZjA2RzF1Ti9xME1P?=
 =?utf-8?B?MFNFcGQyZGhqV1RpUVhPVTZNcm1hZFZnZm43ajFVQjFpU01URTlWa0hBK2Ra?=
 =?utf-8?B?UUttamlIdnVVUzdubGt6VWU1QlQ0MlFFZGZ4dVR6cTVUVjBlQVc5bnZDZFBG?=
 =?utf-8?B?WTY2T2Q0TWlITWZRUlNTZ2VzWDYzNTdQV0JjV29Zdm96bmRlVGdjWXo3TE9o?=
 =?utf-8?B?WVc5VEx1ZGNUUW5MU3JxMzhURWdmY1QzS0R4bEF6aGhuUTQ1MFRDdEZuSGdE?=
 =?utf-8?B?MDE5THRsKzBlSDROMUtDcGQ0Y1NleG1PYmlodU92OVZRRU5BcmZ0MzBMVXdX?=
 =?utf-8?B?a0pzZk1rN29hQlF2S1gxcDlsWjRseWdaRDc1cjArZzZKcTVHSkwxaVdMSFVC?=
 =?utf-8?B?cEJCTDhTMEFxRFJsNFd3TzFzaHNUV25sMlVSOTVTc2d1aGVrcVNvNFBmOGxG?=
 =?utf-8?B?VUhvT1g0aE5wazBUTm1ybGJMMVBXK1lRT1hHeFBLRzhPQjhITndmeVhma2RO?=
 =?utf-8?B?UXptd1R2RlU0bDE2N1dCTWVTNGg1RnM1N1ZORXFvWi80R3VQSXhlTERPcGJk?=
 =?utf-8?B?aG1LclY2MXN2Zkl6Z3JrQUFnam9DcXE4ZnpLMFZ6QTR4R1REVU1HWFAzWjZM?=
 =?utf-8?B?M3JuMUE4V1hCM3Vwb0Q5Z2d0dEdMK3V0dlNyd3ZBUDA5elBkOEhMTDU3Sklw?=
 =?utf-8?B?eVFCSnB2SllSTlNiS1JaYmI5dmpMdDNLWk94NGdKWDI1Q0c1MU4rVXJhL0VZ?=
 =?utf-8?B?ZitOaVRiaGxyazVFaWYxSFlKZHNoVkNJbitCcWRiUTBYWFhqNzQrdnMxUGM2?=
 =?utf-8?B?QzV2amMva3lobUx0TnVaVFg0RVZlbk9OM0pjS3BvMnY2ZnNtZ3VnOWdxY2xz?=
 =?utf-8?B?UWJVR3BmNFdaUTRFUDNCMFFzMW1GeTVCOEZ0NTkvWGlGdjJQdDlHYUZSWjhW?=
 =?utf-8?B?TWVrZng4R2RBZ1IyYXdRanZ3MFFsQzdPQzZYQkhEdUR4YVhZc1VTdWZxSWQx?=
 =?utf-8?Q?HPQMQqB4det83sYzWVTMf4+jaJnDJx6O?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Smh1NnpBSTZqNVFvQ3RpR2JNdjFuR1NFczFlSW1BYVZ0RXdOYTlydzd5NjBy?=
 =?utf-8?B?WHAyaDZVS1RvamxaYTZJY2s0ajQvaHpYN3FDTHJmRUM5M2o4QU1tMTFUUjhv?=
 =?utf-8?B?cHY0THVZd3IreTJ2YzhBUTJjVnZrYXcvV2pqVml4a2MzQlpvZExrZVBJa1lN?=
 =?utf-8?B?SXZIeFR6bERUOU5YdXN1bmozclB3ZmdkVWRUQkJPZzVESDAwSTcrdC9PN0R0?=
 =?utf-8?B?UWx6T0cvVFRqcFI3WmpOeDhrT2dBODNlRWprWEdVUUdheFp6dVFLZFZHcUtT?=
 =?utf-8?B?L3ZKaTUzNm1mbStkWGJyVXhoejZkQ1RqMUJDbEdadllva3VkUHhoYU8wbHBL?=
 =?utf-8?B?OFRQTGR2aEJxOGZIZGZQYXU2RXRtaXNXVmlkNVNaamk3QmVuN0k5ZzRUays5?=
 =?utf-8?B?SWpoUU5GOFNHR1NHU0N6V204T0Uwc2wzbTdkTUJhelIrdnhrUDhXUjloc21M?=
 =?utf-8?B?QkY0Z1ZYNHNjaENxOXdKZVNNNXVlZVJVcHhhV1N3LzloTkNiNmtCaHFHSFRB?=
 =?utf-8?B?dWpaTjlOUFdOT2ZNWVphZkF3aUZIaDBiWWVuWjk5Y3lyWHdjcm1PajNpZkJY?=
 =?utf-8?B?Z3ZELzJDVHVPYklDUCsrclViL2ZNZmJweGZ0dTQvNVBtTUNhMzZraFB6T3ll?=
 =?utf-8?B?OUtCUVBzV3J6dnZ4ZU96R1QzNHlLa2RjMG1IQUNkRlhEL0hxZmNpeFd3MExY?=
 =?utf-8?B?LzJsTzAvODhQVEc5K21OR0pYaUhNK1ZVdWtTOWtYbU5lWWpvS05GRzdvRDZu?=
 =?utf-8?B?T21URVhxa2NlNThpdzY2VVEwRlUzWU9FSEZwNzk2TXEyY3FWb1djUVQ4a0U0?=
 =?utf-8?B?SkJoL09xc2ZBM09oVmtlVFpOdmQvSGcwQlZ4U2V0R2EvM1Uza1Z5THQ4ZWFM?=
 =?utf-8?B?T21nenhvRHc5akFPVEpGL05BUTFhN04zRHdJUlRKdHVZMXRzRnhJTGNEakFx?=
 =?utf-8?B?WDcrNk5XZ000dy90WHArUEYxTDg5d1Fsc0x6aVByQnhoZ3VNV2dWMWdGZ005?=
 =?utf-8?B?aGhuZldzRlFiVk1MSE1VTDRSeE1OMUNTVUJudi9GSVo2RE1VaUs4a0ZsQ2RP?=
 =?utf-8?B?dysySml4UGdZNXY2S0dIWEh5UFQ3R2pHUEhQbzJmWktmVHYyYlFFT1M1YlJR?=
 =?utf-8?B?K0ZQZlJxVmVwSXlkQ00zY2FiQTBLYUxlcFo1TU1nSjJQMzBUdGg1NjV3eTlW?=
 =?utf-8?B?L1QrSXQ0Zm9IRlBPSExac0JoWmdqWTlSTk4zdVZXTTk1ZWxLM0ttUVpDS09Q?=
 =?utf-8?B?WHNTZHhTTmtYaDhNNVFyLy85a3doL0doYmpnd0VDM2FjQ2tFVHhmNzVOS0pE?=
 =?utf-8?B?VmppWmtPWStyZ1ZQRmpjOU5yZE80YitWblBoT3JKcWYvamFJOCtVa2hKQWFw?=
 =?utf-8?B?VDIweFg0Z3paSUJtSjZMVWpFWkIwRVpXb3RkR2oxM1NZc1JxUSsvTUVvQVgx?=
 =?utf-8?B?ZnhUN1prMGRnQUpTR1lpcDBDak9JdC9QWDlqbHJtMHZBSy9NN0V5R0pxc29Q?=
 =?utf-8?B?em8zSjFSeGl4ZFJEQ0FwZTdseVE2TkZBOHJrK1RCU2ZzS3RFd3VXalQyQ0N4?=
 =?utf-8?B?dmZjSUFqYUkvSWVRdW42aXdySlpURnBjbTJHR3hVS1JNNXVrVEVKL25ENjcx?=
 =?utf-8?B?aVRiNkUzclRMYmI0dUNmSUVOcHZrS3ZwelBLVVMxNXRxWE0wVWpaRy9TUDd2?=
 =?utf-8?B?S1VJWjJWbGt3QldvSlRueHFtZDNzS2RiMlJqM1NkNVFWM2hwSXhaU2NuSzFZ?=
 =?utf-8?B?b3FvNEViTHpwU3VHV29FTitVMVpSWWVyQVQxTGFIYWs1N0pFNW1uUUt2aHlS?=
 =?utf-8?B?K29kRmZHSHMzcm5kaDFzMGlhU0E4aHBFU0hhZUgxSHV1ZTU0UjA1a1F5NHVV?=
 =?utf-8?B?SWJtNzI4RGx6bS9oQzZGVDY4KzJwOVdLbnkzTElYQm9CY21kVS9UZk9NSjJG?=
 =?utf-8?B?cHFIU3FUbnVmNVhoT3FaWXhjSDdNTnlNeS85ajB2cmVjQ1owS2Irc1BidEIw?=
 =?utf-8?B?bHVPYlhEV2NOdklZeDE2d0N2VHFyMWgxY2lKa21ndktDbmVxS0NSN0VCcm9m?=
 =?utf-8?B?M0NFZGpPUjFDSXduQkpVdmpQSFUwVFJ0MWZqQmhMenJNQjRXcU5FVHdLQkFB?=
 =?utf-8?Q?jhmY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe54a3f-94fb-4009-b3ee-08de0a60b50a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 13:59:20.3674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0a/Fo/mkdwia/0ErIJ0wbX5czbcU1wOok5vc0YRgY0KUJOErliWnRhYC698j+5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTWFyaW8gTGltb25jaWVsbG8g
PHN1cGVybTFAa2VybmVsLm9yZz4NCj5TZW50OiBNb25kYXksIE9jdG9iZXIgMTMsIDIwMjUgNzoy
MSBQTQ0KPlRvOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj5DYzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNp
ZWxsb0BhbWQuY29tPjsgTGVlLCBQZXl0b24NCj48UGV5dG9uLkxlZUBhbWQuY29tPjsgU3VsdGFu
IEFsc2F3YWYgPHN1bHRhbkBrZXJuZWx0b2FzdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2
M10gZHJtL2FtZDogQ2hlY2sgdGhhdCBWUEUgaGFzIHJlYWNoZWQgRFBNMCBpbiBpZGxlDQo+aGFu
ZGxlcg0KPg0KPk9uIDEwLzEyLzI1IDExOjU0IFBNLCBMYXphciwgTGlqbyB3cm90ZToNCj4+IFtQ
dWJsaWNdDQo+Pg0KPj4gRG9lc24ndCB0aGlzIHRyYW5zbGF0ZSB0byBqdXN0IGEgaGlnaGVyIGlk
bGUgdGltZW91dCAoVlBFX0lETEVfVElNRU9VVCApIGZvcg0KPnRoZSBwYXJ0aWN1bGFyIFZQRSB2
ZXJzaW9uPw0KPj4NCj4+IFRoYW5rcywNCj4+IExpam8NCj4NCj5ZZXMgaWYgdGhlIFZQRSBtaWNy
b2NvZGUgYWRqdXN0cyBEUE0gYXQgcnVudGltZSB0aGlzIG1ha2VzIHN1cmUgdGhhdCBpdCBoYXMN
Cj5zZXR0bGVkIHdoZW4gd29ya2xvYWQgaXMgY29tcGxldGUuDQo+DQo+SSBleHBlY3QgdGhhdCBh
IGhpZ2hlciBWUEVfSURMRV9USU1FT1VUIHdvdWxkIHdvcmsgdG9vLCBidXQgaXQgc2VlbXMgbGVz
cw0KPnNjYWxhYmxlIHRvIG1lLg0KPg0KW2xpam9dDQoNCkkgZ3Vlc3MgVlBFIGZpcm13YXJlIGJl
aGF2aW9yIGNvdWxkIHZhcnkgYWNyb3NzIGdlbmVyYXRpb25zLiBGb3IgZXg6IGV2ZW4gaWYgaXQg
ZG9lc24ndCBsb3dlciB0aGUgY2xvY2tzIGluIHRoaXMgZ2VuZXJhdGlvbiwgaXQgY291bGQgZG8g
c28gYWZ0ZXIgc2VlaW5nIGEgcG93ZXIgZ2F0ZSAoYW55IGhhbmRzaGFrZSB3aXRoIFBNRlcpLiBP
ciwgZXZlbiBpZiBpdCBkb2Vzbid0IGxvd2VyIHRoZSBjbG9jaywgaXQgbWF5IGFkanVzdCB0aGUg
Y2xvY2tzIGFmdGVyIHBvd2VyaW5nIHVwLg0KDQpTbyBwcm9iYWJseSBqdXN0IGtlZXBpbmcgdnBl
LmlkbGVfdGltZW91dCBhcyBhIHZhcmlhYmxlIGJhc2VkIG9uIElQIHZlcnNpb24gbWF5IGJlIGdv
b2QgZW5vdWdoIGZvciB0aGUgY3VycmVudCBpc3N1ZS4NCg0KVGhhbmtzLA0KTGlqbw0KDQo+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJv
dW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4+PiBNYXJpbyBMaW1v
bmNpZWxsbyAoQU1EKQ0KPj4+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxMywgMjAyNSAxMjo0OCBB
TQ0KPj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4+IENjOiBMaW1vbmNp
ZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBMZWUsIFBleXRvbg0KPj4+
IDxQZXl0b24uTGVlQGFtZC5jb20+OyBTdWx0YW4gQWxzYXdhZiA8c3VsdGFuQGtlcm5lbHRvYXN0
LmNvbT4NCj4+PiBTdWJqZWN0OiBbUEFUQ0ggdjNdIGRybS9hbWQ6IENoZWNrIHRoYXQgVlBFIGhh
cyByZWFjaGVkIERQTTAgaW4gaWRsZQ0KPj4+IGhhbmRsZXINCj4+Pg0KPj4+IEZyb206IE1hcmlv
IExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPj4+DQo+Pj4gW1doeV0N
Cj4+PiBOZXdlciBWUEUgbWljcm9jb2RlIGhhcyBmdW5jdGlvbmFsaXR5IHRoYXQgd2lsbCBkZWNy
ZWFzZSBEUE0gbGV2ZWwNCj4+PiBvbmx5IHdoZW4gYSB3b3JrbG9hZCBoYXMgcnVuIGZvciAyIG9y
IG1vcmUgc2Vjb25kcy4gIElmIFZQRSBpcyB0dXJuZWQNCj4+PiBvZmYgYmVmb3JlIHRoaXMgRFBN
IGRlY3JlYXNlLCB0aGUgU09DIGNhbiBnZXQgc3R1Y2sgd2l0aCBhIGhpZ2hlciBEUE0gbGV2ZWwu
DQo+Pj4NCj4+PiBUaGlzIGNhbiBoYXBwZW4gZnJvbSBhbWRncHUncyByaW5nIGJ1ZmZlciB0ZXN0
IGJlY2F1c2UgaXQncyBhIHNob3J0DQo+Pj4gcXVpY2sgd29ya2xvYWQgZm9yIFZQRSBhbmQgVlBF
IGlzIHR1cm5lZCBvZmYgYWZ0ZXIgMXMuDQo+Pj4NCj4+PiBbSG93XQ0KPj4+IEluIGlkbGUgaGFu
ZGxlciBiZXNpZGVzIGNoZWNraW5nIGZlbmNlcyBhcmUgZHJhaW5lZCBjaGVjayB0aGF0IFZQRQ0K
Pj4+IERQTSBsZXZlbCBpcyByZWFsbHkgaXMgYXQgRFBNMC4gSWYgbm90LCBzY2hlZHVsZSBkZWxh
eWVkIHdvcmsgYWdhaW4gdW50aWwgaXQgaXMuDQo+Pj4NCj4+PiBDYzogUGV5dG9uLkxlZUBhbWQu
Y29tDQo+Pj4gUmVwb3J0ZWQtYnk6IFN1bHRhbiBBbHNhd2FmIDxzdWx0YW5Aa2VybmVsdG9hc3Qu
Y29tPg0KPj4+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQv
LS9pc3N1ZXMvNDYxNQ0KPj4+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJp
by5saW1vbmNpZWxsb0BhbWQuY29tPg0KPj4+IC0tLQ0KPj4+IHYzOg0KPj4+ICogVXNlIGxhYmVs
IHRvIGF2b2lkIGEgcmVnaXN0ZXIgcmVhZCBpZiBmZW5jZXMgYWN0aXZlDQo+Pj4gLS0tDQo+Pj4g
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZwZS5jIHwgMTUgKysrKysrKysrKysr
LS0tDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZwZS5jDQo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnBlLmMNCj4+
PiBpbmRleCA0NzRiZmUzNmMwYzJmLi5lOGU1MTJkZTU5OTJhIDEwMDY0NA0KPj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cGUuYw0KPj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cGUuYw0KPj4+IEBAIC0zMjYsMTQgKzMyNiwyMyBA
QCBzdGF0aWMgdm9pZCB2cGVfaWRsZV93b3JrX2hhbmRsZXIoc3RydWN0DQo+Pj4gd29ya19zdHJ1
Y3QgKndvcmspICB7DQo+Pj4gICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0NCj4+
PiAgICAgICAgICAgICAgICBjb250YWluZXJfb2Yod29yaywgc3RydWN0IGFtZGdwdV9kZXZpY2Us
DQo+Pj4gdnBlLmlkbGVfd29yay53b3JrKTsNCj4+PiArICAgICAgc3RydWN0IGFtZGdwdV92cGUg
KnZwZSA9ICZhZGV2LT52cGU7DQo+Pj4gICAgICAgIHVuc2lnbmVkIGludCBmZW5jZXMgPSAwOw0K
Pj4+ICsgICAgICB1aW50MzJfdCBkcG1fbGV2ZWw7DQo+Pj4NCj4+PiAgICAgICAgZmVuY2VzICs9
IGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZhZGV2LT52cGUucmluZyk7DQo+Pj4gKyAgICAg
IGlmIChmZW5jZXMpDQo+Pj4gKyAgICAgICAgICAgICAgZ290byByZXNjaGVkdWxlOw0KPj4+DQo+
Pj4gLSAgICAgIGlmIChmZW5jZXMgPT0gMCkNCj4+PiArICAgICAgZHBtX2xldmVsID0gYWRldi0+
cG0uZHBtX2VuYWJsZWQgPw0KPj4+ICsgICAgICAgICAgICAgICAgICBSUkVHMzIodnBlX2dldF9y
ZWdfb2Zmc2V0KHZwZSwgMCwgdnBlLQ0KPj4+PiByZWdzLmRwbV9yZXF1ZXN0X2x2KSkgOiAwOw0K
Pj4+ICsgICAgICBpZiAoIWRwbV9sZXZlbCkgew0KPj4+ICAgICAgICAgICAgICAgIGFtZGdwdV9k
ZXZpY2VfaXBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsDQo+Pj4gQU1EX0lQX0JMT0NLX1RZ
UEVfVlBFLCBBTURfUEdfU1RBVEVfR0FURSk7DQo+Pj4gLSAgICAgIGVsc2UNCj4+PiAtICAgICAg
ICAgICAgICBzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmFkZXYtPnZwZS5pZGxlX3dvcmssDQo+Pj4g
VlBFX0lETEVfVElNRU9VVCk7DQo+Pj4gKyAgICAgICAgICAgICAgcmV0dXJuOw0KPj4+ICsgICAg
ICB9DQo+Pj4gKw0KPj4+ICtyZXNjaGVkdWxlOg0KPj4+ICsgICAgICBzY2hlZHVsZV9kZWxheWVk
X3dvcmsoJmFkZXYtPnZwZS5pZGxlX3dvcmssIFZQRV9JRExFX1RJTUVPVVQpOw0KPj4+IH0NCj4+
Pg0KPj4+IHN0YXRpYyBpbnQgdnBlX2NvbW1vbl9pbml0KHN0cnVjdCBhbWRncHVfdnBlICp2cGUp
DQo+Pj4gLS0NCj4+PiAyLjQzLjANCj4+DQoNCg==
