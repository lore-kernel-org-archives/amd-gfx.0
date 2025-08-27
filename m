Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BB0CA0EFF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 07:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FEE10E066;
	Wed, 27 Aug 2025 07:20:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dL/tn7tn";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4010010E066
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 07:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKCj61fZOXJ75W+aUwyaGcFoviokAAm1uJBn+b8ehhiXXk7zkwjH7onP29482VwxQoS74kNaaKS5+Hr43PAmjB9cN9YEAoCr3LQF19hQTfbL9b91hId5ZEGl0F7yf4uDcTTtf64H+hHwhWEjjeQthJVjQs2c+YhXjcT6ZXjYhniiv+EwOypwXerZELlz25PI6eSEUKbeSoyV8JrCxry8kv6zWT70kC4tB14B2GsUl5ZoTPHEcuNWl5tnZspekRGOeATzF3Hs11wl2/CrcrcV6Vc4ThRjmY9XnEQsGDeRY+akL9rlZIwg3L68q1Rq0kZzKvOYkIcknQkydGppEuirqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQTRUFWQRsquvRIedbi3eiiGQxQIHhUA7HR3qSew5IE=;
 b=zCyUB6Nzu8zAjJNPkpUsibAs9x706QoqWwaVu5hxisNbpr+Ai0zujDB5b2OmUPgyOeTOfCW6Cj/XH9L7AJf7I6dqjczo6mmbG4eQG1rKFLN08xNdShE3I8LYfktp/Hq9BOLXEFY1cQHqebD+CINxHH6aXNvaJJZoBNOvY9/Xs0OJMU0kIF+fFNZ2xHh24WfOq1h9fdk8ebQ8ZcrnBANcRGAdcrzXFByOH4YuV/c8z7kBVMEgJoqd3c3gJ1cLVOe+QitnwyEjeK4Beb/3iYlyO353UziC1Zqy4x9FlCFN6tHPXrehj78c4DEQ8qKUoilZgNB6WjxqUUkh4YWC80Pzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQTRUFWQRsquvRIedbi3eiiGQxQIHhUA7HR3qSew5IE=;
 b=dL/tn7tnoBRka5BGh1WJUbnHrhrWIohD9CdwYQdsa85obrawAFG3CDVkLqdONRYepLJMP+rFWZHy1Qv0S+yIXdrYPRG7tCnwDVFauvZqu8f8UW1oxJHDybVaYCQsW+uhgzpKDMibZL94eNntBDieaU7jjDoUlfvZMXYzW6QIiR0=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 07:20:05 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 07:20:05 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kamal,
 Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: unified amdgpu ip block name
Thread-Topic: [PATCH] drm/amd/amdgpu: unified amdgpu ip block name
Thread-Index: AQHcFk8aRbcbdUvoJ0q1sYT6ncoCIbR089UAgABJItCAANv28A==
Date: Wed, 27 Aug 2025 07:20:05 +0000
Message-ID: <PH7PR12MB5997194D9CEA85EE07C56FC28238A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250826060245.334880-1-kevinyang.wang@amd.com>
 <20250826060245.334880-2-kevinyang.wang@amd.com>
 <CADnq5_OT1dE1zUgjAuQijEOtWeOhvVOf3gDQ7Ys8qADN=dxsfA@mail.gmail.com>
 <PH7PR12MB5997FCE0E22637F15A45A5818239A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997FCE0E22637F15A45A5818239A@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-26T18:11:06.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA3PR12MB8811:EE_
x-ms-office365-filtering-correlation-id: 324ebc32-e5aa-43c6-3fb7-08dde53a2552
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Ylg0d1YxUnVmWVBPZXN2WitEb2RTODZUT2RtUmt1VnViNzNBclJSUUxIcVhU?=
 =?utf-8?B?UFJENmhOZXJGcm1TRnNwWGlFeG9sTFRjSGJjZnNEekFiWDdWYTU5UUdiRjJC?=
 =?utf-8?B?a0RLMzk2Y0F1RFMvc2taZUVKMldmRG1BYi9CckM4QkhsQ2xKU3cvYVBmSzBT?=
 =?utf-8?B?RGw1MFZSMUhzMWNVbjdqdkpWSElrM1pwNElUSHordmVnUWtNTkNQajhOQ2FR?=
 =?utf-8?B?WHZwYU1EN1FyeUpsRW54RG1BTkxnWW9LaWxCWkJwSGJqZHUwU0NLMEhUU2tU?=
 =?utf-8?B?aVNmbjdDT1paRHNHdDN1Y1IzNXNPS2RwWTYrQmwySnd6KzFyTWNEcmhtUEs1?=
 =?utf-8?B?YWVrY0tMbDl6Q2pObzhiNERPZmp4R2c4Z3MzU2FvRFVCSG9pYXA0RkRZUTJt?=
 =?utf-8?B?aU5paXlQSEtNRVpWL0J6bUpxdEVMSG9Fai90dDJqK0lOekV3ZmF0YnRad0xm?=
 =?utf-8?B?WnRPcThJUk80ZUpNUTVUblhBTlY0SVhXb0M0R3E2TVp2TnFjbXRSdm5yMUdh?=
 =?utf-8?B?emJZdk84d3huOFkxL0hKZ2gxODBraXlMWHNrbnFjMmQvbjJrQ2tJWk1jejNH?=
 =?utf-8?B?ZDhrWlVFcVdIekNRbUs2bmphV1h6SGNvWUpjODhvNDdFNUpiSklwOFRHVmM2?=
 =?utf-8?B?MHNUbFJkZzJRNzF5eGorUStnM0Nsb2Fad1orVWVPenhCQzUvVjNlNVgrTmIz?=
 =?utf-8?B?eklMZUpXT0F6enJTZ0dJbU1QNkUwN0JROFlJbWdaekxPOTM2SnpFZko0U0pt?=
 =?utf-8?B?ay9pUkRUR1NIblpRV2dVcXlIMC9Gakxnb253R2tTRFNlZFhueEkzUUdNUG9X?=
 =?utf-8?B?Q2hReW5SdDVqclVIenp5aWw2WkNLYVBiU0hhZlpqc0FRSzZSS3ZIZmhCcFg0?=
 =?utf-8?B?UUxZWjZVN2hMQzNCWS8zOEdRNGErdmhVOXJpODM0NXNJdXVQMUhjcGh2Rk12?=
 =?utf-8?B?ZHgrSXphenZkZlhPcnNzVTh3aDI0VzVPL21SeUFpSjh6U0NFYmh6dmFZdkph?=
 =?utf-8?B?eTQzeEpGd2JPc3lCWFNrQk9pemRKRkFYcHhYMFdydU5VSlJoekMvcHJyWGZ1?=
 =?utf-8?B?SWt4RER3UDJtZ3dCU240Z2RJRmRLUEdoRGNKRTNVSTNQcER3MXBRVXFDeHZC?=
 =?utf-8?B?MDA1QTVmOE8wTzFiSUdDMzRUN2VRbWhVZnNndEdYYitWSndZZ2xWU2ZJaFNa?=
 =?utf-8?B?bzBvbXBva0VWRGFobkpGZXdQT0NDNjRzV2pTZDNRWWY3N0VjS2t6ZXJrM3RN?=
 =?utf-8?B?b2NJMXlBaFJEQ1FVTHN0bEcwRXFQbmcwbHN4RDl0b25rVi9xZUQ4ci9YYkNz?=
 =?utf-8?B?ZVlYTnFwUEliRGNJdDNTc2VmQkswSEhqNkJSaFZvOThpbzRHcXAxWDZidTEw?=
 =?utf-8?B?RGIvQlR1VzlJK2lhZ2tlRGhCckZZbnJwZ2Q1Y1pJN3dxQnk4WU9ja011cU42?=
 =?utf-8?B?TDFpTFhJMzArUDErSWE1R2lLKzMyOEFjZkMxM2ZTWVMvV1dGUTdjWWt1RHBW?=
 =?utf-8?B?UGdBYVFGVUZPZjFqVFJJM0tqckRzbmJZS2M4clgvK0hqaFQyeVlGSU1PZERB?=
 =?utf-8?B?L0pid002eGZSWmNYMFROZkViR01kMGV6cys2bVppemN1bHVuaGdhR3k3UkRY?=
 =?utf-8?B?Y1ZrcmRGUS94eDJmVHZtMXFlWTAydWNzWG1Zakc3RUNPUW1rRUQyM1JZTjZE?=
 =?utf-8?B?RHJuZTRhSWVUY0E0L0JnWVpTWCs0OStaYzdueTNPUHJ5SEd4SEwwU053OTFL?=
 =?utf-8?B?QU8zVUJOS0paNHZRQUo2eEFISzdkeUlUcG0rUkUwQkFFMFFvYjVJdmFTRW03?=
 =?utf-8?B?WnJVWWkxRHZpdEtuTHNNSkVXVGIrei9WQS81RHR1dHhoK1lhMUdGZWNZYVpt?=
 =?utf-8?B?VThuZ3AydnZERTJVa0pmOWQ1ZHV5dzdaSThWcEEwQms2Ri8rSmZmQndXUlpy?=
 =?utf-8?B?ZVhkVFBrMktHd0h5dzFOaGg0RUNTMkxOanpQdGR1eGxNT1N4MENrdEJWVDRn?=
 =?utf-8?B?UUNFczF2c1l3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnRqWVVCMHJEU2d4TkRsdmRCK1E4R29MUUJBMkEvWWkvc2dPS2hVbFJ3WFo2?=
 =?utf-8?B?MUZkSDduaURqTzg3cHkxek5hb01KOUxWdkR1cDhLU3dmNGxhQTJmcHUydHI0?=
 =?utf-8?B?eWRBdWtMby9lY2VwT0xneVJIUGNZeWNqb3BwUFBuekVlbUFvYkpVbFNsVzVq?=
 =?utf-8?B?Nm1oZXRpUUUzMHF1TUhBWlRrN2dlSkx2QlA2UkZxRXF6MW9UKzRjWDRGRmJz?=
 =?utf-8?B?YUlCN1dOdkhDNExHOC9oQ001SlZIYW1aMmFHazdVZE1aSHhyd09DcTZrVUl2?=
 =?utf-8?B?RTVhYVQvWGExRWxHYW5TSm4vODlsSzduTzdxWmp4M0dCRjZaRHdHeFZ3UFBw?=
 =?utf-8?B?UmorYlkxNnVoVFM3aTRYMnRzcER2WmJieUUxSTRwT3JsdDJSSXUxVU9hNzg2?=
 =?utf-8?B?MTg1YnFVRllyM0w0UlhyaENZa1o5QWIzQ2VWNnVLMEorSk85WGRYUGVJRmZ4?=
 =?utf-8?B?b0lCZ3pScDBzckYveEhjVTdMM29Bd3ByVDc1S2hBdWN3UVR3UXdxUVlsSEFX?=
 =?utf-8?B?eGR0NmU1VXNiOEtRQ3dJcHp1WGZSZjByUnZITTRHQmhkMTZZZHNteEtDR21W?=
 =?utf-8?B?MFJOTjNKNzlOTU5oY1VlaEU1aVlZMmdmL1RVK2dLSTl5bngzZnVWcFJzZ0ww?=
 =?utf-8?B?dnkvQXpSUFEvVjVFNlRBWWhJTm1ndmd0TU1pR3dpaUxYZytvV0NQTUJ6Q1FR?=
 =?utf-8?B?aWZrNVFyaUhyVURrN2VkSUxzWkw2NGtFTXBxS2xYeERtQ1ZsMFRPM1R1TGMr?=
 =?utf-8?B?N2thK1Iwc2pTd1NETWIvanRWMTBBYkZ4NUp3WnNIbGg5c0REQXNtMVVaVnRJ?=
 =?utf-8?B?SDJ0Z0txNWhyYVBOL05yOXRZeUhIYndmR2E0TTlMWDlGMDIwQWc1ZUlZRXpC?=
 =?utf-8?B?Mzh6emZPb0psbnArdTZUVm14bVBjKytYbGlQS2hPZXBlQXM3Y3VUTFU0MUpw?=
 =?utf-8?B?WkdGLzAvNkhpY0M1N2NEN3NFaExkdlFXRmZ5TGJzazN6Z0gxdGhaS2xBT2ln?=
 =?utf-8?B?SFdlRnY4dU1OY1ozTFBQR0tmUytBM2YxekNNMUNZRS8wd1pZQlcwUVU0ejA2?=
 =?utf-8?B?Q1NaSHR6aW9FeUlRUnJDVFNST0hQV2dhZ1N5UkFjVGNBOE44ZzdSZmxlK01K?=
 =?utf-8?B?MlNGQXpZbDY2THo1T21MbWJxL25pV2Z6RkRGa2pTRnlIaUlmUlZUc2E1ZjZJ?=
 =?utf-8?B?bHBQYTdPbXdFQVlDZUV5Q005ZFgyMUhvbEVYcEFNcWNIZUp3Q0NNenBBRTVM?=
 =?utf-8?B?T29RQWluQ3Y5VzVGY29PMzdSWitsZGxrcWFLK2VCNzZZa09XOWcwYTA2bnZW?=
 =?utf-8?B?bHcwWFNFcExkZkhoWTNDV3FSZlpWb2hTRnlPaWxTV2RZanlqT0xIbmI5bkM1?=
 =?utf-8?B?ejlXdUNrYjNBMExrb0FXYjBPOVdTYld5M2VPYnNMdDVaSnpkWURraWJkMmdo?=
 =?utf-8?B?ZWNGTEt4dFFwTkM3aHBqUFVUL2crR3NmTmtiVHBkQjJDRjVkdC9DWW9WR1cz?=
 =?utf-8?B?WVZ0Qy91K3dUd29wN2VSRnh4M2hidk9KbkdTOXNVWXJVNHQ4dnNuNW82UlE5?=
 =?utf-8?B?OTQ1OFF5bHNqYTJPZ3hzUU0xOW9XZFoxRnJkMWpsWG9ONEc5d3lhQUFaK0pR?=
 =?utf-8?B?QWJuZkhCVmN3MFRESms3WDVoVUk1SURLdm5IcWZkbnhzL0pCL21xZHhNZ1RC?=
 =?utf-8?B?Z2Z2Wll5aFpsYmUvakpTRGZRdklHcG1XQWhSSW1PSERNZHZGLzlqZ0hIK2Ru?=
 =?utf-8?B?S2hhKzRiWlZtNWVkWEZxVXl2b2ZpSXRib1prbzJUTFQ5STB5cDhUTnJWWWxr?=
 =?utf-8?B?Z21JTnBaZXoyQnNMVUNYNzd1WHZBc2VIYkQ0eUhPNk41OGdYZnhEemszOVVk?=
 =?utf-8?B?OEFpbHJhNFlKQ0JuVyt4SE1Rb3J2cHdjRzFmcGN1VHBnaXh3QW1ScmJQQ2F2?=
 =?utf-8?B?alRBeC91SUZ1K0w4YlNKNGhsc05nU1pqdW5kT29nd28rRTdQQzZVZFF5anlZ?=
 =?utf-8?B?ckE0RmRobmFLVE5xdlNPcXF4MTl1eFpJMzRabzg1bjlyUThjQkJXZStoVHNl?=
 =?utf-8?B?M04wUTE5RWlFSUxPVHVaY1ZjUmhsdStaTGlOS1p6dGNURDlva2I3azlNQlZy?=
 =?utf-8?Q?KCFc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324ebc32-e5aa-43c6-3fb7-08dde53a2552
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 07:20:05.3279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVreYuUWGHhE5B0Kn+qA4Mvu90fOBlJop8hiZXTmClG1nTjcqIXzJBfZK8ZWVun1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFdhbmcsIFlhbmcoS2V2aW4pDQpT
ZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyNywgMjAyNSAwMjoxMw0KVG86IEFsZXggRGV1Y2hlciA8
YWxleGRldWNoZXJAZ21haWwuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
OyBLYW1hbCwgQXNhZCA8QXNhZC5LYW1hbEBhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSF0g
ZHJtL2FtZC9hbWRncHU6IHVuaWZpZWQgYW1kZ3B1IGlwIGJsb2NrIG5hbWUNCg0KDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdt
YWlsLmNvbT4NClNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyNiwgMjAyNSA5OjQ5IFBNDQpUbzogV2Fu
ZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5nQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IEthbWFsLCBBc2FkIDxBc2FkLkthbWFsQGFtZC5jb20+DQpTdWJq
ZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogdW5pZmllZCBhbWRncHUgaXAgYmxvY2sg
bmFtZQ0KDQpPbiBUdWUsIEF1ZyAyNiwgMjAyNSBhdCAyOjAz4oCvQU0gWWFuZyBXYW5nIDxrZXZp
bnlhbmcud2FuZ0BhbWQuY29tPiB3cm90ZToNCj4NCj4gMS4gVW5pZmllZCBhbWRncHUgaXAgYmxv
Y2sgbmFtZSBwcmludCB3aXRoIGZvcm1hdA0KPiAgICB7aXBfdHlwZX1fdnttYWpvcn1fe21pbm9y
fV97cmV2fQ0KPg0KPiAyLiBBdm9pZCBJUCBibG9jayBuYW1lIGNvbmZsaWN0cyBmb3IgU01VL1BT
UCBpcCBibG9jaw0KDQpXaGF0IGlzIHRoZSBjb25mbGljdD8NCg0KS2V2aW46IGFsbCBTTVUvUFNQ
IElQIGJsb2NrcyBzaGFyZSB0aGUgc2FtZSBuYW1lICJzbXUiLyJwc3AiICwgYW5kIHRoZXJlIGlz
IG5vIElQIHZlcnNpb24gaW5mb3JtYXRpb24gaGVyZS4NCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4N
Cg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFdhbmcgPGtldmlueWFuZy53YW5nQGFtZC5jb20+
DQo+IFJldmlld2VkLWJ5OiBBc2FkIEthbWFsIDxhc2FkLmthbWFsQGFtZC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMzUNCj4gKysr
KysrKysrKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMNCj4gaW5kZXggZTExNzQ5NGU4MDU0Li41NzU0YjFmZTc3YmUgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gQEAgLTI0NDcs
NiArMjQ0NywzMyBAQCBpbnQgYW1kZ3B1X2RldmljZV9pcF9ibG9ja192ZXJzaW9uX2NtcChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICByZXR1cm4gMTsNCj4gIH0NCj4NCj4g
K3N0YXRpYyBjb25zdCBjaGFyICppcF9ibG9ja19uYW1lc1tdID0gew0KPiArICAgICAgIFtBTURf
SVBfQkxPQ0tfVFlQRV9DT01NT05dID0gICJjb21tb24iLA0KPiArICAgICAgIFtBTURfSVBfQkxP
Q0tfVFlQRV9HTUNdID0gImdtYyIsDQo+ICsgICAgICAgW0FNRF9JUF9CTE9DS19UWVBFX0lIXSA9
ICJpaCIsDQo+ICsgICAgICAgW0FNRF9JUF9CTE9DS19UWVBFX1NNQ10gPSAic211IiwNCj4gKyAg
ICAgICBbQU1EX0lQX0JMT0NLX1RZUEVfUFNQXSA9ICJwc3AiLA0KPiArICAgICAgIFtBTURfSVBf
QkxPQ0tfVFlQRV9EQ0VdID0gImRjZSIsDQo+ICsgICAgICAgW0FNRF9JUF9CTE9DS19UWVBFX0dG
WF0gPSAiZ2Z4IiwNCj4gKyAgICAgICBbQU1EX0lQX0JMT0NLX1RZUEVfU0RNQV0gPSAic2RtYSIs
DQo+ICsgICAgICAgW0FNRF9JUF9CTE9DS19UWVBFX1VWRF0gPSAidXZkIiwNCj4gKyAgICAgICBb
QU1EX0lQX0JMT0NLX1RZUEVfVkNFXSA9ICJ2Y2UiLA0KPiArICAgICAgIFtBTURfSVBfQkxPQ0tf
VFlQRV9BQ1BdID0gImFjcCIsDQo+ICsgICAgICAgW0FNRF9JUF9CTE9DS19UWVBFX1ZDTl0gPSAi
dmNuIiwNCj4gKyAgICAgICBbQU1EX0lQX0JMT0NLX1RZUEVfTUVTXSA9ICJtZXMiLA0KPiArICAg
ICAgIFtBTURfSVBfQkxPQ0tfVFlQRV9KUEVHXSA9ICJqcGVnIiwNCj4gKyAgICAgICBbQU1EX0lQ
X0JMT0NLX1RZUEVfVlBFXSA9ICJ2cGUiLA0KPiArICAgICAgIFtBTURfSVBfQkxPQ0tfVFlQRV9V
TVNDSF9NTV0gPSAidW1zY2hfbW0iLA0KPiArICAgICAgIFtBTURfSVBfQkxPQ0tfVFlQRV9JU1Bd
ID0gImlzcCIsIH07DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBjaGFyICppcF9ibG9ja19uYW1lKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBlbnVtDQo+ICthbWRfaXBfYmxvY2tfdHlwZSB0eXBl
KSB7DQo+ICsgICAgICAgaW50IGlkeCA9IChpbnQpdHlwZTsNCj4gKw0KPiArICAgICAgIHJldHVy
biBpZHggPCBBUlJBWV9TSVpFKGlwX2Jsb2NrX25hbWVzKSA/IGlwX2Jsb2NrX25hbWVzW2lkeF0N
Cj4gKzogInVua25vd24iOyB9DQo+ICsNCj4gIC8qKg0KPiAgICogYW1kZ3B1X2RldmljZV9pcF9i
bG9ja19hZGQNCj4gICAqDQo+IEBAIC0yNDc1LDggKzI1MDIsMTIgQEAgaW50IGFtZGdwdV9kZXZp
Y2VfaXBfYmxvY2tfYWRkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgICAgICAgICAg
ICAgICAgYnJlYWs7DQo+ICAgICAgICAgfQ0KPg0KPiAtICAgICAgIGRldl9pbmZvKGFkZXYtPmRl
diwgImRldGVjdGVkIGlwIGJsb2NrIG51bWJlciAlZCA8JXM+XG4iLA0KPiAtICAgICAgICAgICAg
ICAgIGFkZXYtPm51bV9pcF9ibG9ja3MsIGlwX2Jsb2NrX3ZlcnNpb24tPmZ1bmNzLT5uYW1lKTsN
Cg0KQ2FuIHdlIGtlZXAgaXBfYmxvY2tfdmVyc2lvbi0+ZnVuY3MtPm5hbWU/ICBUaGVyZSBpcyB1
c2VmdWwgaW5mb3JtYXRpb24gZW5jb2RlZCBpbiB0aGF0LiAgRS5nLiBkbSB2cyBkY2VfdjZfMCBk
ZXBlbmRpbmcgb24gd2hldGhlciBEQyBpcyBlbmFibGVkIG9yIG5vdCBvciBwb3dlcnBsYXkgdnMg
c3dzbXUgZm9yIFNNVS4NCg0KDQpBbGV4DQoNCltLZXZpbl06DQpBZ3JlZSwgaXQgaXMgb2sgZm9y
IG1lLCBwbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2gsIHRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzLA0K
S2V2aW4NCg0KPiArICAgICAgIGRldl9pbmZvKGFkZXYtPmRldiwgImRldGVjdGVkIGlwIGJsb2Nr
IG51bWJlciAlZCA8JXNfdiVkXyVkXyVkPlxuIiwNCj4gKyAgICAgICAgICAgICAgICBhZGV2LT5u
dW1faXBfYmxvY2tzLA0KPiArICAgICAgICAgICAgICAgIGlwX2Jsb2NrX25hbWUoYWRldiwgaXBf
YmxvY2tfdmVyc2lvbi0+dHlwZSksDQo+ICsgICAgICAgICAgICAgICAgaXBfYmxvY2tfdmVyc2lv
bi0+bWFqb3IsDQo+ICsgICAgICAgICAgICAgICAgaXBfYmxvY2tfdmVyc2lvbi0+bWlub3IsDQo+
ICsgICAgICAgICAgICAgICAgaXBfYmxvY2tfdmVyc2lvbi0+cmV2KTsNCj4NCj4gICAgICAgICBh
ZGV2LT5pcF9ibG9ja3NbYWRldi0+bnVtX2lwX2Jsb2Nrc10uYWRldiA9IGFkZXY7DQo+DQo+IC0t
DQo+IDIuMzQuMQ0KPg0K
