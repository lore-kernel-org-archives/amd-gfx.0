Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DDCC369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 14:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2AE210E945;
	Wed, 16 Apr 2025 14:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nGzDhx78";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C8B210E947
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 14:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOBVTz2TnV6hyhTR3iUSSOvUcfr+1fehl43oTGvg4H1HY4QduMJpAzF06x4kkF6hMxkx9YpHMeuBlLDLfRxJc9HEpPeCk9sU89i3gERTDMK+jmF9vHLBWqNsiL3XFWt41R6OcfwTAUAqLuwN1UODBCWP8qDsIJHctNaR0XpePmfCL8G/ZBnDlvk7MCPgLHDVSsn/PBjw7kUNiW8yjPP9d5DjpNHVI/UUCLLJzWmQxjYt8ESIlbkyEpqiDPxsVUtPjCyq7UbhvnpygI1CFFXkXxe8dzlLStFv7UaTmKpsd1J6+uCYeHMpODVQC8iMTBamwEMkwx720kEcnd5p4+zzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cR21qVW1w+cfQv4qHAmdL2RbkYzadZl2cIbhmgPLqt8=;
 b=Ki+WbTW6XuhcSHIZwSKt4qXkM4nvQKVJ8/zyCU0fUJvRZ1lHoT/v3cPu1qXsdeZT5FUUTG0CFJF3Fa1whD0B2RrZ4XxuSCSSHm05XUyHoZ39m/09x8l248QViAVqOKac/jGMKSVT15EbMbSIp1oLb++UvMZBLyGybD5Tc279MLbPkfEmea7wux/1uKWdFcxYh5bT6LZt7mlPmSjYyzlO9nSXHFrhfqcGOAxjskMXvzZTszYjtALhOpiDiU7J7Q/veTef7YFGitAPfFjBLqkvtpR6ur52lcrcuO6U1uZFKZG1Lm2gdPpsDn/T+9fdW7xZoFvkYlG5M09VBUIr00QMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR21qVW1w+cfQv4qHAmdL2RbkYzadZl2cIbhmgPLqt8=;
 b=nGzDhx78H/JyKB4WwQxAevfe0EMBB3tOvTpbCB+/AqcUyiVqk0yLs01fV2mpxsucrElPuw1kpJATI+09hqOs3OTHuZoEtdtdp+LuuUJNt6x39a8X3fw72oG0lRgicvusWnODUaqU369YiLl+p9bM1159HKg/UVAQqZiJt4g7btE=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 14:16:50 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 14:16:50 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: trace the scheduler dependent job fence
 name
Thread-Topic: [PATCH 3/4] drm/amdgpu: trace the scheduler dependent job fence
 name
Thread-Index: AQHbrqymkaVmmmDUHEalDaYLauLa0rOmITKAgAAgmEA=
Date: Wed, 16 Apr 2025 14:16:50 +0000
Message-ID: <DS7PR12MB60053AACAD58864072A3F513FBBD2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
 <20250416085029.2278563-3-Prike.Liang@amd.com>
 <b11d325b-77e1-4350-8caf-406fac4d13d8@amd.com>
In-Reply-To: <b11d325b-77e1-4350-8caf-406fac4d13d8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=2239ab2b-0339-4e5a-9fcc-a91c0a5549bb;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-16T13:10:12Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB9029:EE_
x-ms-office365-filtering-correlation-id: dc86809e-6c24-4626-cca8-08dd7cf1546a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SC9GeEFMUktnSE9nbGJiVUpEWTc2TDlQcE5pVGNldlFBNk54aHlSeWR0WDhn?=
 =?utf-8?B?M3JRQm9DRjBXVnZlM1lEeTlBbDFFMG5haFAxNWl6SHlpNkxMTVpITkVwRHBD?=
 =?utf-8?B?NHFsaUFqUlNKSWI3WFB2dkNoRFZzbjZERlRYbDB4MWhVSTloWm14a3UyYzla?=
 =?utf-8?B?Vk9Rek91eU02cVdHeFZCKy95ZFBSekcvZmlyanpjYlhnamtBUTdqSTI5TG5C?=
 =?utf-8?B?OVdNNzdJQy9zTmsxcXZmVFRUTGNmYkNDcmx5UHBDTmxDNEJ0a0ZRVk4wNTd0?=
 =?utf-8?B?Z1lRcmx2dS9kU1l6cWQveTZZWGM3b012ZWVpTFNXUlJZZHlndXJMblhIdFZy?=
 =?utf-8?B?OTNxdk1DVmtpR2I3QlpTd25QRXlOZFZ4UnM2Q1dWY2UxVno0VG00M3JNNkFH?=
 =?utf-8?B?NjFBeE94MmV4RzdkTithR053TU5jMUVub1JhMURJU0M4dWdrVitqRXZaVXl2?=
 =?utf-8?B?RXFmMm52QkhrYVl5bW9INXVIaWs1azRSNzIxVC9WNkVWYTNRKzJ6Wlh2L0hv?=
 =?utf-8?B?aytDUEtJNmJ2SVJFcXQ0c2lObVpVU3B6VU5iNVdqK3VtRUJRQ21XQW9GQTJN?=
 =?utf-8?B?TjNRWHRYTFY1eCtFaGVWaktweHRKdkxnMDVnQVBWQ1RDTFpBbzUyUzNLN0FI?=
 =?utf-8?B?TUx0dnFOaXpwNGdNUDVkb1RHeGwveGk2ZjJiWHpEc2h0S0tWNEN3Z3JNWXlQ?=
 =?utf-8?B?WENGMVRmWk5FbnNaZEZZVDVwUmZsVm9xbk9pdzFWVTZBTzBGK0JrSlh1SVZt?=
 =?utf-8?B?ZTRVdDNYYWJvRTJheHlnMzJaRlVYaU0wSWNESE1iWDBXNHF4cVorZDUzOHN6?=
 =?utf-8?B?OWxQTFpuSUhSQ3oxc2tlZ1U5cElpbjF4bjE4b2ZMMFBhalBGRi9CWHpTSHdh?=
 =?utf-8?B?VWtuSzVnM3Y2d1BhUGFHL3hBOW1ycVZJK1FPNTh3dGQ2N25kSGhkSWgydjMy?=
 =?utf-8?B?ejNNVDJ5akNJRVEzYzJRRlp1YjhHMXhWbFk3NldIY3k0d0RralRRVUlkRmpH?=
 =?utf-8?B?aDZRT21reUtBd0p5bUJ6VU5iZ0U5RlhBZVQrOGRqQ2pYMWNQU0NWcTNXeUdm?=
 =?utf-8?B?R0d1ZXA3by91cURhVWMySGNMQ3JPb3E5QlJJUFpEdTFsZUdCelplM1lyZW9N?=
 =?utf-8?B?NXExaTlaMWd6dU5nNTFVQzFPaXA0Tk5HenREaTZUbWhXRWFjVTY5NGdEL1R4?=
 =?utf-8?B?dTR4S3RsSysvWE94VTM5NjY4b1VIS3ZVZDMvRUhWMFRPRGNHWkU1NisrL3k4?=
 =?utf-8?B?Rk01dUhZYVVpVjNNbHk5a2JSZ2RpWjk3U1h6NGFqMTlKRkN3VEIyWFE4NGtw?=
 =?utf-8?B?TXB4Y0dRYkpEU0t0a1JQLzA4WlFHSEoxdXNMSlVHN01RS3dGM2FJR2tvdFRo?=
 =?utf-8?B?ZG9tcElrV1IxZ0dMcG5KcndER29NbE0vV0J6Qk1zVWlwQ2t5Z3lkY2pBKzBm?=
 =?utf-8?B?SFBNbXVaU2E5VGRGY1NhZHdRdzhZSHBuc2NmcUFGWGYyRzQxbTk5c0RjcjRw?=
 =?utf-8?B?THRTMjhkQ01LK2pocE5uWVgzeENpcDlKdkVzV3AxYzJsUnFFOEJDeUwvVFAx?=
 =?utf-8?B?YjUvNTBxUk40dVg3cVBvN2UxQTZ0NVNaUDNDaUtEeWRXdXZodVBhUmNvRml1?=
 =?utf-8?B?eit6eXlXQnZ1UXZRZVpQdkkyemxsYUF6dUUxWWVMREFsQzNUZ3g0Ly9kTjVr?=
 =?utf-8?B?bDJhM1ZwSUFRWFZlTm0veERFZUtkcEc4a0hKRWQ5Q1pvYk5jZ051cElhYWF4?=
 =?utf-8?B?azRWRm4vc05xK0dQU3dNcUpzTStIMWJFVkl3ejlMWExPQzdQU3BwTTdiOWlM?=
 =?utf-8?B?dnYyRlpyYmExVTVIaDl2dTB4b1hpc1ljbWR6MXBmVHJrYXMvVW91R01YY2xO?=
 =?utf-8?B?U0kvWWhGRURCVlFtRjY0akxmMTBuc2xGNkpOb3ZSNkZMY2czd0FhTHVpZ2Zp?=
 =?utf-8?B?UmRmMGU2MGIzTTJwYU1Uc3pwUytJb3Q3allGdERJZ2dmZ1lMYW1ZMGdpeGh4?=
 =?utf-8?Q?px16OVO+jV2B501rJ4PkxVh+7/naTI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkpkZS9adHNHUkxoQ1J5SFkxdzQ0ci9JWlNiUjlMZHNCUE9MRFVCMTY2MHVy?=
 =?utf-8?B?S1pmbHdHYjlyb2oybWpkVGx1ck9iaENIK1ZJZ0FqT1ovWmlLMzc2TUgyMi9S?=
 =?utf-8?B?V1FvQnFqWVMrSnlOM3FBOVZFQjQ1eFhTYkpLa1gxMUk2a2ttby9MU0NIa0Y5?=
 =?utf-8?B?NDRLWndmY3RqRUMxaHFjcFcxRzk1VmpHZC9iWjBCVElYOGN3UDFaakEvcUxl?=
 =?utf-8?B?cit6ZVlXWEVzcnhpLzVJNXljVnd1eGoxNXZXa3poSjJiNDRwM2xKQUwrUlJa?=
 =?utf-8?B?bndlek9pUFUycGJmb1h4bXYra0JBVTlUSUdWMlFMNVFkajQ2ZWZubEVPK05z?=
 =?utf-8?B?Uk9IdjUxQjRIZVk1N3hRSmtub1l2WjFOM3lUMFlhSXIwTmNkb1FMOS9pbG1l?=
 =?utf-8?B?cVFLd1hBYlhPUmdTQURueEo2L2hlZ3dZcS9SVVIvcnlaK3VSUHRXYmZSdDVM?=
 =?utf-8?B?alNVY3BaZ1o5aXBFSzRlOTFVR0U0c1BibHBzcTFUOXNLSjRmN2IyN3VaNXF4?=
 =?utf-8?B?RC9DZTNOOGpUZVNyQkh4N0FOWXdQcVcrUmZ0Nk80aWVHdUZFMCtoZ1V0S3pM?=
 =?utf-8?B?Ti9NdWZHc0loNkRLdzVmaEsxbUZNTkNaN2hyN0lQMGpsSnVNekorbXBIS2p1?=
 =?utf-8?B?d1FHQWFmOTFWV3c2alNmY2s2SHZqcUZpUjd2L0tYTDFHejJDM2E0NzM0S0lm?=
 =?utf-8?B?b3pvWlBiQ05RNmduRU11emovWEVDTUs5SkZIaTNoQUlPa09JVWVKV0NOSkgw?=
 =?utf-8?B?bW9wYTZWUzVVbndDZXF6M2tlSjdMa3M1a1M4aFNCSzNVNjVrbUtnd3dsWnhM?=
 =?utf-8?B?VVViQ3g1Zlk5ZkJLdGRGNTNJdklUNDd2cXI1a3hFQitKaTAyY1RwbS8zNmdK?=
 =?utf-8?B?Vm9INWtpeFA1VGlkS0M2TGkycTYxTXdMTlR4V256RFkraVc5VnpXT09wV01K?=
 =?utf-8?B?TjdrRGs1SC9ud0UwbEYvbTlIVk5sbU9uYS9ZM1hKaklKS2xpTzJuanNhTTM3?=
 =?utf-8?B?bFRON1hMR29zRTJYQTJuUzJISUJtdjgrMkJON2I5NmkyNFgrRHJFdEordEEv?=
 =?utf-8?B?dlJyTEVOQlZmN3BQVVJIbFNzT2Y1RGIzTlFHYkhxNWhod2VicGJjN1BpRGhh?=
 =?utf-8?B?NWx2ZE5hbjFUNklsODE0TVQza24vdm9MNjVFenJCdW1QWUVZdHJ6Z3lzWEhI?=
 =?utf-8?B?eFU5VVRsM0F5czE0MEpwZ0NRdmhBVWdYSFdENWhBTEJHcGZ1czR3Si9sUDVw?=
 =?utf-8?B?SHFxbmRXYTE5Rms2UWw2OUE2RUllUTZuK0FuTTErNXczT01NVUJrR3NGWXdG?=
 =?utf-8?B?TWJ3bEd1THh1NVJ5MGFHK0E0eWlXa2wvbGJGYjBpM084cmRZRHJhN3dMSDBq?=
 =?utf-8?B?Q2hhLzJiNmpaVXF6UlgxaXVFR0lZZ3laRURkeVEzSi8zaVcwUE9KbkxsTFFw?=
 =?utf-8?B?Tk55UTlYUjV0cVVQVVkvVW9rZVJZQWEwanRIcTE0YkZQbXg1dUVtWk1yN0s0?=
 =?utf-8?B?YmpHUjRYMlByYjBLS2Y0c2RxSmM1Vll1WFp1cGpzYldXVDRYaUNwVUtRWmow?=
 =?utf-8?B?SUl0QU5LTVRLdHBWUU9xNlF2bHVQU21oTzlEdjZyeHhYNWRvTkF2R3pseTBN?=
 =?utf-8?B?cFZiaFViOEVnTVlOUjhkNENQbHc2WnNNVGg2Ymk2Y1hjRUVEZjYxSDA5a2dM?=
 =?utf-8?B?NUN4cDRiVFpBOFN4ck8wUFk4Z0lvKzB5ZTBPZlBjeG84dFlBVnUvQlg1MStq?=
 =?utf-8?B?YlNoRFQwT3Zzcmx5RlB0UGYvRERoMXJjNXJKSDVzcy8zaEtMek1ocXhnWEVv?=
 =?utf-8?B?eGxNYUFhSnI5bTVNbTRYRnJPU3NSS28vOHYyaE5DNlNTb2JMTm1OYlFJelI1?=
 =?utf-8?B?by9NaXpmVU14c1hwdFVCM0hCZGRUQ1ZPTTdaNU1zS2JEOHhnc1FKNTRxcld1?=
 =?utf-8?B?aGlFQzVlbVR6TFd5T1FBSTJSYVVVeU1BRFJUTkE3UEF5NlkyWHBDNXcweWVz?=
 =?utf-8?B?S05nUldRWDZGQUthbi9xa2VYTTN4L2NLZkRLRVhaVXVLQnprMWdJWFI3WDNX?=
 =?utf-8?B?MDBWYWJncjNGTk9Ubnd6RVZjVDRPTEpERHV0ZjVjOURsMlhRUlpERFNrUWJp?=
 =?utf-8?Q?yQ2o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc86809e-6c24-4626-cca8-08dd7cf1546a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 14:16:50.1448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPW2Qoe5ZWmIz0NOfgdiIPNNjaOiLmazoRRV930Vcl1xWPOn+f2niAuPmgc8tT44
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029
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

W1B1YmxpY10NCg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE2LCAyMDI1IDc6MDQgUE0NCj4gVG86
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy80XSBkcm0vYW1kZ3B1OiB0cmFjZSB0aGUg
c2NoZWR1bGVyIGRlcGVuZGVudCBqb2IgZmVuY2UNCj4gbmFtZQ0KPg0KPiBBbSAxNi4wNC4yNSB1
bSAxMDo1MCBzY2hyaWViIFByaWtlIExpYW5nOg0KPiA+IFRoaXMgdHJhY2Ugd2lsbCBoZWxwIGlu
IHRyYWNraW5nIHRoZSBzY2hlZHVsZXIgZGVwZW5kZW50IGpvYiBmZW5jZS4NCj4NCj4gQ2hhbmdl
cyBmb3IgZ2VuZXJhbCBEUk0gY29kZSBuZWVkIHRvIGdvdCBvIHRoZSBhcHByb3ByaWF0ZSBtYWls
aW5nIGxpc3QuDQoNClllcywgaXQgc2hvdWxkIGJlIHNlbnQgdG8gZHJpLWRldiBncm91cC4NCg0K
PiBBcGFydCBmcm9tIHRoYXQgSUlSQyB3ZSBpbnRlbnRpb25hbGx5IGRpZG4ndCBkbyB0aGF0LiBX
aHkgc2hvdWxkIHRoZSBkcml2ZXIgbmFtZSBiZQ0KPiByZWxldmFudCBoZXJlPw0KDQpCeSBhZGRp
bmcgdGhlIHNjaGVkdWxlci1kZXBlbmRlbnQgZmVuY2UgbmFtZSBkdW1wLCB0aGlzIGNhbiBoZWxw
IGlkZW50aWZ5IHdoaWNoIGV4YWN0IGZlbmNlIGlzIGRlcGVuZGVkIG9uIGJ5IHRoZSBzY2hlZHVs
ZXIgam9iLiBXaXRoIHRoaXMgZHVtcCwgc3VjY2Vzc2Z1bGx5IGNhdGNoIHRoZSBjYXNlIGFib3V0
IHRoZSBTRE1BIGFuZCBHRlgga2VybmVsIHF1ZXVlIHNjaGVkdWxlZCBqb2JzIHRoYXQgYXJlIGRl
cGVuZGVudCBvbiB0aGUgZXZpY3Rpb24gZmVuY2Ugd2hlbiBlbmFibGluZyB0aGUga3EgYW5kIHVx
IGF0IHRoZSBzYW1lIHRpbWUuDQoNCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlcl90cmFjZS5o
IHwgNSArKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9n
cHVfc2NoZWR1bGVyX3RyYWNlLmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvZ3B1
X3NjaGVkdWxlcl90cmFjZS5oDQo+ID4gaW5kZXggYzc1MzAyY2EzNDI3Li40NzNhMmNiYmQ3YmQg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVy
X3RyYWNlLmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL2dwdV9zY2hlZHVs
ZXJfdHJhY2UuaA0KPiA+IEBAIC05MSw2ICs5MSw3IEBAIFRSQUNFX0VWRU5UKGRybV9zY2hlZF9q
b2Jfd2FpdF9kZXAsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIF9fZmllbGQoc3RydWN0
IGRtYV9mZW5jZSAqLCBmZW5jZSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgX19maWVs
ZCh1aW50NjRfdCwgY3R4KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBfX2ZpZWxkKHVu
c2lnbmVkLCBzZXFubykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgX19zdHJpbmcoZGVw
X2ZlbmNlX25hbWUsIGZlbmNlLT5vcHMtDQo+ID5nZXRfZHJpdmVyX25hbWUoZmVuY2UpKQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICApLA0KPiA+DQo+ID4gICAgICAgICBUUF9mYXN0X2Fz
c2lnbigNCj4gPiBAQCAtOTksOSArMTAwLDExIEBAIFRSQUNFX0VWRU5UKGRybV9zY2hlZF9qb2Jf
d2FpdF9kZXAsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICBfX2VudHJ5LT5mZW5jZSA9IGZl
bmNlOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgX19lbnRyeS0+Y3R4ID0gZmVuY2UtPmNv
bnRleHQ7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICBfX2VudHJ5LT5zZXFubyA9IGZlbmNl
LT5zZXFubzsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgIF9fYXNzaWduX3N0cihkZXBfZmVu
Y2VfbmFtZSk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICApLA0KPiA+IC0gICAgICAgVFBf
cHJpbnRrKCJqb2IgcmluZz0lcywgaWQ9JWxsdSwgZGVwZW5kcyBmZW5jZT0lcCwgY29udGV4dD0l
bGx1LA0KPiBzZXE9JXUiLA0KPiA+ICsgICAgICAgVFBfcHJpbnRrKCJqb2IgcmluZz0lcywgaWQ9
JWxsdSwgZGVwZW5kcyBmZW5jZShuYW1lOiAlcykgYWRkcg0KPiA+ICs9JXAsIGNvbnRleHQ9JWxs
dSwgc2VxPSV1IiwNCj4gPiAgICAgICAgICAgICAgICAgICBfX2dldF9zdHIobmFtZSksIF9fZW50
cnktPmlkLA0KPiA+ICsgICAgICAgICAgICAgICAgIF9fZ2V0X3N0cihkZXBfZmVuY2VfbmFtZSks
DQo+ID4gICAgICAgICAgICAgICAgICAgX19lbnRyeS0+ZmVuY2UsIF9fZW50cnktPmN0eCwNCj4g
PiAgICAgICAgICAgICAgICAgICBfX2VudHJ5LT5zZXFubykNCj4gPiAgKTsNCg0K
