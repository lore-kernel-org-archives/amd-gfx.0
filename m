Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C53D591A5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 17:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F6F910E693;
	Tue, 19 Nov 2024 17:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FLtf0s2q";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F7810E693
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 17:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNzEBbF00VNhOlkkq5L6lqHfp6zNnjwnipDYJqi9t4q4V7lkZbKevK3H1tTLEqx5cSxJnqqibtofpjejgC20ptGrImOtuU4pxLvOPOUy8zKdL4oP4Fg/TaY8S4o/SvcuKeCCJf//6ZTMt2MJ9P9j6p+uyFu9QYFlQKpVvhv33+LM6E61NyNkCt9r4OsAOlfkFv6aNNQFy2Mq6qln5IzQW2l13kqQOoM9zJCwJBHjMJ1bw2M+yVGe5u/OOJcx9itKF1bEnboG7ga+W5PIUqynNEhB21OyHQmhZDX9roka+7t8NfATOwZb+vprFnlwJ1Ixdw5/4QGTGxY9XubOEDq0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3wwXdtgVkMQCH1Ofn77wSKfUfI0A8MojG2jZ73v95A=;
 b=KiEYLUQa/mXvjhnNAHdPprMNiGvxbIXUZR2bbcoWtQzT9ncusVvrLQi28fd4z30hbGTpyx78V/niHX1B4yR99FKR2J0EgUI3i49BxAPU9hj0CIG2+Gpp8w3uhN1rXsrJCNnkRRrP/mzF8eEOQjyxe1QxN/09mhwn70Rp16WViWlIBPHiLUEIQ2mSK3QqC3un9tkdQ4klE8xrlCCzBo6sVIL2iMDVawTEFtbAC2swcURHjBhoxk2bJ4yB7N9leaKDlx7JStpWui0Xq+va7F05xy20YNgURK5dGLEpCGLmTvaD6uiBfgIt3xVM/a3bSV0X5gxa3WFe9yQIj8DDalINcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3wwXdtgVkMQCH1Ofn77wSKfUfI0A8MojG2jZ73v95A=;
 b=FLtf0s2q6GIULA3viYqDo42xQ9RQUcTHGGfbJL+Hh++0w47AM2DAPiLgmz9m+jMPFiGUqsj2cn0KY/c81PxtmtvrM70cnYM4ukX4ysy52WSr7YGTPiOUaIZ5Mc5jpG2C7LA1ov+zyF58y1Gd+t21Qx4rqFfb6Ypf7wIuAjGAHo8=
Received: from CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 17:04:29 +0000
Received: from CY8PR12MB7289.namprd12.prod.outlook.com
 ([fe80::9cc2:b7be:be33:58b7]) by CY8PR12MB7289.namprd12.prod.outlook.com
 ([fe80::9cc2:b7be:be33:58b7%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 17:04:28 +0000
From: "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>
To: Melissa Wen <mwen@igalia.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] SWDEV-476969 - dm/amdgpu: Fail dm_atomic_check if cursor
 overlay is required at MAX_SURFACES
Thread-Topic: [PATCH] SWDEV-476969 - dm/amdgpu: Fail dm_atomic_check if cursor
 overlay is required at MAX_SURFACES
Thread-Index: AQHbNqLTkrugb7FD0USFmuf6J5b6l7K3IrKAgAXhY4CAAdiVYA==
Date: Tue, 19 Nov 2024 17:04:28 +0000
Message-ID: <CY8PR12MB7289A713F418E705C5FBB5C7E2202@CY8PR12MB7289.namprd12.prod.outlook.com>
References: <20241114143741.627128-1-zaeem.mohamed@amd.com>
 <61209a80-9796-42db-8d3d-0b5de317c338@amd.com>
 <db124999-db4e-4f42-b0ed-86249dd20bbd@igalia.com>
In-Reply-To: <db124999-db4e-4f42-b0ed-86249dd20bbd@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=70b29330-f72c-47f0-b86b-2176b853d714;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-19T17:03:34Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7289:EE_|SJ2PR12MB8926:EE_
x-ms-office365-filtering-correlation-id: e41e193a-5916-4241-b1b0-08dd08bc3ac2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aXNyQXU0TU1FSjRxWU1YMmVKb3cyTGk3NVJRUnlINWNrNElKMDlCbGQ2MTFo?=
 =?utf-8?B?TzRTdldvN0ROTjZ6WDlqUjE3dXNnOHIzREZSZTJTeFlTQm1XaFBldHdpVU0r?=
 =?utf-8?B?MGV6OERHMWdkbDNibHErYVVkVDA3TGp2UkdSRlJndFh6Smdqak5qd3Zaa0Mv?=
 =?utf-8?B?KzFxalFtQnRRRVNCbjFQRHFDY1MyQk13N1g0TmZjZWx4NDJ4TmFvVUdlS0tU?=
 =?utf-8?B?NmlOWmxyTGN3S0NSd2tENmcwNHFOUVo2aWxaUHFiOEllNC91bUtpQVltMGFt?=
 =?utf-8?B?YXBaQzZ1MHJlS3V1L3pVdEVsYjNKZytaWVpZOVJnS0wvclE5ZHRYUDNFaS9G?=
 =?utf-8?B?MjZZUkVZUE5MalMxM3Y4RzJQNXcrTXdIaUQ3NkNWbUU4VUZRZVV1bDgvcEhm?=
 =?utf-8?B?S3d6bFlmUnlpeDB2Vm1qbXRPTXhmYk9yc0lOWmc3TUliVlpxTWYyL1RXaHU5?=
 =?utf-8?B?RTl6S2ZKSzFGV0JnUTNVanhmTEE4cnJGVncxdmVTWkR2TVRMRnFwMkhXcjF3?=
 =?utf-8?B?dTZ3OFprb2xPZ0pLVmtBalN3aHI5VHF0WWRSRlp1Rm9nMWcyUjlDM253WE92?=
 =?utf-8?B?Yk82R1h4dXp3elEyN1FHL0U5Y3Q0d3h2N3VGczRDbFlvUEFBWHFWckNDaU9S?=
 =?utf-8?B?ZnVwZzRFMVlhMFI2UTJPT1JMWm1jM0QzWmVzR0NUMXhmVHI0SGlBb1FPdUpj?=
 =?utf-8?B?R08vWGJ5UDNJWnlOTUFPYURHWWNEMlJQS2R6WHBkR3B2YUs5eWw0aTRacXBW?=
 =?utf-8?B?a3ZzVmhkY0R1V2xFbEVRK0FWZjk1eHFXMU4rTmRYamNCZ3o4ZjBaVUhqRU54?=
 =?utf-8?B?VnFRazAxTGZNcENvbDY3dHBpY0tlRVFpWmdMakhLZmZaUFpLRlZ6ZHVLdnV0?=
 =?utf-8?B?L1dLMkErMExWdmpxSkxCWXFxL2dQMk1OWUo3WU5DbnZRWkNRQllYdzZJbE5m?=
 =?utf-8?B?VG1mZzY5VEM5bDg0ZU5GRU9SZGtMMDdVMzJzdVR3QUNSQVJ6NCsyaU5NbE1E?=
 =?utf-8?B?dE9mYzdpTWFlQ25pa0tkWUxxaE9UcVBVNTc2T00yeC9RNDVObFNQL1BDNGtH?=
 =?utf-8?B?RUR6SG85M1JHVjhLNVhVT2N1S09EQlZwRm1ZeUFTSnFZWXhNc2VlcUpTUnA3?=
 =?utf-8?B?OTFVUUJVOThmZkFwanNhb3lmR2h0Z0JobE1RY1p5Mmw3cm16MVBvVndqd2tx?=
 =?utf-8?B?VkNBWlJiRFQ1VnBzNWRudnYxeDZQN21ZUkJTUXB5Y1Uyb0hyUDZ5QnNIVG9v?=
 =?utf-8?B?cGdqMGp0eU1oVEdBLzF0blZ3SmxUWkFuck5weXdXVEw4T3hnWGVKb0tDajZX?=
 =?utf-8?B?eEduZ2ZFcUhJSjFpbzJVT2xKY0JqQkRIOVk3R3lVTjBKZ21uRHlxMjFTN0FW?=
 =?utf-8?B?VGgvaGh5ZWdTNWtuaVlRZndhRzRLVDBBWkE2ak5HNkNYQVZodlBJNGJXNFRU?=
 =?utf-8?B?ME01TUcyd055SlJHeWFpNHkya2pXUVFjbWNkMktncWtvRG9KbGZjLytqbm9L?=
 =?utf-8?B?WHdwamV2NHR6NGdSK1VORmdJdUJ6N3V1TG1jcXp3REJVV2RqMFFBYVpoMGhZ?=
 =?utf-8?B?YWYzUS9IRjdlTE54MTFXY3lrTUt5ZzMvOEZXakJ6OWlpWGRFREdDU0owWHkr?=
 =?utf-8?B?Tk9SQ0xFclhqaC9OMDdhUTVIc0NOUHcvTWUxMkVpaHZodEVBQ3UwUHRZVnZa?=
 =?utf-8?B?WkZPaEtvaXpyLy9FSms5b3RsbTNwT0RCWWVENmo0RFg2R2lGK2Q5WGhQRDBY?=
 =?utf-8?B?Y29iYTFROUpTUFk5MTdJL28raGNQc0MrM2RQRjlrNVlYYmRIWWllNjJ2dDd0?=
 =?utf-8?B?NndQcW9DTlJ2TUhmd2RJQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7289.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWQzUExuYi8vQWNtNG56V29WS3Q2cjZSYlVSU2J3WjI1cGFrSHdjaUNmSHN6?=
 =?utf-8?B?MzF0SFJUYmVhTUN4cTJ6SlQ5VjNZaUd0bkc0K3pIYVpEcHRFRjFMY1NoTDRF?=
 =?utf-8?B?TE8rS0lSZTZSOG5UZEFBTzJiL1dNTFhQc3NxaHdFUnR3UEhaTjJrb0FLbWVy?=
 =?utf-8?B?ZnJsK29NUnRKWkVMSDlMNXFwVTFLclFCNlNaRDlodStWOTQ0Y1h1eTc2aGNt?=
 =?utf-8?B?dUlSRTgyTzMrckZnaFR3NXZHd1U5ZzZaaVNYTHYxNzFQSUpGQ1JJdUVIRU12?=
 =?utf-8?B?dEVGR0ZRei9Xd0lVSmVIRjAva0txUDRHamhCTCt3ZkEvYVNjR2prcEdyZW5r?=
 =?utf-8?B?L0lReU4rcWtZOFJIV0J4MERQMHRVaWluWiszOUNHamcvdE5BZlJ3Z2wwb2Jk?=
 =?utf-8?B?NVRzRWh4ditYN2pqUFYvSlVHYTc0NEpsd3lCZU1VdGxWQzZma2IwRzlhVGJl?=
 =?utf-8?B?M1ZzazUzb2kySWxLaWZKV3E5dDFmUVppNmF2dS83NmR0R3h4Q1cvY3hiZ0Qz?=
 =?utf-8?B?Qm83S0pUaVlETUY5aVJkUzVuY3M4OHBKSmo4SmhOUXVLT2V1MzhPWkRYVk1L?=
 =?utf-8?B?T2FBb0ozdDE5cXBnakFuL1pZYzFubHlBeEFNeHVpOFgvWVJiM0tqQnoxWnN5?=
 =?utf-8?B?VzFRNTYrVGpyY0YvQUN4MDFDdGlod0VBbDNTd2tmRkNjbnBBT05FZTJwSXZo?=
 =?utf-8?B?NTBZeGIzaHlxaER4ZTJHVkorZjlDOWp5Zm51OVVFaDIvTmpMMHFVb01ZZm92?=
 =?utf-8?B?enFnUWExOUVKdUw2eVpmS2pvTFA2OFdtSmQrK2NSTk5SUkd5SlBoWHQxNjdY?=
 =?utf-8?B?a3MyMzhDaWtBZGRoL1NMejFFaTR2bVIwYTlLQjZYR3Y3RHZSYXhPekZPbzlW?=
 =?utf-8?B?MmlOa29VWXZGTG1CN3FIamdVSTd6ZmU2U1Z0Z2d2REZHcjI4TlA1Qzl1N2t1?=
 =?utf-8?B?a2NDeUR2cDJ3Q0Vvbnh6MGtORTd0cWJVMEh0cWhqNUhEcmVFMncvdmVXajVx?=
 =?utf-8?B?MXRoM0pWdjVYNzRWQTlydGVlaUtEVkxLU3ZrWHUvV2p1cjZLSGRQNXd1TG5q?=
 =?utf-8?B?R1RXZlJZNnBXc01XZElxS3JoK2tNeURUWkZweUlMbG90dEVZYjdHc0RodFJF?=
 =?utf-8?B?bWl2L1dMVGE2V3lSSk5HU3BiNWJ2K2NxZVpDOEwxQnllWUMwY2tUZjlCbE5V?=
 =?utf-8?B?QW5tS2ErZGhpUlpxTlhWL1U4V2cwNU1YZk5nS3lXZ2ZFNi9nYkNVSFIzQWFV?=
 =?utf-8?B?SlpzblVQeDJXUkJzT0p0cXMrV1VTeEYxaXpYMExQNVJ0aWZUcXBOVGJHbHlW?=
 =?utf-8?B?Rno3ZTVhekd0cnV4QjlqOFMzVWtvNCtvaE0xcTkzR29KOXhGZ0RINzEzQXR1?=
 =?utf-8?B?UEFpSFh1VnVVa051aTlWUGZsZ2M0ZGRDZGlGRERxbXNiNWJ2YVNYenJnY3FV?=
 =?utf-8?B?eUduYkpHYnUvVkJ3TnY5cXp3Y0ZXQmxqVlBWR05pbHgwNjlhc1RlL1BHZDY5?=
 =?utf-8?B?R0ZmNEZ5ay9NOEVicVRzcnB3N1M4WW1GNzk0cFdFbkRaQUhQOCsrM25HVXk0?=
 =?utf-8?B?UnVjRDlxREFQZG4vK25KQjNOOXdtUUlZZzd3UERFSDB6Z2dZNGp0T2ovVHhJ?=
 =?utf-8?B?clE4Ly9IUnc0SkV1VEFYa052NVZFRVJxcjdRa0VpUU9WbmFKRWhxM1duVmlG?=
 =?utf-8?B?ZENDemhsZkcxY3llOGdlazFvM1l4clc5aDFXSXdNdDNQTUlyK1ZoeU5VaEFY?=
 =?utf-8?B?YTJZcnhKWmc2UFVxb2NManl5Z1E1UDgvcWoyYTBVQlhNRzZHanFjcVllUkNS?=
 =?utf-8?B?Z2VrR25LS0dwQXBjOE5XWEVFcmd5MU5WdXNzYmtaZnlGTnVwalYwYXU3YUU2?=
 =?utf-8?B?OFZTOUg0SkQ3VU5heElOQjhBUXM1enhickJzZjQ5YzNBZGNoVVVGZmt0QlZH?=
 =?utf-8?B?MWIvTHVxV1NHYWx1Y2VaenNvejdmeUVVYlZLT0U3TlZVbUNyQ0FXbWVuaU9H?=
 =?utf-8?B?QUNPNkkzZWY1Y3g4QllzdVY1TjR5KzBKOVZmTzllU1hRVzhybjM5UHJkU2pn?=
 =?utf-8?B?cHBlQ25EM0R2YVRVck1HdkdWak03a1lzN1BuUGRDcS83ZXJ0Z205bTNsKzNk?=
 =?utf-8?Q?JE0I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41e193a-5916-4241-b1b0-08dd08bc3ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 17:04:28.8956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5zs0F6GzKn12R2dM0V8fmWueSWZLSjctAP6h/GA/5MlUOMID4B/lSxuw4DzQs0gpIg5rgUwXtVw/GTl8i40ckg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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
Cg0KSGkgTWVsaXNzYSwNCg0KQ291bGQgeW91IHNoYXJlIHlvdXIgY29uZmlndXJhdGlvbiB0aGF0
IGV4cGVyaWVuY2VkIHRoaXMgcGFnZWZhdWx0Pw0KDQpUaGFua3MsDQpaYWVlbQ0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWVsaXNzYSBXZW4gPG13ZW5AaWdhbGlhLmNvbT4N
ClNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTgsIDIwMjQgNzo1MiBBTQ0KVG86IExpbW9uY2llbGxv
LCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IE1vaGFtZWQsIFphZWVtIDxaYWVl
bS5Nb2hhbWVkQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVj
dDogUmU6IFtQQVRDSF0gU1dERVYtNDc2OTY5IC0gZG0vYW1kZ3B1OiBGYWlsIGRtX2F0b21pY19j
aGVjayBpZiBjdXJzb3Igb3ZlcmxheSBpcyByZXF1aXJlZCBhdCBNQVhfU1VSRkFDRVMNCg0KDQoN
Cg0KT24gMTQvMTEvMjAyNCAxNjowNCwgTWFyaW8gTGltb25jaWVsbG8gd3JvdGU6DQo+IEFsdGhv
dWdoIGl0J3MgcmVhbGx5IHVzZWZ1bCBpbmZvcm1hdGlvbiBmb3IgQU1EIHBlb3BsZSwgdGhlIEpp
cmENCj4gc2hvdWxkbid0IGJlIGluIHRoZSAidGl0bGUiIG9mIHRoZSBjb21taXQgbWVzc2FnZS4N
Cj4NCj4gIklmIiB3ZSB3YW50IHRvIGdldCBpbnRvIHRoZSBoYWJpdCBvZiBpbmNsdWRpbmcgdGhp
cyBpbmZvcm1hdGlvbiBmb3INCj4gZGlzcGxheSBjb2RlIHdlIHNob3VsZCBjb21lIHVwIHdpdGgg
YSBwcmVzY3JpcHRpdmUgZmllbGQgdGhhdCBnb2VzDQo+IGludG8gdGhlIGNvbW1pdCBtZXNzYWdl
IGR1cmluZyBwcm9tb3Rpb24gYW5kIGl0IHNob3VsZCBiZSBwYXJ0IG9mIGFsbA0KPiBwYXRjaGVz
IGluIHRoZSBwcm9tb3Rpb24gdGhhdCBoYXZlIGl0Lg0KPg0KPiBTb21ldGhpbmcgbGlrZSB0aGlz
Og0KPg0KPiBBTUQtSmlyYTogU1dERVYtNDc2OTY5DQo+DQo+IFByb2JhYmx5IG5lZWQgdG8gYWxp
Z24gdGhhdCB3aXRoIG90aGVyIHN0YWtlaG9sZGVycyB0aG91Z2ggYmVmb3JlDQo+IHN0YXJ0aW5n
IHRoYXQgd2F5Lg0KPg0KPiBPbiAxMS8xNC8yMDI0IDA4OjM3LCBaYWVlbSBNb2hhbWVkIHdyb3Rl
Og0KPj4gW3doeV0NCj4+IFByZXZlbnQgaW5kZXgtb3V0LW9mLWJvdW5kcyBkdWUgdG8gcmVxdWly
aW5nIGN1cnNvciBvdmVybGF5IHdoZW4NCj4+IHBsYW5lX2NvdW50IGlzIE1BWF9TVVJGQUNFUy4N
Cj4+DQo+PiBbaG93XQ0KPj4gQm91bmRzIGNoZWNrIG9uIHBsYW5lX2NvdW50IHdoZW4gcmVxdWly
aW5nIG92ZXJsYXkgY3Vyc29yLg0KPj4NCj4NCj4gQW55IGxpbmsgdG8gZmFpbGluZyBidWdzIG9y
IGFueXRoaW5nIGxpa2UgdGhhdCB5b3UgY2FuIGluY2x1ZGU/DQpIaSBNYXJpbywNCg0KQWJvdXQg
dGhpcyBxdWVzdGlvbiwgdGhlc2UgYXJlIHRoZSByZWxhdGVkIGlzc3VlczoNCi0gTGluazogaHR0
cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMzY5Mw0KLSBMaW5r
OiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8zNTk0DQoN
CllvdSBjYW4gZmluZCBtb3JlIGRldGFpbHMgaW4gcHJldmlvdXMgaXRlcmF0aW9ucyByZWxhdGVk
IHRvIHRoaXMgYnVnOg0KLQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYW1kLWdmeC81NzVkNjZj
Ny1lNzdkLTQyZWEtYWNiZi00MTJkNmU1MDhhMGJAaWdhbGlhLmNvbS8NCi0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYW1kLWdmeC8yMDI0MDkyNTE1NDMyNC4zNDg3NzQtMS1td2VuQGlnYWxpYS5j
b20vDQo+DQo+PiBDby1kZXZlbG9wZWQtYnk6IE1lbGlzc2EgV2VuIDxtd2VuQGlnYWxpYS5jb20+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBaYWVlbSBNb2hhbWVkIDx6YWVlbS5tb2hhbWVkQGFtZC5jb20+
DQo+DQo+IFlvdSdyZSBtaXNzaW5nIE1lbGlzYWEncyBTb0IgZm9yIGEgY28tZGV2ZWxvcGVkIHBh
dGNoLg0KPiBJSVJDIHRoaXMgc2hvdWxkIGZhaWwgY2hlY2twYXRjaC4NCkkgYWxyZWFkeSBtZW50
aW9uZWQgYmVmb3JlLCBJIGRvbid0IHRoaW5rIEkgYWN0dWFsbHkgY28tZGV2IHRoaXMgY29kZSwg
c28gWmFlZW0gY2FuIHJlbW92ZSBpdCBpbiB0aGUgbmV4dCBpdGVyYXRpb24uDQoNCi0tLQ0KDQpC
VFcsIGFib3V0IHRoZSBpbXBsZW1lbnRhdGlvbjoNCg0KQXMgSSBkb24ndCBoYXZlIHRoZSBwcm9w
ZXIgZW52aXJvbm1lbnQsIEkgYXNrZWQgcmVwb3J0ZXJzIHRvIGNoZWNrIHRoaXMgcGF0Y2ggdXAg
YW5kIGl0IGRvZXNuJ3QgaGVscCBwcmV2ZW50IGludGVyZmFjZSBmcmVlemUuDQpJdCBzZWVtcyB0
byBwcmV2ZW50IHRoZSBvdXQgb2YgYm91bmRzIGJ1ZyBidXQgaXMgY2F1c2luZyBhIHBhZ2UgZmF1
bHQgbm93Og0KDQprZXJuZWw6IEJVRzogdW5hYmxlIHRvIGhhbmRsZSBwYWdlIGZhdWx0IGZvciBh
ZGRyZXNzOiAwMDAwMDAwMDAxNzRlMzU0DQoNCiBGcm9tIHRoZWlyIGZlZWRiYWNrLCBJIGZvdW5k
IGN1cmlvdXMgdGhhdCBNQVhfU1VSRkFDRVMgLT4gNCBwcmV2ZW50cyB0aGUgZnJlZXplIGJ1dCBu
b3QgY29tcGxldGVseSBzb2x2ZSB0aGUgcHJvYmxlbS4NCk1BWF9TVVJGQUNFUyAtPiA2IHNvbHZl
cyBpdCwgd2hhdCBsZXQgbWUgY29uc2lkZXIgdGhhdCB0aGUgTUFYX1NVUkZBQ0VTIHZzIE1BWF9T
VVJGQUNFX05VTSB2cyBNQVhfUExBTkUgbWlzbWF0Y2ggbWlnaHQgYmUgcmVsYXRlZC4NCkknbSBn
b2luZyB0byBhbmFseXppbmcgdGhlIGxvZ3MgYnV0IHlvdSBjYW4gZmluZCBtb3JlIGRldGFpbHMg
aGVyZToNCmh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzM2
OTMjbm90ZV8yNjU4OTk0DQoNCkJSLA0KDQpNZWxpc3NhIFdlbg0KPg0KPj4gLS0tDQo+PiAgIGFt
ZGdwdV9kbS9hbWRncHVfZG0uYyB8IDEwICsrKysrKysrKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMgYi9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgaW5kZXgNCj4+IDk3ZTBh
MWJiYmEuLjk2NDQ5N2M2MTMgMTAwNjQ0DQo+PiAtLS0gYS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMN
Cj4+ICsrKyBiL2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPj4gQEAgLTExODIxLDggKzExODIxLDE2
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RtX2F0b21pY19jaGVjayhzdHJ1Y3QNCj4+IGRybV9kZXZp
Y2UgKmRldiwNCj4+ICAgICAgICAgICAgIC8qIE92ZXJsYXkgY3Vzb3Igbm90IHN1YmplY3QgdG8g
bmF0aXZlIGN1cnNvcg0KPj4gcmVzdHJpY3Rpb25zICovDQo+PiAgICAgICAgICAgZG1fbmV3X2Ny
dGNfc3RhdGUgPSB0b19kbV9jcnRjX3N0YXRlKG5ld19jcnRjX3N0YXRlKTsNCj4+IC0gICAgICAg
IGlmIChkbV9uZXdfY3J0Y19zdGF0ZS0+Y3Vyc29yX21vZGUgPT0NCj4+IERNX0NVUlNPUl9PVkVS
TEFZX01PREUpDQo+PiArICAgICAgICBpZiAoZG1fbmV3X2NydGNfc3RhdGUtPmN1cnNvcl9tb2Rl
ID09DQo+PiArRE1fQ1VSU09SX09WRVJMQVlfTU9ERSkgew0KPj4gKyAgICAgICAgICAgIGlmIChk
Yy0+Y3VycmVudF9zdGF0ZS0+c3RyZWFtX3N0YXR1cy0+cGxhbmVfY291bnQgPg0KPj4gTUFYX1NV
UkZBQ0VTKSB7DQo+PiArICAgICAgICAgICAgICAgIGRybV9kYmdfZHJpdmVyKGNydGMtPmRldiwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICJDYW4ndCBlbmFibGUgY3Vyc29yIHBsYW5lIHdp
dGggJWQgcGxhbmVzXG4iLA0KPj4gTUFYX1NVUkZBQ0VTKTsNCj4+ICsgICAgICAgICAgICAgICAg
cmV0ID0gLUVJTlZBTDsNCj4+ICsgICAgICAgICAgICAgICAgZ290byBmYWlsOw0KPj4gKyAgICAg
ICAgICAgIH0NCj4+ICsNCj4+ICAgICAgICAgICAgICAgY29udGludWU7DQo+PiArICAgICAgICB9
DQo+PiAgICAgICAgICAgICAvKiBDaGVjayBpZiByb3RhdGlvbiBvciBzY2FsaW5nIGlzIGVuYWJs
ZWQgb24gRENONDAxICovDQo+PiAgICAgICAgICAgaWYgKChkcm1fcGxhbmVfbWFzayhjcnRjLT5j
dXJzb3IpICYNCj4+IG5ld19jcnRjX3N0YXRlLT5wbGFuZV9tYXNrKSAmJg0KPg0KDQo=
