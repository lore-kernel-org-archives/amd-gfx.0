Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AD0E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 16:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8472410F120;
	Fri, 10 Jan 2025 16:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qjFJkYcp";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44EB710F11A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 16:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPoDa0kLImkCWzmf/LoL9WUl8sYCFn+FopxWTTve9kj/yoh3IF6Y+N4Y/FWuNFJ62UgDaZzPCYkNUECEF4vot890rYbm9pIR/MVP3iu5nM5psBBgt+zIho4aGOnfOhv/6yB60fxKM+8+K3FQzyn8n8z7iqavsZ9DbNysI0Vf0dzG1rvfatmhD/FI/rCUdkF6jpa+LYIW5GLshLHdGIgh99/Za5y6RVHn9T/taytPgaMntteOpsQ8cEtF6m1zWD58YdjdIH7VIVD6DsGAYe+59WR3M6b0VlTUaSp1vfmEx4x6CjaCWIHSRuo2w54u33dns7j+vexvuIJVGPzCNvOWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pARCMpNGDP4yqWo2WoxXLY4jNslQfjhc5qcddaUgPYY=;
 b=Pmq289+tPk3IQ118GwAlhum54V+oIhFvsWdrvitdgppT+aC7t+NQAo0BhsXvHV/8HdMRYDzTISuplmITTMZRHZBVIQcEUwnPIA0w5vmvJLdry4w4Bb4CHWDM96rSYmTsvJlI4HQ8SGyDfpElwAODXm/ki/71kXQy5o8AQ8cSIdQTsY7m+A8aH6gcRuR7kMHFVSQPczL2IrrzIVx6ZE/qkJdnYlA7IDM1WTREoMBYA8JpoxrbWgH6Qc0ELqAKu8wwiOCLSmuzxI0bgeOo6arRFpeXkLQTrKKBAoJBDg89J9n1sYZz54zBI7Zck8Bck5ndlwSDnOPtm1kwqwO+Z1biug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pARCMpNGDP4yqWo2WoxXLY4jNslQfjhc5qcddaUgPYY=;
 b=qjFJkYcpHitmIzhhbMb7Vwdlk9t8gX/3JkKOMd7/YA3p2STowIUKUSO4n/LzMLk6QQLFSTQmfBQLTCinKMqwObRru500mmzm8akLWA7XyUUpuXAtyWGvq7eRggQ7p3A54yLMSn0KCvCQ+Pnq6d69VYzGLD0avzdMfCpaUQY7NaQ=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 16:13:11 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 16:13:10 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
Thread-Topic: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
Thread-Index: AQHbYggg7TRtauGCh02VRE8z9Mjnf7MN908AgACHIuCAAN/YAIAAy7mw
Date: Fri, 10 Jan 2025 16:13:10 +0000
Message-ID: <CY8PR12MB743599F7DD753244994863C6851C2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250108200121.2808908-1-jonathan.kim@amd.com>
 <0ab5d4aa-ac2c-4108-99e5-902f73f827bb@amd.com>
 <CY8PR12MB7435645F2AB787B7BC57BB0A85132@CY8PR12MB7435.namprd12.prod.outlook.com>
 <f7a71dc8-7643-431e-8c92-ade74619ef2c@amd.com>
In-Reply-To: <f7a71dc8-7643-431e-8c92-ade74619ef2c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=528e8275-ffdc-4dba-94f8-5f524bf090f1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-10T16:13:01Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|IA1PR12MB9061:EE_
x-ms-office365-filtering-correlation-id: 0f0b4692-f1d3-4cd9-2e7c-08dd3191ad4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bk8wa2tVSlZRSjBFakZienlpQWdWS29CSTloN0g2SW4wZE51U0pFMWplZnU5?=
 =?utf-8?B?RHF3RTM1RjN6K1RoSGlpOXA3VHhoaHRKeG5MZUZrZld2K3YvbGtCM25odkg0?=
 =?utf-8?B?RTRvWVJ6UWZJQi9URVJrYlFDYXR5dFB6QWdCNUd2REVlZ3ZXbTE5QjNRc0V4?=
 =?utf-8?B?WThsblk5TG12aVZNOHVEdnVxdStxTlp0Z1NzN3VKem41ZkNZWlJGYktZdGdk?=
 =?utf-8?B?OXFCb1hUNlNIZkxHbE5JbklScWRpOGs3cjBGQXJxcmhmNUlGRzV3SHBaeWc1?=
 =?utf-8?B?NDh5MHFQOElwcDdUS2QvYW5zNEVmN0lzbVdBV1pNYUo5Vi9Gd2xmR0NSNGtB?=
 =?utf-8?B?U0sxQ3dVeWRXMUhpNmFFa2pPVUprYjlhMGZOMXhvbjk0TTh0OEp4K1NDejE3?=
 =?utf-8?B?RkhkeUJHaVlzVCtIRXBSd1Z1UDhXcFh5aU9ZTUhadlpnZ2pHK1VPRi9qSDFj?=
 =?utf-8?B?enVUQXJoT2ZEOEpDZGROWTdGT3g2cWxXQlBDaGFRV3pVT3EyMTBIaGVWVDFn?=
 =?utf-8?B?QUpyVDh3eFkrakpla1FmaW1rMUh5c2FlWjYzRUdJNmhndWhSampacFNzczlE?=
 =?utf-8?B?NjQyUkc0WTFhdUlOQkZNa2NaQ1NYOTBNY0F4Y0JlLzFtZWJ3K3c1TUVwRmVo?=
 =?utf-8?B?M01LYnoyMXhYaDFaeGdoaWJ0a1NnaXN0RUE0QU43Y2VMdklNeGV4UU42M2xs?=
 =?utf-8?B?SjdObjVEQ3RIK3hoaW11UE00Y1J0VXpLcUY3K2lHUkk1ZG91Umlwc3VlZTFh?=
 =?utf-8?B?T1lFWW9HQkFoT0FoZnJ1UFZZelUvdzJYVnJSQlNWSkVRcVljRmxacHg3VytE?=
 =?utf-8?B?eENlN29rc3BHQzduREl4SmhZbHdROFdPSWhBZlNIYmp0QkNET2tUQjhNTlI2?=
 =?utf-8?B?K0VhQ2ZselhPQUtUU1RjeTRVeE1NWmcySTN1dDJKYk1Wbmhxc2M1RlVaR3ky?=
 =?utf-8?B?WDdoTlVFTWhIVHZSL294NTI4RDNtV2hFcUtLMXRnU3gwN2RnRmp1M2hXRnA2?=
 =?utf-8?B?OTdaU2Y4elcwU1BzYjU0eWV4L1BNYldwemdwM0JQUFNrYTVtalJKVjdQU1dV?=
 =?utf-8?B?WDZrdkl3SjlnNi94Qk8va3RVNTBCUUZzUlNQanJBYlp2YzhYQWdzY1JlS3RR?=
 =?utf-8?B?THJwNnZGYlFJQThhY3pzVjBPNUtWU0Jud1pTYkNsbGdaM0JPSmgrYW5OV0Vr?=
 =?utf-8?B?NlVmZGd4dThldDBEOVEyK2lXb2syYk5rS01mMEtOWGorSUtJVkJrNVdXRTN5?=
 =?utf-8?B?Z090T2NzS0RtSXlWZUxuai84ZW5VOThRQkVCLzgvL2hYWm5hbG1aS2V6cEho?=
 =?utf-8?B?R1pEMmVLWmNDcG1HWGRaVHlxYStvRXcwZkREeWFnWDFrNHdISjU5RVU1Vmp4?=
 =?utf-8?B?VkIxRGJOaTFEa3NSSEdrbjFDR2hXZWEvTDJDd2JxQU0xaGFFRnJoMzVEMmp6?=
 =?utf-8?B?TVN4VktOR3k3aTVuVUZxVHZpSGF1TzJtYWZqU3BjK1JiZXUvcnpDR3lReVlD?=
 =?utf-8?B?NSsrWldpY1FUZEZtWHJoOEJDTXR3bmllRlhQOG9LSTFZYVUxOWJid1RSQTVI?=
 =?utf-8?B?c3VTL3c1MkFpSVdnTmVXbTk4VTJmcWNVR1NoRUpSNUpFNWVvVVM5eW9UZHR0?=
 =?utf-8?B?b2RraTJLYkpZeG9meXV1Z3I0cUl6YUlzU09mWCttRlpIV2xsUGNPc0RXamxv?=
 =?utf-8?B?dXEvc1dVcjRIN3RDZTF0SW93ckRYcXJXMlJxYitnTzVobjV0OHYyL1J4YUlv?=
 =?utf-8?B?dmlLeGVlOVhGYkU0NmxUTjJQa3hpUjlBaGN1ZVBTSVd6eFI2RHNBNVB5ckZy?=
 =?utf-8?B?SndEWGNWejdrZmpqUENyR20vMkh5dSs0WC85TjFHVjR1V3VKczdSdnczZjFP?=
 =?utf-8?B?SkFremdSUHlFeHg0Ym9RbFlJaXEyMU9KLy9QQlJjdENwTXdiYXR6ajBpaEVN?=
 =?utf-8?Q?h/rq7Hk+9W9i/0Ktkd5a+ZxtZhqjiZbS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUJPczIvbHNLSCsvbWlXZlBYMHVSZFdUK1dkNHdvN2FabzFYbWFCc1lyUXJx?=
 =?utf-8?B?cE42VHAxbXljVjBNUXVFMVhuY3V5U3M3YjEvSGpITmw2dVQvZE05aU5GUDBO?=
 =?utf-8?B?TzgwMk10MjRZUmt0YVRnaG4rR1VlYzBJRGJqaXFtbDRXL1dsc1FPL0NSYkNF?=
 =?utf-8?B?ajlVK2pUdEJFOHk2dlk0Ly9mMXFqcXVjUndOMTZtK3hRcnNpOU9TWXVzMWtT?=
 =?utf-8?B?K09BRnVibHlEc3lPN1Q5WjZnYVozWS9LM0dkS044K1pVKzdLRnRhTVFWMlI4?=
 =?utf-8?B?ek1hQ0lWcTl0d1pjRUg2N1FwM2I1SEZjQnUrMFVVTzdqc1hXVmZLVVVMaElC?=
 =?utf-8?B?UHhRamxNN1FPWWgxZ0lSekpXaFpVaUlTVlRYTGhoTEh0b2ZoNTQzQXp5dXZF?=
 =?utf-8?B?QjBha0FCK3ZwWFo5dUI1S1N1aldzQk1RMnVRMG9KMVhkRXFXZUtDMW9oek1S?=
 =?utf-8?B?TS93TkI4UEo1a1JaMnd5Y2d1MGh4RUlaRHl1ejltTE5RYjRBSGlBSzUwdnRn?=
 =?utf-8?B?R3VNcmY0RjVGODdCQUdhbTVIR21sRFM1QzdvS3B0QnplbE1JcUQ3YlFWWW12?=
 =?utf-8?B?L256MGNQeU9JK1UxNjg2ZUd2QVd3UWZDejhJbHIwZFNHV3o4S2RvL0Q1a1hL?=
 =?utf-8?B?ZFdNNnh0QzBLNDNpdXRoYWNwK1c5Z1dTeCtCakRSbzhEYmdYcm9HLzNTMDln?=
 =?utf-8?B?OWRPVTNFMTk0YStzNlBjZ0dwQ092OS9ydHg4ZlNxYW5PclVlTVlXZHNncGJk?=
 =?utf-8?B?S2kzTGdRS1N6VE5NekZ5NTZBQ0ErbU9EWng5bEN0anpjWjZiZnRRWW1BWElY?=
 =?utf-8?B?ditOWXRTOEI4dGl0dSs5NkF5d2RoY04yaTFxdm81Nzl0WWdNVEZSOW1ZZnla?=
 =?utf-8?B?UXdCSkRqOFVrN24zWldOUFBCS2JkMzI3elRGbm81amFQNEd1NUlrKzhjcThC?=
 =?utf-8?B?a09rSVhNUkxmWlMxUDNJZVVwS3R2akdhc1YxZUJzVG5uVC9UM2Vza2lSNkZT?=
 =?utf-8?B?YVJXNGlVTUJoZXBHZUhDSFNHSFBDSlR2SHpERS9aeldSd2E5Z1RNVWhoSnU5?=
 =?utf-8?B?UHZncDYxcXUzUXYzclVsa3Z4Y0JOQVp2QlpXdVpxRG5TM3BpMFFVeGVWNDhh?=
 =?utf-8?B?eVVJc2ZsRjFKdmVmQ0c3Y0dZNDJLYlN5UlpKSjRKMlVUcXZyYlp6NW8rRVNE?=
 =?utf-8?B?S2tOd3lsMURqaEZIemtkTjk5eEpRYWM3TzZFRDlRdkxGNE8xaTBSVVEzMG9V?=
 =?utf-8?B?dGlTZW9udW0xMXlYNXhyN0xlVTFYZnZFaENIYzBGaEp1bUZydzF2eG9FU1pM?=
 =?utf-8?B?blM5Z0tKRnMxUktxYUUrT1pDeFF5QlhNeWRiU3gvaW1hRnBWL0hYRHQrVHVH?=
 =?utf-8?B?cE5yUmU1RDMvVkd1RVVHSk1SbFBic2NlRDh2Nk9UZFdmdnJiZ0RvS1dHNW1y?=
 =?utf-8?B?ZTBYMlhrcjRKd1QyNU8rZHhQTGVjcG9Jc1pwcVBqNGIxKzJHNEt1dXpzMXRa?=
 =?utf-8?B?K0lyWDlsbkdsc1J2dEFuMWJHcEFzYzV6UzVnR056Yno2NjV4T0tlMi9qa2Z4?=
 =?utf-8?B?TzdNUHdiNnRRQmEwSWRGQTBkTEowNDVucGxlWVBTR01JRUFSQ3loVlhBaU1n?=
 =?utf-8?B?ZmU4MU9pY1FrZzB3Ulg4R1dRVzdLZnA0OFVYcHI4S25VeHZWMkNpVi9XNmx0?=
 =?utf-8?B?RzVXVW5zbGExZEl1Q3UwY2NxUFZ5b2VaeGFIOEkrWHQ2VnBjeXVTSFJLQ1Ey?=
 =?utf-8?B?THE2SmZYUTlhcDE1Y01PcWVhT21IVWs3RVJ2SUNodWtzbUFDL3FNUXdxVnkv?=
 =?utf-8?B?UFZ5UnUyYzl5em9SMFFiYXJrYzJGTmFjUG5BSnNMWHI2WnAxRXErOStMMDJN?=
 =?utf-8?B?NmRoeWJwMHJtOElqTi9laURXR2FmTnlWZXp1SUk2alp4dDh1aUxVVjYvNXB5?=
 =?utf-8?B?RTNlTTcxSHEwTTNjT2duZDVTNHFqWUhLNHJGQk45WGxTOXZveC9OTUdsdTJn?=
 =?utf-8?B?a3YwbzVPb2dqVnlZbWJuNS93ZzZXaWhCL1FuamU0TnNISjl4cWJMT3pmMldT?=
 =?utf-8?B?MTBQb0M1WWVESFhhRG84Z0JaT2d0cmcrTW1nYlIzWEVyK3F2QUllSGtZTXpX?=
 =?utf-8?Q?y/7w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0b4692-f1d3-4cd9-2e7c-08dd3191ad4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 16:13:10.3364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4frv6L0Z2kocapEs6ZFPfAVHhCPL+EJdZXFdeFHAoWW+tRgqzjwkJbX36jDzdO6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061
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
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSA5LCAy
MDI1IDEwOjM5IFBNDQo+IFRvOiBLaW0sIEpvbmF0aGFuIDxKb25hdGhhbi5LaW1AYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBLYXNpdmlzd2FuYXRoYW4sIEhh
cmlzaCA8SGFyaXNoLkthc2l2aXN3YW5hdGhhbkBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBkcm0vYW1kZ3B1OiBmaXggZ3B1IHJlY292ZXJ5IGRpc2FibGUgd2l0aCBwZXIgcXVldWUg
cmVzZXQNCj4NCj4NCj4NCj4gT24gMS85LzIwMjUgODoyNyBQTSwgS2ltLCBKb25hdGhhbiB3cm90
ZToNCj4gPiBbUHVibGljXQ0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+ID4+IFNlbnQ6IFRo
dXJzZGF5LCBKYW51YXJ5IDksIDIwMjUgMToxNCBBTQ0KPiA+PiBUbzogS2ltLCBKb25hdGhhbiA8
Sm9uYXRoYW4uS2ltQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+
PiBDYzogS2FzaXZpc3dhbmF0aGFuLCBIYXJpc2ggPEhhcmlzaC5LYXNpdmlzd2FuYXRoYW5AYW1k
LmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IGdwdSByZWNv
dmVyeSBkaXNhYmxlIHdpdGggcGVyIHF1ZXVlIHJlc2V0DQo+ID4+DQo+ID4+DQo+ID4+DQo+ID4+
IE9uIDEvOS8yMDI1IDE6MzEgQU0sIEpvbmF0aGFuIEtpbSB3cm90ZToNCj4gPj4+IFBlciBxdWV1
ZSByZXNldCBzaG91bGQgYmUgYnlwYXNzZWQgd2hlbiBncHUgcmVjb3ZlcnkgaXMgZGlzYWJsZWQN
Cj4gPj4+IHdpdGggbW9kdWxlIHBhcmFtZXRlci4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5
OiBKb25hdGhhbiBLaW0gPGpvbmF0aGFuLmtpbUBhbWQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYyB8IDYgKysr
KysrDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dm
eF92OS5jDQo+ID4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
ZnhfdjkuYw0KPiA+Pj4gaW5kZXggY2M2NmViYjdiYWUxLi40NDE1NjgxNjNlMjAgMTAwNjQ0DQo+
ID4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92
OS5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2Zk
X2dmeF92OS5jDQo+ID4+PiBAQCAtMTEzMSw2ICsxMTMxLDkgQEAgdWludDY0X3Qga2dkX2dmeF92
OV9ocWRfZ2V0X3BxX2FkZHIoc3RydWN0DQo+ID4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4+
PiAgICAgdWludDMyX3QgbG93LCBoaWdoOw0KPiA+Pj4gICAgIHVpbnQ2NF90IHF1ZXVlX2FkZHIg
PSAwOw0KPiA+Pj4NCj4gPj4+ICsgICBpZiAoIWFtZGdwdV9ncHVfcmVjb3ZlcnkpDQo+ID4+PiAr
ICAgICAgICAgICByZXR1cm4gMDsNCj4gPj4+ICsNCj4gPj4+ICAgICBrZ2RfZ2Z4X3Y5X2FjcXVp
cmVfcXVldWUoYWRldiwgcGlwZV9pZCwgcXVldWVfaWQsIGluc3QpOw0KPiA+Pj4gICAgIGFtZGdw
dV9nZnhfcmxjX2VudGVyX3NhZmVfbW9kZShhZGV2LCBpbnN0KTsNCj4gPj4+DQo+ID4+PiBAQCAt
MTE3OSw2ICsxMTgyLDkgQEAgdWludDY0X3Qga2dkX2dmeF92OV9ocWRfcmVzZXQoc3RydWN0DQo+
IGFtZGdwdV9kZXZpY2UNCj4gPj4gKmFkZXYsDQo+ID4+PiAgICAgdWludDMyX3QgbG93LCBoaWdo
LCBwaXBlX3Jlc2V0X2RhdGEgPSAwOw0KPiA+Pj4gICAgIHVpbnQ2NF90IHF1ZXVlX2FkZHIgPSAw
Ow0KPiA+Pj4NCj4gPj4+ICsgICBpZiAoIWFtZGdwdV9ncHVfcmVjb3ZlcnkpDQo+ID4+PiArICAg
ICAgICAgICByZXR1cm4gMDsNCj4gPj4+ICsNCj4gPj4NCj4gPj4gSSB0aGluayB0aGUgcmlnaHQg
cGxhY2UgZm9yIHRoaXMgY2hlY2sgaXMgbm90IGluc2lkZSBjYWxsYmFjaywgc2hvdWxkIGJlDQo+
ID4+IGZyb20gdGhlIHBsYWNlIHdoZXJlIHRoZSBjYWxsYmFjayBnZXRzIGNhbGxlZC4NCj4gPg0K
PiA+IEkgZG9uJ3QgdGhpbmsgaXQgcmVhbGx5IG1hdHRlcnMuICBXZSdyZSBnb2luZyB0byBoYXZl
IGRpZmZlcmVudCByZXNldCB0eXBlcyBpbiB0aGUgZnV0dXJlDQo+IHRoYXQgbXkgY29tZSBmcm9t
IGRpZmZlcmVudCBjYWxsZXJzLg0KPiA+IEl0J3MgcHJvYmFibHkgZWFzaWVyIHRvIHJlbWVtYmVy
IHRvIHB1dCB0aGUgYnlwYXNzIHdoZXJlIHRoZSByZXNldCBpcyBhY3R1YWxseQ0KPiBoYXBwZW5p
bmcuDQo+ID4NCj4NCj4gSWYgSSB3YW50IHRvIGRlZmluZSBzb21ldGhpbmcgbGlrZSBhbWRncHVf
Z3B1X3JlY292ZXJ5PTIgKGRvbid0IGRvIHF1ZXVlDQo+IHJlc2V0IGJ1dCBwZXJmb3JtIG90aGVy
IHJlc2V0cyksIHRoZW4gaXQgbWF0dGVycy4NCg0KSSBkb24ndCBnZXQgd2h5IHRoYXQgbWF0dGVy
cy4NClRoaXMgY2FsbGJhY2sgYWxvbmUsIGZvciBleGFtcGxlLCBjYWxscyAyIHR5cGVzIG9mIHJl
c2V0cyB3aXRoaW4gaXRzZWxmIChxdWV1ZSB0aGVuIHBpcGUpLg0KSWYgeW91IHdhbnRlZCBwYXJ0
aWFsIHJlc2V0cyBiZXR3ZWVuIHF1ZXVlIGFuZCBwaXBlIGluIHRoaXMgY2FzZSwgeW91J2QgaGF2
ZSB0byBicmFuY2ggdGVzdCB3aXRoaW4gdGhlIGNhbGxiYWNrIGl0c2VsZi4NCkdQVSByZXNldCBi
eXBhc3MgY2hlY2tzIGFyZSBpbnZpc2libGUgdG8gdGhlIEtGRCBzZWN0aW9uIG9mIHRoZSBjb2Rl
IGFzIHdlbGwuDQoNCj4NCj4gU2luY2UgdGhpcyBpcyBhIGNhbGxiYWNrLCBrZWVwaW5nIGl0IGF0
IHRoZSB3cmFwcGVyIHBsYWNlIG1heSBiZSBtb3JlDQo+IG1haW50YWluYWJsZSByYXRoZXIgdGhh
biBrZWVwaW5nIHRoZSBjaGVjayBmb3IgZ2Z4MTAvMTEvMTIgZXRjLg0KDQpNYXliZSBub3QuICBN
RVMgaXMgcHJlZW1wdGlvbiBjaGVja3MgYXJlIG5vdCBsaWtlIE1FQyBwcmVlbXB0aW9uIGNoZWNr
cyBhdCBhbGwuDQpBbmQgd2UgcHJvYmFibHkgZG9uJ3Qgd2FudCB0byBqYW0gb3RoZXIgZnV0dXJl
IElQIHJlc2V0cyBpbnRvIGEgc2luZ2xlIGNhbGxlci4NCklmIHlvdSBsb29rIGF0IHRoZSBrZmQy
a2dkIGNhbGxiYWNrcywgbW9zdCBhcmUgcHJldHR5IG11Y2ggY29weSBhbmQgcGFzdGUgZnJvbSBv
bmUgZ2VuZXJhdGlvbiB0byBhbm90aGVyLg0KSSBkb24ndCBzZWUgaG93IHB1dHRpbmcgdGhlIHRl
c3QgaW4gdGhlIGNhbGxiYWNrIG1ha2VzIGl0IGxlc3MgbWFpbnRhaW5hYmxlLg0KDQpKb24NCg0K
Pg0KPiBUaGFua3MsDQo+IExpam8NCj4NCj4gPiBKb24NCj4gPg0KPiA+Pg0KPiA+PiBUaGFua3Ms
DQo+ID4+IExpam8NCj4gPj4NCj4gPj4+ICAgICBrZ2RfZ2Z4X3Y5X2FjcXVpcmVfcXVldWUoYWRl
diwgcGlwZV9pZCwgcXVldWVfaWQsIGluc3QpOw0KPiA+Pj4gICAgIGFtZGdwdV9nZnhfcmxjX2Vu
dGVyX3NhZmVfbW9kZShhZGV2LCBpbnN0KTsNCj4gPj4+DQo+ID4NCg0K
