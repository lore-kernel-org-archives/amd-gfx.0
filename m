Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080DAC02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 14:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6E810EB1A;
	Fri,  7 Feb 2025 14:21:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yq04ghFf";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B18810EB0E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 14:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l01ZxGogFUlft50O9fmqQZzXr5ABwcHvH+a/JrOcPfmHHQWn8GGnSwsZ7QMiFB07z+UNmph+zt0wnCPz4VMQZanrhYrA5kU8Zst43NEE2RkWIJJdhfAVt0ufSSl0aolRWR6j+dHPK4yqU+v4PVsdJjP68S40fC+zDDTgZFRjxwsKBdkExBrU3Dq5ZZHmzZAM5A21tRPuyNz//M7LRTMZdX1PDKB/frkSO5sCXTFIA2M6MUCtuRocJNjxqTntmtyNiNkALTiw+TUGl+5sLvb8jsROj0QihkHkLtNBZG0lguAB1B8DoTla2KEfjL64XOuSgDApRAERIqstvUXk3xMwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YX1TFsaiXuiMYDnLRc/dHsY7mai4CcFCsHnlLxErF7Q=;
 b=kcg2prih60Okr4ylme9hxWyGmImLAdq3YbYl6FiHFtZpze94QMrEnArvIejYCSCChLttxq/JYfccED2iAdqjj3Uiy8jsVonKjaAR3fNEvQ+6A/4Akq39EoGfxdjJgCyLK0wHwg8mgnRZXkrIRLS5GGRSJ57nesi1bOY+XHATB85Wb0+j4aZuUL/ANDhnTon2oD0FUH6XlXSzt2e8z+CwAvTzhQrrhY9JgIIsxog3wLcfz8BlnLC5XJCCcKUH76n3QdnpZXeUdnJz+QQCisl+mqFxqXK7KT/sl9QOgTQ8a0Qiswxg3b5gEivsvdCrS/2jnDmXqiWUAjuz5IWq4FjSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX1TFsaiXuiMYDnLRc/dHsY7mai4CcFCsHnlLxErF7Q=;
 b=Yq04ghFf3y8vmF6FWBf68rjb2qoPCA04+9jaAGQKmYTjX9XwVb9pKApjgqjMmxc8/9T3+YK0JMBqH/Wz9385VFz9o7I68/NCOTzFuoHjh4UV9Zu5LH7Bd8ngiwaKbKT9ZkAwtQHR0RZ8Rq848FIly5KPIHTFRuiEDxZxdjKexRI=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 14:20:32 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 14:20:32 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/4] drm/amdgpu: Add xgmi speed/width related info
Thread-Topic: [PATCH 2/4] drm/amdgpu: Add xgmi speed/width related info
Thread-Index: AQHbeJjqEAQYK3gZHESFnP5YTVHCkbM66RyQgABMvgCAAKq5oA==
Date: Fri, 7 Feb 2025 14:20:32 +0000
Message-ID: <CY8PR12MB7435FC10089643A47B4AD02F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-2-lijo.lazar@amd.com>
 <CY8PR12MB74358ACE4AA9BA563D3219E985F62@CY8PR12MB7435.namprd12.prod.outlook.com>
 <19728543-a606-41bc-b4fd-464b7a1d7a94@amd.com>
In-Reply-To: <19728543-a606-41bc-b4fd-464b7a1d7a94@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=3bee01bb-422d-4329-b176-b26a47bbe162;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-07T14:14:02Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SN7PR12MB7131:EE_
x-ms-office365-filtering-correlation-id: ef77355e-5943-47bf-a212-08dd478294b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MUo0KzdVM0Rlenk2d2xjYy9kdnZweFVSeHhGckNRNkx3aTZKMGVUR2NtekdC?=
 =?utf-8?B?bXNsOEhXMDdzZDUySmtvSGdNYnVnREM5ZWRiS1lRaTFGRWRpT0Y0UEZmZTF2?=
 =?utf-8?B?ZEV5em9weERJRFZXOVhyNzBhdWRCM2oyOWRYWC80anF3eTB0QUcvc1VVcmlU?=
 =?utf-8?B?T2Y2Yit5dzBJNTB1ZVN1aFd5Q0o1c0Faakl5dmNsRm9GR3NSUkR3SjF5SC85?=
 =?utf-8?B?NnE5TjRIQURDRWgxaTNpK2lYc2dQQ2REaWNxenQvZzRZL3M4T1RUMjNKT01K?=
 =?utf-8?B?dlhnREZhUWgvNC9mRDJiZ1VvWGxPTjZ3dXcwSCt4MEhWL3l0Qm9NYmsyaWp2?=
 =?utf-8?B?WlZBNFBHcG15Z1YzTElSeHlydTAxZ3FiS2J2dE1vVDJ5WjBRNVd6TEVmaXVU?=
 =?utf-8?B?MFJDeDZiekpBcjJEcHF1UXRCWWdGd3EyeFgyZGFhNDI2bVRUT1lISksvZ2o5?=
 =?utf-8?B?OVd5em5VeWRMRjYrT1pKQ3VNMHN1S1hDZ2NWRCtwSXZqaDVKUnZ2K3BWTFh0?=
 =?utf-8?B?OUU1N1FkejNvcnFVWGpMSG9rbVlDdWNkaXR6RVpLbTM0S0ZYL3c0NDUyQjBN?=
 =?utf-8?B?VWF2MlVWNDhGTzhRLytQT3FGTGlyREk3WmJqOEFPOEtXWHB6MjloYy9XYmVG?=
 =?utf-8?B?aENKYU1oUG9tbFZkR2tUcnNVSlpzaXVQUEZNSGUxQ09rUTFXVUZFMVJKNmxY?=
 =?utf-8?B?MEVjQnhlYTRCYkU3Uk9naWwxWGo1MDl6Uk8zN0x2QTFYZmpMQThPQ1BVcGpP?=
 =?utf-8?B?Mm85cHFWWVNvY2xmTnZub01lcjFUVW9tN2hpbUVaNVJYUVpYRVZ3NW9uUkQv?=
 =?utf-8?B?c2MwTy9qcjJZc0h2dnhoWlBDTDdmT250V1hhZmRwbUN0Mnc3Wkl6OC9UY0ZZ?=
 =?utf-8?B?Mk9PTU41T0ZqTDZQOHBKN2ZMeUhlYXJia2kwemMxcG0zV0NYNDhwUGhMTmx4?=
 =?utf-8?B?OXJ1L0E0d3gyUkx2Vi8vRzJ2NVJ6SDRoOWtCQlAxNnNkZW9JaWoreWFyc0pF?=
 =?utf-8?B?Z2tHQ3JmYXpweGtsbms1Si9KMXJCZ1FCeFVrQmFuRkE4Njg5NWp1Y3pCbkl3?=
 =?utf-8?B?Zm45UEJYTEx5S1ppTlpoemxacTZQOXZ0aWdnMVh3ZzhTNzNuK2IwUTFHMUl6?=
 =?utf-8?B?UUZDcXBLVEpWczVRcUNEaDBkbjdHQm5oUEhVb0hYQTAzSFMwWGVHWjU3bUhj?=
 =?utf-8?B?YXhPK1JScGZkOVhad3d0Q0tJc0g0SGJHbWJwbzNsY2RoK3hDYWRDZDNJNFFI?=
 =?utf-8?B?ZUpNSndxQ0JvdTd3ZjZwWGN0dmd0a2gxaWpXUDhSdGdieGJ5ZURwQTNZbFZv?=
 =?utf-8?B?cjQ4aFF5TWdGWFEwNnozVVlLT3BhWFFLRTVQNGFVZTZxQzlxWmhJOVhtRjhl?=
 =?utf-8?B?UmNJTTVHck04djlHdHFZOW5FcWJYOWMrajZMRUE0ZHNDMUVKcWEyN1ZnRnQ2?=
 =?utf-8?B?VXVHanBtU0JEaTZQQS9nU2lZYmgyc2NoRXBLWFhObHVGRVdVWlRrV2pFY3Jz?=
 =?utf-8?B?SkVSMjlHc1NFdVBNaHQ3VnAyVU1Gak9tZEt6OUhyWERtLzFrd3NvV1c2ZE40?=
 =?utf-8?B?SGVPU0kyUUgrZ3ptaFBxb2F4U2pocGtmcHp5T1hsT2dBczZ2c3J4QXpCeFNC?=
 =?utf-8?B?dEwwckxtS000QnVYd3FwbFZHWXN4Ulp6bGdFRnVDZ2xjdytrWWQvak1PTGYz?=
 =?utf-8?B?MmRWeks1Wnc5Q29mcUtPVVc1dXFOMG9DM1BPWmliRlFDcS9reWtkRGt6Sktt?=
 =?utf-8?B?YktQQWhscUE1aDZqejFEam9LQXVOd3pRQ1Y5YjYxY2ZGU2gvc1dtaDNJeUNu?=
 =?utf-8?B?YkNudFlEdnAvVmxMdDg1VDJVRnZUY25FZXJnUVhmT3hKYVZPbytlSzFCVUp1?=
 =?utf-8?B?Q3VWZkIwWmRQaFdMRzUzU2tiL1d5dFlsSTBWUDNnanJoaVhNMU5oR1ltZnN3?=
 =?utf-8?Q?6THZ9ibBWDNfqSG33Dzs0Rgi3Mf0NxaC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk1iOUI4Ny9WU3liOGxnRTRaKy90eUVEZk4ySnhNVmIyWG80YjdCTTUwM2Fp?=
 =?utf-8?B?VEkyYTZQcGRML09lUE5LMVRuRVpoRlFQMDBadjAydG0zTDNkK2JhZlNrV1BJ?=
 =?utf-8?B?d1NrZVVNU1djT3BwdkpWMHRURE5lZ3Nqb0M1WjZEM2lGODBlN29oWjl3ZGNU?=
 =?utf-8?B?OUhMZDgyV3R0VWgrTmhBRjdRWUwzbms3YVJQM2hjNjI4TEtWWHF4Vk9YNFJw?=
 =?utf-8?B?RXJSOFMrdUd4elJUa0lnQ1dUbXhoSWthQzRBRmxScXdPUjdISnFjODg3T3h1?=
 =?utf-8?B?TFQxQmN6RW5PbmJLZlNFZHF2RGt0L2JXZ21sbzB0V2pCdHNQOUdzNldzbUxs?=
 =?utf-8?B?R1ZqNFZ5TGpqZll3SFRwdXA4VFZZdGR1aGFrK1AzWFkzQ21DY0JRaklFcUcy?=
 =?utf-8?B?SXZjbHJFdGJBcG1PZzg4OVJrYnVlOEZUbytVUjNxT3BoanArN0xGWkFHeDYx?=
 =?utf-8?B?WXNRV0NXSFdGY0NEVFlOVGloK0g5QUQweW5rNHgzRkd4eE13UDNQUHoybjZv?=
 =?utf-8?B?SFFVb1BpT1ozcE5jdkZsT0UzbzNKVkVHSndxdHBRemQzZnZkc0ZNZ0xWY0Fv?=
 =?utf-8?B?d2wvdFgxNjBydGw1WGJjUHVpeWdiY1hRR2ZnRmtqajBsc0hEcWh5MWg3MlM2?=
 =?utf-8?B?L3M0V0MvcHB6c1c5aHU2YUREVncrMHppSWdiems2MjZkUnV6cmdyLzA3eFMz?=
 =?utf-8?B?VFhKNTFVcFVFVXcxcnJ5VWp2SEp3ZzRTSUF3OUVDZUxMZ21DeHQrSnhPL1JK?=
 =?utf-8?B?MFRPRTByL1l3QnZmdWRDTVlsWXBnSHFXNXFWZDF2bVpHc2lUSSsyeEI0T3ZS?=
 =?utf-8?B?TVV4a2xGWHdQUE0xelVnNkVJYnc0OHptVW16UmVJbmt6cEtQK1FQUGUydlEw?=
 =?utf-8?B?QXdCc3cvS1gxdXNXUWRJNkhhcHRKMGUwSnI1eWVVQVZiVXZsTUl1ZWNtcXJT?=
 =?utf-8?B?Smtla2RRdnIvNkltWUtTSUY2Yk5aRUw5N1k1L0tyems0MTFBR2Z1dVNORTFL?=
 =?utf-8?B?WVVSdlFlRlhHMVphTHNRMGVRa0hZQVpRVk5HSzl6TWR0TEw0VTJFK1FYTEpu?=
 =?utf-8?B?SzdJajJWREFrSXRLN2IxeHpQZm1CRkRRRk1qakRqazU2ZjZaV1M3Y1hYOS9n?=
 =?utf-8?B?c1AwZUx4TzBGRUZ2d1dDVHdLdFE0bEFrTWNsTHlQeUI5QTRhU2poQzhwWFlz?=
 =?utf-8?B?enZianNPblA2MWViNis4bUttV3NwejRXcHJEcmNjT1gyOEV5YUJPUVl4dVlY?=
 =?utf-8?B?eXNRcWJ3VEZjNTBBU1BCUk83bEluRTc0RE0wcGV4bk52dVJ4R2ZHUERFY1V1?=
 =?utf-8?B?MXJET3dyWnhRYU9uQkRHVnFaOUFhMExxaUc4emJ0cFVsTXFBRnUzS2FveDh3?=
 =?utf-8?B?M1M2bWJjQ2hWQnJUOU9QUHNFbXZaempFYTQ3T2pxbklmTDBma3ZrK0luVTlZ?=
 =?utf-8?B?bklzUEVkRThrY0E3S2d6eUk0MjBOLzlVcmhvWWhzVzZ6NE1Tcy9IZUU4Qk43?=
 =?utf-8?B?eHFQTU5UdmlJWWVGeURYK3VqWm9paUorMldrWVhSS0lPcUY4cjlEWTAxVURh?=
 =?utf-8?B?aE9ZZmpJK0wrOUhMNk5FUjJOU0UyR28yR3hUVmxrcmJkemltN0MwaTE1dkpT?=
 =?utf-8?B?SVR5dkk1NTd4SXZiRmhyTzd1aWVJMHFNNEEwVjVUZWVHNDU5R010dkZEcms0?=
 =?utf-8?B?SVZCR0RGUmdlcVl0ME9yVXN6VWN2c2Zud3p2Mm5zb0xaTU51S1N4MmtXc0VP?=
 =?utf-8?B?UW9URmtGUlljR3hQRnhmVmhVdTVJMjI3RGpXajNKT0lIOGF2cmZLT2VVQjBm?=
 =?utf-8?B?VzBCaUQ5NXkrRUQwamtBbDNKUEtjTUNOdHVESzh3YUYzWTlLOWFlQUw0YmN5?=
 =?utf-8?B?cVExajBmSDUzdG1peW9seDV0SWEzWW1oV00zaFJwVnFJcEpJaGhMVFNuOUVz?=
 =?utf-8?B?czJYL1VqOFJZTHNmNVQxUnBHQ2JyRTJhSHRxcmNqWnNNNDl0NCtGT0JZSEl1?=
 =?utf-8?B?cVJjaVAyTUlwMXVMVnFUdjBKWG1qeGJ5NDk1Zko0c0V0M1FBbk1GNVRTVGtr?=
 =?utf-8?B?YzJBS0ZoS3hZZHlGUnlxZE1YVUZ3QXZkdTU4SUs3V2lIOUNtcjNrRW11aERv?=
 =?utf-8?Q?eVAw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef77355e-5943-47bf-a212-08dd478294b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 14:20:32.2486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0mVaj+JqR0Vg/g5lX+6k5ym85mFrylAEcKYvvWDZvZ7P5Mj72K3Wfo91DHjddsq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgNiwg
MjAyNSAxMDo1MSBQTQ0KPiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+
OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogWmhhbmcsIEhhd2tpbmcgPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzRdIGRybS9hbWRn
cHU6IEFkZCB4Z21pIHNwZWVkL3dpZHRoIHJlbGF0ZWQgaW5mbw0KPg0KPg0KPg0KPiBPbiAyLzcv
MjAyNSA0OjU2IEFNLCBLaW0sIEpvbmF0aGFuIHdyb3RlOg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4g
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTGF6YXIsIExpam8gPExp
am8uTGF6YXJAYW1kLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDYsIDIwMjUg
ODoxMyBBTQ0KPiA+PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExhemFyLCBM
aWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+ID4+IENjOiBaaGFuZywgSGF3a2luZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPjsgS2ltLCBKb25hdGhhbg0KPiA+PiA8Sm9uYXRoYW4uS2ltQGFtZC5j
b20+DQo+ID4+IFN1YmplY3Q6IFtQQVRDSCAyLzRdIGRybS9hbWRncHU6IEFkZCB4Z21pIHNwZWVk
L3dpZHRoIHJlbGF0ZWQgaW5mbw0KPiA+Pg0KPiA+PiBBZGQgQVBJcyB0byBpbml0aWFsaXplIFhH
TUkgc3BlZWQsIHdpZHRoIGRldGFpbHMgYW5kIGdldCB0byBtYXgNCj4gPj4gYmFuZHdpZHRoIHN1
cHBvcnRlZC4gSXQgaXMgYXNzdW1lZCB0aGF0IGEgZGV2aWNlIG9ubHkgc3VwcG9ydHMgc2FtZQ0K
PiA+PiBnZW5lcmF0aW9uIG9mIFhHTUkgbGlua3Mgd2l0aCB1bmlmb3JtIHdpZHRoLg0KPiA+Pg0K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQo+ID4+
IC0tLQ0KPiA+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYyB8IDQx
DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3hnbWkuaCB8IDExICsrKysrKysNCj4gPj4gIDIgZmlsZXMgY2hhbmdlZCwg
NTIgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYw0KPiA+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV94Z21pLmMNCj4gPj4gaW5kZXggMDNkOTA5YzdiMTRiLi5lZGVmNTc2M2UyYjgg
MTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21p
LmMNCj4gPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYw0K
PiA+PiBAQCAtMTY3OSwzICsxNjc5LDQ0IEBAIGJvb2wgYW1kZ3B1X3hnbWlfc2FtZV9oaXZlKHN0
cnVjdA0KPiBhbWRncHVfZGV2aWNlDQo+ID4+ICphZGV2LA0KPiA+PiAgICAgICAgICAgICAgIGFk
ZXYtPmdtYy54Z21pLmhpdmVfaWQgJiYNCj4gPj4gICAgICAgICAgICAgICBhZGV2LT5nbWMueGdt
aS5oaXZlX2lkID09IGJvX2FkZXYtPmdtYy54Z21pLmhpdmVfaWQpOw0KPiA+PiAgfQ0KPiA+PiAr
DQo+ID4+ICtzdGF0aWMgaW5saW5lIHVpbnQzMl90DQo+ID4+ICtfX2FtZGdwdV94Z21pX2dldF9t
YXhfYmFuZHdpZHRoKHVpbnQ4X3QgbGlua193aWR0aCwNCj4gPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZW51bSBhbWRncHVfeGdtaV9saW5rX3NwZWVkIG1heF9zcGVlZCkNCj4gPj4g
K3sNCj4gPj4gKyAgICAgLyogUmV0dXJucyB1bmlkaXJlY3Rpb25hbCBiYW5kd2lkdGggaW4gTWJw
cyAqLw0KPiA+PiArICAgICByZXR1cm4gbWF4X3NwZWVkICogMTAwMCAqIGxpbmtfd2lkdGg7DQo+
ID4NCj4gPiBJbnN0ZWFkIG9mIHdyYXBwaW5nIHRoaXMgaW4gYSBuZXcgc3RhdGljLCB3b3VsZCBp
dCB3b3JrIHRvIGRlY2xhcmUgYSBuZXcgbWVtYmVyDQo+IGFkZXYtPmdtYy54Z21pLm1heF9iYW5k
d2lkdGg/DQo+ID4gVGhlbiBpbiBhbWRncHVfeGdtaV9pbml0X2luZm8sIHlvdSBjYW4gZGVmaW5l
IG1heF9iYW5kd2lkdGggZGlyZWN0bHkgYWZ0ZXIgdGhlDQo+IHN3aXRjaC4NCj4gPg0KPg0KPiBM
aW5rIFdpZHRoL0xpbmsgc3BlZWQgaXMgZ2VuZXJhbGx5IHRoZSBzdGFuZGFyZCB3YXkgdG8gcmVw
cmVzZW50IGxpbmsNCj4gaW5mby4gUHJlc2VudGx5LCB0b29scyBsaWtlIFNNSSBzaG93IHRoZXNl
IGZvciBQQ0llLiBGb2xsb3dlZCB0aGUgc2FtZQ0KPiBoZXJlIGFuZCBrZXB0IGEgbWF4IGJhbmR3
aWR0aCB2YWx1ZSBjYWxjdWxhdGlvbi4NCg0KR01DIHhHTUkgaW5mbyBpcyBmb3IgaW50ZXJuYWwg
ZHJpdmVyIHVzYWdlIGFzIHdlbGwuDQpJIGRvbuKAmXQgc2VlIHRoZSBwb2ludCBvZiBkb2luZyBl
eHRyYSBjYWxjdWxhdGlvbnMgb3IgaGF2aW5nIHVubmVjZXNzYXJ5IHdyYXBwZXJzIGZvciBhIHN0
YXRpYyBwaWVjZSBvZiBpbmZvLg0KSWYgeW91IGRvbid0IHdhbnQgYmFuZHdpZHRoIGluIHRoZSBH
TUMgeEdNSSBpbmZvIHN0cnVjdCwgdGhlbiBmb3IgeW91ciA0dGggcGF0Y2ggKGRybS9hbWRncHU6
IFVzZSB4Z21pIEFQSXMgdG8gZ2V0IGJhbmR3aWR0aCksIGp1c3QgcmVmZXJlbmNlIHNwZWVkIGFu
ZCBsaW5rIGluIHRoZSBjYWxsZXIgYW5kIGRvIHRoZSBjYWxjdWxhdGlvbiBkaXJlY3RseSB0aGVy
ZS4NCkdvaW5nIGRvd24gYSB3cmFwcGVyIHJhYmJpdCBob2xlIHNlZW1zIGxpa2UgaXQgd2lsbCBt
YWtlIHRoaW5ncyBoYXJkZXIgdG8gbWFpbnRhaW4gaW4gdGhlIGZ1dHVyZS4NCg0KSm9uDQoNCj4N
Cj4gPj4gK30NCj4gPj4gKw0KPiA+PiArLyoqDQo+ID4+ICsgKiBhbWRncHVfeGdtaV9nZXRfbWF4
X2JhbmR3aWR0aCAtIEdldCBtYXggcG9zc2libGUgYmFuZHdpZHRoIG9mIGEgc2luZ2xlDQo+ID4+
IFhHTUkNCj4gPj4gKyAqIGxpbmsgb2YgdGhlIGRldmljZSBpbiBNYnBzDQo+ID4+ICsgKiBAYWRl
djogVGFyZ2V0IGRldmljZS4NCj4gPj4gKyAqDQo+ID4+ICsgKiBHZXRzIHRoZSBtYXggcG9zc2li
bGUgYmFuZHdpZHRoIG9mIGEgc2luZ2xlIFhHTUkgbGluayBvZiB0aGUgZGV2aWNlIGluIE1icHMu
DQo+ID4+ICsgKiBBc3N1bXB0aW9uIGlzIGFsbCBsaW5rcyBvZiB0aGUgZGV2aWNlIGhhdmUgdGhl
IHNhbWUgd2lkdGggYW5kIGFyZSBvZiB0aGUNCj4gPj4gKyAqIHNhbWUgWEdNSSBnZW5lcmF0aW9u
Lg0KPiA+PiArICovDQo+ID4+ICt1aW50MzJfdCBhbWRncHVfeGdtaV9nZXRfbWF4X2JhbmR3aWR0
aChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPj4gK3sNCj4gPj4gKyAgICAgaWYgKCFh
ZGV2LT5nbWMueGdtaS5zdXBwb3J0ZWQpDQo+ID4+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
ID4+ICsNCj4gPj4gKyAgICAgcmV0dXJuIF9fYW1kZ3B1X3hnbWlfZ2V0X21heF9iYW5kd2lkdGgo
YWRldi0+Z21jLnhnbWkubWF4X3dpZHRoLA0KPiA+PiBhZGV2LT5nbWMueGdtaS5tYXhfc3BlZWQp
Ow0KPiA+DQo+ID4gSWYgeW91IGRvIHRoZSBzdWdnZXN0ZWQgYWJvdmUsIGJvdGggdGVzdHMgY2Fu
IGJlIHNpbXBsaWZpZWQgaW50byAxIGxpbmUgYXMNCj4gPiAtPiByZXR1cm4gPSB4Z21pX3N1cHBv
cnRlZCA/IG1heF9iYW5kd2lkdGggOiAwOw0KPiA+DQo+DQo+IFllcywgcHJpbWFyaWx5IHdpZHRo
L3NwZWVkIGlzIGNob3NlbiB0byByZXByZXNlbnQgbGluayBpbmZvLg0KPg0KPiA+PiArfQ0KPiA+
PiArDQo+ID4+ICt2b2lkIGFtZGdwdV94Z21pX2luaXRfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikNCj4gPj4gK3sNCj4gPj4gKyAgICAgc3dpdGNoIChhbWRncHVfaXBfdmVyc2lvbihh
ZGV2LCBYR01JX0hXSVAsIDApKSB7DQo+ID4+ICsgICAgIGNhc2UgSVBfVkVSU0lPTig2LCAxLCAw
KToNCj4gPj4gKyAgICAgICAgICAgICBhZGV2LT5nbWMueGdtaS5tYXhfc3BlZWQgPSBYR01JMl81
X1NQRUVEX0dUOw0KPiA+PiArICAgICAgICAgICAgIGFkZXYtPmdtYy54Z21pLm1heF93aWR0aCA9
IDE2Ow0KPiA+PiArICAgICAgICAgICAgIGJyZWFrOw0KPiA+PiArICAgICBjYXNlIElQX1ZFUlNJ
T04oNiwgNCwgMCk6DQo+ID4+ICsgICAgICAgICAgICAgYWRldi0+Z21jLnhnbWkubWF4X3NwZWVk
ID0gWEdNSTNfU1BFRURfR1Q7DQo+ID4+ICsgICAgICAgICAgICAgYWRldi0+Z21jLnhnbWkubWF4
X3dpZHRoID0gMTY7DQo+ID4+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ID4+ICsgICAgIGRlZmF1
bHQ6DQo+ID4+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ID4+ICsgICAgIH0NCj4gPj4gK30NCj4g
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmgN
Cj4gPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5oDQo+ID4+IGlu
ZGV4IDA0NGM0ZjZiZTQ0YS4uMzg0YzRkZGVmNzhhIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5oDQo+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmgNCj4gPj4gQEAgLTI1LDYgKzI1LDEyIEBADQo+
ID4+ICAjaW5jbHVkZSA8ZHJtL3Rhc2tfYmFycmllci5oPg0KPiA+PiAgI2luY2x1ZGUgImFtZGdw
dV9yYXMuaCINCj4gPj4NCj4gPj4gK2VudW0gYW1kZ3B1X3hnbWlfbGlua19zcGVlZCB7DQo+ID4+
ICsgICAgIFhHTUkyX1NQRUVEX0dUID0gMTYsDQo+ID4+ICsgICAgIFhHTUkyXzVfU1BFRURfR1Qg
PSAyNSwNCj4gPj4gKyAgICAgWEdNSTNfU1BFRURfR1QgPSAzMg0KPiA+DQo+ID4gV2h5IG5vdCBk
ZWNsYXJlIGFuZCBkZWZpbmUgdGhlbSBhcyB1bml0cyBvZiBNYnBzIHRvIGJlZ2luIHdpdGggc28g
eW91IGRvbid0IGhhdmUNCj4gdG8gZG8gdGhlIGNhbGN1bGF0aW9uIGxhdGVyPw0KPg0KPiBBY3R1
YWxseSwgdGhpcyBpcyBhbHNvIHNvbWV0aGluZyB3aGljaCBpcyBmb2xsb3dlZCBmcm9tIFBDSWUg
dG8NCj4gcmVwcmVzZW50IGFzIEdUL3MuIElmIGJhbmR3aWR0aCBmaWVsZCBhbG9uZSBpcyBrZXB0
LCB0aGVuIHRoaXMgYWxzbw0KPiB3b24ndCBiZSByZXF1aXJlZC4NCj4NCj4gSSdtIG5vdCBzbyBz
dXJlIGlmIHRoYXQgaXMgYSBnb29kIHdheSB0byBrZWVwIHRoaW5ncy4NCj4NCj4gVGhhbmtzLA0K
PiBMaWpvDQo+DQo+ID4NCj4gPiBKb24NCj4gPg0KPiA+PiArfTsNCj4gPj4gKw0KPiA+PiAgc3Ry
dWN0IGFtZGdwdV9oaXZlX2luZm8gew0KPiA+PiAgICAgICBzdHJ1Y3Qga29iamVjdCBrb2JqOw0K
PiA+PiAgICAgICB1aW50NjRfdCBoaXZlX2lkOw0KPiA+PiBAQCAtNzUsNiArODEsOCBAQCBzdHJ1
Y3QgYW1kZ3B1X3hnbWkgew0KPiA+PiAgICAgICBzdHJ1Y3QgcmFzX2NvbW1vbl9pZiAqcmFzX2lm
Ow0KPiA+PiAgICAgICBib29sIGNvbm5lY3RlZF90b19jcHU7DQo+ID4+ICAgICAgIHN0cnVjdCBh
bWRncHVfeGdtaV9yYXMgKnJhczsNCj4gPj4gKyAgICAgZW51bSBhbWRncHVfeGdtaV9saW5rX3Nw
ZWVkIG1heF9zcGVlZDsNCj4gPj4gKyAgICAgdWludDhfdCBtYXhfd2lkdGg7DQo+ID4+ICB9Ow0K
PiA+Pg0KPiA+PiAgc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmFtZGdwdV9nZXRfeGdtaV9oaXZl
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gPj4gQEAgLTEwMiw0ICsxMTAsNyBAQCBp
bnQgYW1kZ3B1X3hnbWlfcmVxdWVzdF9ucHNfY2hhbmdlKHN0cnVjdA0KPiA+PiBhbWRncHVfZGV2
aWNlICphZGV2LA0KPiA+PiAgaW50IGFtZGdwdV9nZXRfeGdtaV9saW5rX3N0YXR1cyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aW50IGdsb2JhbF9saW5rX251bSk7DQo+ID4+DQo+ID4+ICt2b2lkIGFtZGdwdV94Z21pX2luaXRf
aW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+ID4+ICt1aW50MzJfdCBhbWRncHVf
eGdtaV9nZXRfbWF4X2JhbmR3aWR0aChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+ID4+
ICsNCj4gPj4gICNlbmRpZg0KPiA+PiAtLQ0KPiA+PiAyLjI1LjENCj4gPg0KDQo=
