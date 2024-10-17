Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18C9D37487
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D50210E81A;
	Thu, 17 Oct 2024 13:07:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U4yCNTMo";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 994EF10E81A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKNRp2MNAgAX8u0rlwCJhfifYmkfy0x/i9usB2ooIZOT319NrgineLWAFY2VhmBaIPtHTPP2I5rx3fsNpG3iabaXKZlGTA8WrX6wXLUFzowKFef8LTTdOrKrscdadGZCElGRURUBOxJLBl/XsET4TB2nKPDru+ffrHSJVbLBhoQBmPJ1dx39Mg1QKRsh8AJu0Bi3Dqr4aDsETDMGOMBWMLZWgxOsYmnVRSFzhW81FMIci7fuWRPA6kL6eP82hyhjuRIWMrGabeCstp2UZ2v3WSTGt4daAseA/glHZRYMIuaDhNGDaitG4nfZ4SDpQu0ikoLRtflS7F9AIaA2dEM5Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La2h0kMXeUHod3j1WcHcGPMDTyM49W6m0RQ86nUtoiI=;
 b=cT06dMGwTOZOmKztfcPn6GYNXndODLzXpME/LVK8aBBfIiVS8f0LYEWN5aYgU6bQ6NMym6MyTLAUFPiy1AqJWam0yl87mADHHZ1Y00peZC/4v5TjriJKpdpyTLJKTfqBz7E4GVTt770Fs2NF7LTz0M+BfQbnKcdZdtc7d1pIdeFZYzCTPYhzheTXkCIDLLH2cR6vY8f/QVYfTxT5Lurr0D+Nm4Op2pZZYBTiFCWwNtxgO0Hz5V82y34/vuCJbLnlJ9vlV7op1cSihsE6u+lYsmevqhdC+DrWEaB4WM7uHWTPeVO9ktVkD/rLbAJIO276TmSnn1vbUL1jEeoAy2//Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La2h0kMXeUHod3j1WcHcGPMDTyM49W6m0RQ86nUtoiI=;
 b=U4yCNTMo221UO10VpRIukpT6tDr6H+avJJ+MCqPwLvVLertMEN/xkLjUCqTVUxY8Q9wuAriufCH4nu5+8ZoOXRPxNi7BfmMkvfxwhf5ui+H39r4gm8t1zIm8RP4qKV934L8ma5XVKXPSQL4QuiAzkdQ0axKwYWfIzYcmOOmYMqE=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 13:07:44 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080%4]) with mapi id 15.20.8069.020; Thu, 17 Oct 2024
 13:07:43 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>,
 "Zhou, Hao (Claire)" <Hao.Zhou@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Save VCN shared memory with init reset
Thread-Topic: [PATCH] drm/amdgpu: Save VCN shared memory with init reset
Thread-Index: AQHbHsrLxm7tqLwrx0GjESM6xLaItbKJXZSAgAAt32CAAL1tAIAApEQQ
Date: Thu, 17 Oct 2024 13:07:43 +0000
Message-ID: <CO6PR12MB5394D8B004517BD13D463C6BE5472@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20241015062316.3050046-1-lijo.lazar@amd.com>
 <7cd47976-10c9-41d1-9e48-8b47617b3d48@amd.com>
 <DM8PR12MB53993F24544631CE138C41EFE5462@DM8PR12MB5399.namprd12.prod.outlook.com>
 <8ede8dfc-1718-416e-96c5-e6033c5bfb87@amd.com>
In-Reply-To: <8ede8dfc-1718-416e-96c5-e6033c5bfb87@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5f0da209-c5d2-40b5-96f6-a7b715e93047;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-17T13:06:22Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|CH3PR12MB7497:EE_
x-ms-office365-filtering-correlation-id: dcc5eee4-5f0c-418a-23c3-08dceeacb03c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZTQxSUQwSzY4eGQ5TGhPRkh4NFFrRDJNYnpEOWRzSHk2WXgyaFBGeWhmeDhS?=
 =?utf-8?B?T0NoZFFvaGdvSFhYMHBJRVFuL2VITTF2Si9UclVHdWY3Y3J6dGZ4Ujd1ZkY3?=
 =?utf-8?B?em9MR0RJeHlETnFNRkpoaDA1MG4vcTJmaE1NS2VxcGRJTnpzTStVOXArcVFM?=
 =?utf-8?B?elNLbzk0U1VjdCtXSFJGN3RvUXJJay9oNmVDMmUwQUkxRUJYODA4akdJVkJu?=
 =?utf-8?B?Mi93YUtzajUrSXdHT3NFU0tyVkkzaFY4bU81WUMxNk9kTmh2bjM3WnR4MSs4?=
 =?utf-8?B?OXRYNDJEQmhDWm1IaERkeFVDKzdKbzgxeGNuQTV1RDZ2bUVoSHJxMzhubGdF?=
 =?utf-8?B?UVpkdzEzQVRHRjhMVUc2dUJTU2xROHJvcXptWHgzNjc1WW0rS09rNFMwdG81?=
 =?utf-8?B?MWJFV0ZMVHlBYmlpOC8yY25mOEszcWlkS3kxN29POXhUR3dyb3NJbG1YZVFU?=
 =?utf-8?B?c21qQzdiMFdxek56SEVCQXE1SWRndEVhcGNDU1F5Qkg2RG5aYUFkdWlFd1VI?=
 =?utf-8?B?MVlIeXpDam1DRFZMZk1ZQlFSR0dKSkYvY0FHL2xmOHpZL2MvUmxSVFpCWU5u?=
 =?utf-8?B?QThwcnNPYmVYVHVUTEtNanE4RUIxbElFbXBQQ3Q0b1IvaW5ndkRKM25ybHBL?=
 =?utf-8?B?ci9RRHJGcWZqV1pkTmxZWWNqUFVDeVpualIxSCtvakJyUWx2REUvUTNvakF1?=
 =?utf-8?B?Q0NYMTRKRmJBTlZpL0JsY09WK1dGdWY4NnpidHUweUcxaUYyUENtcTRHR1Vx?=
 =?utf-8?B?UFRKMXg0SDdQUGptL1BtcnBrZlRVTnJTRkdOVkZMTlpKQVBNTlRJM2Ezb2J2?=
 =?utf-8?B?NXFxd1A4MFR3UDJndzMrRnBBODJaZjBXeHprS0FhZFVMeXNybHVOZUpibUNk?=
 =?utf-8?B?Vm5Da1puYjNvSFRLQ3lmQUk2TXl0QzVpVTVIL3huSUZVOTBYNU52MVlVNFhD?=
 =?utf-8?B?OUw3aWJ6V2FvTzNZWlE5TjJ3RkQxM1VsNjhDN0hDaldwY0NtMVdFWm0rZ29T?=
 =?utf-8?B?WCtqSTM1ZDd0ZW43b3RzMHFTQjd2Y2dWVk9SNEg3dGh2eDdXM214eUJRaU9X?=
 =?utf-8?B?ejVtUENKZUl2VnJINHFhSVBOOFBQSTlmdU5odXlsV0VBTTdpOVp1MWZSYkxB?=
 =?utf-8?B?TFZMTVpZR0lLUDhRUjBHTkpyQzE3T3R4REc3MUlHenNieDJrUXpPZ05RU0Nr?=
 =?utf-8?B?VUp4aC9uU2F4aldWekRacHd2djN6UFkvZXgwZ3lmR1cvem12NURzblpSOUx6?=
 =?utf-8?B?cGZYZ3VKazM2aklWeFBPaDlYY2E5amJwZEJGOUdvKzVzV1dmYmdXNWlIMHJu?=
 =?utf-8?B?VHpSUkhwV2dTSmZ1MHN4UXBCc1ZTb0VyenRacVJybkFUQS9meHFQN3ZxMEZT?=
 =?utf-8?B?VkRXR2hkRkZFNjRsOUg3c2RIbDJnVDExZElvVlB4R2VDL0NVTXplancxeHBx?=
 =?utf-8?B?M2M3VEY2VitSS2hFWTFZZkd5NHczcTBrd1E2MlF5YnptOEl0N2Z0ZVYzZnlx?=
 =?utf-8?B?Ly8wL1dMS1Z5YTZSMU52S0k3OE5tNEVvL2d4VjNEWkhtR2hCWGNONTVXeEVS?=
 =?utf-8?B?b0F1WWo0TUc5Z0NNbFhqQ0JCeHlEWUVxZzB4Mk90akNFamtrTmVoTmtGZnI0?=
 =?utf-8?B?NWJ4SEo4KzAvYUo0alVvUlhLM01aZWZTeFJUOENtVEtoZm9lSkRQS2tqamRT?=
 =?utf-8?B?eDViNFZwMGJyR05zVUVibFhrdFdObFhIRlhNNkpiZFRjUzVTTERiVXFaTGU0?=
 =?utf-8?B?V0ZqMWpmVHBtcG8zT2RPZFBIN1BleTQ0NFBJdE5hS0hNRmVKWGdmZnlpQU56?=
 =?utf-8?Q?itTL8Ls/+Gr7K2axTxdwKCPn9CR7fDHnZnImw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXZBQlByMlMvT00zTU5YcU5Lc3dLdUNBc1JORWpQKzhTb01XRU5md3NrejVl?=
 =?utf-8?B?Z1M5V2RRaTBqSWc5ZHV6OG12Rk5OaXNNc0RQZlgyQ0xCNWU1WGNGdGlJN2Zy?=
 =?utf-8?B?bDBIc0VDUDZlTm9ET1RHNEtXM3BCazRRTGNUZjlvYnRkekdqcWdZUGFpQjVi?=
 =?utf-8?B?b1RObkQwQ2k2UFFKZm9UNlV0MkFTam10R3BMT0x0bHhaNjRadWswSTgza3Jx?=
 =?utf-8?B?b0RsUzBtRk0xb1NNOW14VGE0ZnJrbVRacG55Y1hVTU5KY2cxNE1aSWtzMDFE?=
 =?utf-8?B?M3pvQkpqMi9oVVJsWXpuQy9DSjc3Ri81S0NyTnZRT2NyV2RCVGNwMDBGWDha?=
 =?utf-8?B?SmZaZEUybjBZUk1BTmZwbWRzUjY5ZEdpaW1OaE5EdzNEVk1nV1BraldSd3FD?=
 =?utf-8?B?Z3VJcDlSMjc5eHZJVm5sbjNBemZaOEI3M2I1SmVlRWFUaVBtVFhRcncxbzVv?=
 =?utf-8?B?ZVZtY1dtRkpQVHNINWttc1lZTEVJUW1XcnNwMWk2SStXYVd5TUpueDRkdUQv?=
 =?utf-8?B?UWRNVmhac1I3MWgvYWpLSVArZXd1eWdHNTBTdTdDdEZWQjBCR2I2eFlvNUMy?=
 =?utf-8?B?VFVCajByVHhyNXNMcVFrVnpmZithVjg3WTkwUUdhSURhanZya2xPeWVjSzRX?=
 =?utf-8?B?YnN3WVVNVkVmdzErZ2dnM1pKZlh2U3VMMml2M2dqZVI0TDJVUWtNZU5qQW5Z?=
 =?utf-8?B?Nm9kT2ZWRTM4UVVRNlowQ01XREpPdFRucG9oanNwdXpXb2dEY2JsY0d3WXRs?=
 =?utf-8?B?bS9NTWcvYWdQSkJnVFdhdDM4eDdJNXlnQnNUTkttblFCeWlIeEdaK0l1bnEw?=
 =?utf-8?B?azE3a2tmS3phMHZneW9xcmVNNnNnbmV1MHhOTThERnZSMURKM2J1YU1aKzhm?=
 =?utf-8?B?d3JRNHJsNTk0bXk2aEFjRVY2UjFIY0JMeW9QdzI0eFlTUlEwSkQ0Qmo3Ni9V?=
 =?utf-8?B?bUZ0QmIyczltSXlneTFxbERHWmZ1YWROYis4anptWVNLNUl1WG0rUUVSeEdT?=
 =?utf-8?B?SWU1L0VWcCtiQjEvUWJwZFF2UzBGa05vYXhWU0xRQzcvb3NHMS80TWNxWHdt?=
 =?utf-8?B?MGV4bHBLTWw1azQveHpRK0RNSXk1SXRwM0FsYUtTQUtMWW8xYTlxVFNPc1Iz?=
 =?utf-8?B?bG1nSXBSZDBWeEFWMmgwOXJjcjhtdVdwekxjOGZEL04rUHVTRWZYUWZWckJD?=
 =?utf-8?B?cm9LSFlsd0xCWGEzNGRjNm1tMS9uamNqcFFna1R6VEtjSGZTSENJTEZ0RXdO?=
 =?utf-8?B?aEhiNnZXR1U2eG91OEpwVE5oYnFPTzVObHZIVDlrSUpFWDZwb3ljZDlyNGIz?=
 =?utf-8?B?Z0JGQU13bWRyMDUra0FHRWNkanlGMFRhcDJHVlB2UzUvTkEzNUk0b1dpZGVa?=
 =?utf-8?B?TUlYaCtDaXExVWNkMytaMlZ0cVJtR2dTVTVOaTlCWHBaQnVOVTNBd3VPVU9l?=
 =?utf-8?B?cU91Z0lXTVdKV1ZvNU8zaHVLeDY3dmZCR0x0bVl1UXFFV3dFa0owbDdLWHpS?=
 =?utf-8?B?YmpKeDdLaGhHa3ljQTU2ZWg5U2NFY29aem03VzJsaWJsbE0wWEpKc3dqMzgy?=
 =?utf-8?B?UG1rampvU1YyZnBSZWZyVUttbWQ0SmVRa2N2SlpzR0xpcEYrNmU5b2FicHlG?=
 =?utf-8?B?eTNMck02NjM4YnU2TnpMUXM3UldkYVBBZmxtYzJsY0QwUVNSWUkrUWJ6d09j?=
 =?utf-8?B?dWVDczF2clRjNjFxQkY2bkxBanN2Z1FCT1NBODJvdlJuRmNiSjJIRmxic0dH?=
 =?utf-8?B?UjBOc3ZsRGdsdVIxR3ZFZnlhSUNyWnpDZk5wSnhzV09RTUM2MngrWlNXSS9V?=
 =?utf-8?B?Qnl2U1JSbUdOSVZPWVFrTEtDRDk4NWtUclI4RDZpWUpzbHY5Z1ZWaEhxaUJJ?=
 =?utf-8?B?M0JuRkFNd0kzVUtrT1dpUUptOWZtMldWeDY5TXpWQmI3VWYwbzdrcXA4K21z?=
 =?utf-8?B?cXNXeHB5Q3M2WTc2cGVmYnZjZ2czNTlma0NWM043MUY1NGlOU1c5NmlJY0VB?=
 =?utf-8?B?bHNBMnF1VVNHSmNHSURtOHZkeDFHejV0UE9aMXo0aDRkUWZoZXhod3BrZXBB?=
 =?utf-8?B?dmtpSkVNZkhiT242clZQUENsdzVFKzUwRSs2VTUvVUFwUjI1cjRYNDB6ZmtZ?=
 =?utf-8?Q?VETQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc5eee4-5f0c-418a-23c3-08dceeacb03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 13:07:43.8136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XST0DAh/rhqiSbxki/b+FqfWJDlxHUvdU+UBhTzVNh03jJrjEJkpkPLrOHEMoxCY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlq
by5MYXphckBhbWQuY29tPg0KPiBTZW50OiBPY3RvYmVyIDE2LCAyMDI0IDExOjE4IFBNDQo+IFRv
OiBMaXUsIExlbyA8TGVvLkxpdUBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENj
OiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFu
ZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgU3VuZGFyYXJhanUsIFNhdGhpc2hr
dW1hcg0KPiA8U2F0aGlzaGt1bWFyLlN1bmRhcmFyYWp1QGFtZC5jb20+OyBKaWFuZywgU29ubnkN
Cj4gPFNvbm55LkppYW5nQGFtZC5jb20+OyBaaG91LCBIYW8gKENsYWlyZSkgPEhhby5aaG91QGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IFNhdmUgVkNOIHNoYXJl
ZCBtZW1vcnkgd2l0aCBpbml0IHJlc2V0DQo+DQo+DQo+DQo+IE9uIDEwLzE2LzIwMjQgOTozNyBQ
TSwgTGl1LCBMZW8gd3JvdGU6DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRl
cm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQu
Y29tPg0KPiA+PiBTZW50OiBPY3RvYmVyIDE2LCAyMDI0IDk6MTYgQU0NCj4gPj4gVG86IExhemFy
LCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsNCj4gPj4gTGl1LCBMZW8gPExlby5MaXVAYW1kLmNvbT4NCj4gPj4gQ2M6IFpoYW5nLCBIYXdr
aW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPj4gPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBTdW5kYXJhcmFqdSwgU2F0aGlzaGt1bWFyDQo+ID4+
IDxTYXRoaXNoa3VtYXIuU3VuZGFyYXJhanVAYW1kLmNvbT47IEppYW5nLCBTb25ueQ0KPiA+PiA8
U29ubnkuSmlhbmdAYW1kLmNvbT47IFpob3UsIEhhbyAoQ2xhaXJlKSA8SGFvLlpob3VAYW1kLmNv
bT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogU2F2ZSBWQ04gc2hhcmVk
IG1lbW9yeSB3aXRoIGluaXQNCj4gPj4gcmVzZXQNCj4gPj4NCj4gPj4gQW0gMTUuMTAuMjQgdW0g
MDg6MjMgc2NocmllYiBMaWpvIExhemFyOg0KPiA+Pj4gVkNOIHNoYXJlZCBtZW1vcnkgaXMgaW4g
ZnJhbWVidWZmZXIgYW5kIHRoZXJlIGFyZSBzb21lIGZsYWdzDQo+ID4+PiBpbml0aWFsaXplZCBk
dXJpbmcgc3dfaW5pdC4gSWRlYWxseSwgc3VjaCBwcm9ncmFtbWluZyBzaG91bGQgYmUNCj4gPj4+
IGR1cmluZw0KPiA+PiBod19pbml0Lg0KPiA+Pg0KPiA+PiBJSVJDIHRoYXQgd2FzIGludGVudGlv
bmFsbHkgbm90IGRvbmUgZHVyaW5nIGh3X2luaXQgZm9yIHNvbWUgcmVhc29uLg0KPiA+PiBATGVv
IGRvIHlvdSByZW1lbWJlciB3aHk/DQo+ID4+DQo+ID4NCj4gPiBXZSBuZWVkIHRvIGtlZXAgc29t
ZSBvZiB0aGUgc3RhdHVzIGZyb20gc2hhcmUgbWVtb3J5KGRyaXZlciBhbmQgRlcpLA0KPiBzaW5j
ZSBzb21lIG9mIHRoZW0gYXJlIGNoYW5nZWQgYnkgRlcsIHRoYXQgaXMgd2h5IHRoZSBpbml0IGNh
bm5vdCBiZSBpbiB0aGUNCj4gaHdfaW5pdCBzdGFnZSB3aXRoIHN1c3BlbmQvcmVzdW1lIGNhc2Uu
DQo+ID4NCj4NCj4gRm9yIHZjbl92NF8wXzMsIHRoZSBmbGFncyB0aGF0IGFyZSBpbml0aWFsaXpl
ZCBpbiBzd19pbml0IGFyZSB0aGVzZQ0KPg0KPiAgICAgICAgICAgICAgICAgZndfc2hhcmVkLT5w
cmVzZW50X2ZsYWdfMCA9DQo+IGNwdV90b19sZTMyKEFNREdQVV9GV19TSEFSRURfRkxBR18wX1VO
SUZJRURfUVVFVUUpOw0KPiAgICAgICAgICAgICAgICAgZndfc2hhcmVkLT5zcS5pc19lbmFibGVk
ID0gdHJ1ZTsNCj4NCj4gICAgICAgICAgICAgICAgIGlmIChhbWRncHVfdmNuZndfbG9nKQ0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfdmNuX2Z3bG9nX2luaXQoJmFkZXYtPnZjbi5p
bnN0W2ldKTsNCj4NCj4gSXMgdGhlIGZsYWdzIGluaXRpYWxpemVkIGR1cmluZyBzd19pbml0IHJl
cXVpcmVkIGZvciBGVyBkdXJpbmcgaXRzIGluaXRpYWxpemF0aW9uDQo+IHN0YWdlPyBJZiBub3Qs
IGl0IHdvdWxkIGJlIGJldHRlciB0byBtb3ZlIHRoaXMgdG8gaHdfaW5pdC4NCj4NCj4gU29tZSBw
YXJ0IGFsc28gZ2V0IG1vZGlmaWVkIGR1cmluZyB2Y25fdjRfMF8zX3N0YXJ0ICh3aGljaCBpcyBh
ZnRlciBod19pbml0DQo+IGR1cmluZyBydW50aW1lKSAtDQo+DQo+ICAgICAgICAgICAgICAgICBm
d19zaGFyZWQtPnNxLnF1ZXVlX21vZGUgJj0NCj4gICAgICAgICAgICAgICAgICAgICAgICAgY3B1
X3RvX2xlMzIofihGV19RVUVVRV9SSU5HX1JFU0VUIHwNCj4gRldfUVVFVUVfRFBHX0hPTERfT0ZG
KSk7DQo+DQo+DQo+IE9uZSByZWFzb24gcHJvYmFibHkgaXMgaHdfaW5pdCBpcyBhbHNvIGNhbGxl
ZCBkdXJpbmcgcmVzdW1lIHdoaWNoIHJlc3RvcmVzDQo+IHRoZSBzYXZlZCBibyBkdXJpbmcgc3Vz
cGVuZC4gU28gdGhpcyBtYXkgYmUgdG8gYXZvaWQgdGhlIGRvdWJsZSB3b3JrLg0KPg0KPiBBbnl3
YXksIGlzIHRoZSBwYXRjaCBva2F5IHRvIGdvPw0KPg0KWW91IG5lZWQgdG8gZml4IHRoZSBmdW5j
dGlvbiBuYW1lIGFzIEkgY29tbWVudGVkIGZyb20gbGFzdCBlbWFpbC4NCg0KUmVnYXJkcywNCkxl
bw0KDQoNCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+ID4gICtpbnQgYW1kZ3B1X3Zjbl9zdXNwZW5k
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSB7DQo+ID4gID4gKyAgICBib29sIGluX3Jhc19p
bnRyID0gYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpOw0KPiA+ICA+ICsNCj4gPiAgPiArICAg
IGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmlkbGVfd29yayk7DQo+ID4gID4g
Kw0KPiA+ICA+ICsgICAgLyogZXJyX2V2ZW50X2F0aHViIHdpbGwgY29ycnVwdCBWQ1BVIGJ1ZmZl
ciwgc28gd2UgbmVlZCB0bw0KPiA+ICA+ICsgICAgICogcmVzdG9yZSBmdyBkYXRhIGFuZCBjbGVh
ciBidWZmZXIgaW4gYW1kZ3B1X3Zjbl9yZXN1bWUoKSAqLw0KPiA+ICA+ICsgICAgaWYgKGluX3Jh
c19pbnRyKQ0KPiA+ICA+ICsgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiAgPiArDQo+ID4gID4g
KyAgICByZXR1cm4gYW1kZ3B1X3Zjbl9zYXZlX2Z3X3NoYXJlZF9yZWdpb24oYWRldik7DQo+ID4g
VGhlIHNhdmVkIGJvIGhlcmUgaXMgbm90IG9ubHkgZm9yIGZ3IHNoYXJlZCBtZW1vcnksIGFsc28g
Zm9yIEZXIHJ1bnRpbWUNCj4gc3RhY2svaGVhcCBhcyB3ZWxsLg0KPiA+ID4gUmVnYXJkcywNCj4g
PiBMZW8NCj4gPg0KPiA+ICA+ICt9DQo+ID4gID4gKw0K
