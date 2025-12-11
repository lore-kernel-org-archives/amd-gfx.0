Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977F4D3E78F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 05:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F77210E6F4;
	Thu, 11 Dec 2025 05:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1akbQL1g";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011044.outbound.protection.outlook.com
 [40.93.194.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A49BE10E6F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 05:22:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8PGu1nNJMAvwKFSQcbe5+8+zF63SqyU+rFkQRqedqp2QQGzpqVL3dlXSUe8IPcJOCGbl6/1bsjTVo4NjRIYp8vnpv70Xq6+NkSVdLQs5aXwnYSTZgFM0B3DxfvJ86eTk9HuSQurFl2neQzyN+l/qrkK4PDIz3IapHD6eC6HbkBzLsRsaMax5YdKlsJM3lkoNAGUm9aqFOwP2TDq64KBv03gPEkQ3mHU8ZASK3Jp6200QxtXNTZI4bO41KyIybvd9kppLf+wEAir6mP1olLFjDV6xOi31csqXbc53ys0+1FHbGMV1cjNMocBnmDpW6Y+IOCatm5wRhU0yC0lKCNtag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJHhhsAU/jDAdiD5H8FrUoawAVTuxs77jQzFt/O8b4A=;
 b=GtsPMyLrD9hJLdwQbDRQCoP14p2tt7PthNrAr8Tkf2EFJ6rRZ3f4P6sL0vAHjKTO+cswPwJJavaegPtLseh4WrWnzUl/1b5+XK/FYOcKm/5zmIEsfHSeZ589in2aRB9UkXNuftv124LfK7/yLkY36tLsMJ2QEqNl+iPlXt+FzSS3jbw5tSgAzZofWFg57wDBFP6BbOmC0uIsffXD9UXFDjHw1IM8QkbvXceqNkEgxRE0KmL3DPhEXK72T7QY3iizOOF/gcOzkw8/WlbHRP7MO/Dcb873k1WSOcD2jN5qsxNe6eqN1VRcFwR+3D5GP3URHnmJuHC+NycyK/I4yi5jpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJHhhsAU/jDAdiD5H8FrUoawAVTuxs77jQzFt/O8b4A=;
 b=1akbQL1gOJa5Yi7NorA6rCpeatGq08gehN9oz/2ptBLGjaGY7TfTzld95VPyRkHirRftYX5hm5H+jGB0HzDlXccTpXSHbSbbXvDdiD/hHxopPUHCMqAalPkV8OZaq11s8Asoa1xd8IkrQ/mJVmPzC4JI0jj5UWH1TOREovcjOGg=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Thu, 11 Dec
 2025 05:22:20 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 05:22:19 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Matthew Brost <matthew.brost@intel.com>
Subject: RE: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu
 recovery
Thread-Topic: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu
 recovery
Thread-Index: AQHcahLwBcrNXy3GTUKiX+wfLCBOm7Ub4vGAgAAEMqA=
Date: Thu, 11 Dec 2025 05:22:19 +0000
Message-ID: <IA0PR12MB820858B3F15710B5E2C6255B90A1A@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20251210202347.63243-1-alexander.deucher@amd.com>
 <adf41aa5-3172-4e9e-9bfc-c8b853b7c0c0@amd.com>
In-Reply-To: <adf41aa5-3172-4e9e-9bfc-c8b853b7c0c0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-11T05:18:53.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|PH7PR12MB9104:EE_
x-ms-office365-filtering-correlation-id: 81df041a-22ab-4c94-504b-08de387541b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?bnR2K1B3eXlOVW1vYkZsVjlKYkZnZldicldTUnBYcHFmVjlySGNMaVg1ZFlS?=
 =?utf-8?B?WE16QU9YbmF6a3dTd2NoSWNXWFVoNk44VmIyRHpaZ3NiRGJYYzBIcG5qOWlz?=
 =?utf-8?B?WnEvYmRPUElWNXd4MVpHUDhIMk91d1RKbFRpbzdiaWcvNVFkUlFQTVBCekRE?=
 =?utf-8?B?a2tMUmplS3ZyVzJDU0lLbS9pVHFzNzR3WXdMZFprM3BHRFhteG1scFZ0ckNK?=
 =?utf-8?B?NGIxbDJLelBteHArbDducFBDajBPemZDdlQyRmpXWWF0d09hdEdDcTJOcllW?=
 =?utf-8?B?b0NsbmVDSENBOVpNck5WRm8zZ3R6TFl3QTVVeVNUTHVaWklXemZjUnFKdklH?=
 =?utf-8?B?VW0vNllkOFBMNEhseUhlNFpnVmM2R25lTG1KZ01xV0hVd1RCRXZEeEhxRFFB?=
 =?utf-8?B?TWpvc3Y4bUhGQWlZNTZveGxoeDNDd2dQQVVKV0I4RHp0N1JvR2hrTTlsa3Yv?=
 =?utf-8?B?TTl2MGhmUGxxU3YvWldsSlY4dlBPaHAzNEJYL1ltVCtFWTczbVkyaHFLTUxv?=
 =?utf-8?B?YlF6MkszczdUQXIxWGV2TXQ0Wlc4WUMwcTM4b2Z4UExzelhBdWE0OUZTNTlR?=
 =?utf-8?B?Vmd4bFdVKzI0L2Z5aCtrMVBiSDdPNHJONHAxUERjRU1sbE5IZi9OeExTMGFu?=
 =?utf-8?B?N2tpdXYvMWNwMCtMekNKb2Vyb2MwcTVqQWphSS9QUFZWZlNRbVIvdFErZkV2?=
 =?utf-8?B?UzJiTXpmdXQ3RjUra3ZTK1E4SVB2dCtTeVdCT0d3elpVc21CY1FpU0IvUlR5?=
 =?utf-8?B?cStndmo2dElzSFhlQzB3b2t3MWVHSlVWQkt0OU9RSnNFeUZWYURxRjh3aWQ2?=
 =?utf-8?B?S3BGQ0dZaVREejRkR1JIclRjbDU3cXU3QkFnVGxkaVJ6WHhLL2lFWEVJdE9M?=
 =?utf-8?B?bDdXTVhNc2pza2lDMzJpL3pnZVYxaVlkbkhjaUxUTUsya2kwVmVDZDBSWEQr?=
 =?utf-8?B?amNyNVVKdGJXQzZvS29jM1J1S0lKRmlnb3drVCtidUR5MjRaYUFXRnhMVGd1?=
 =?utf-8?B?Wk95dlIxRnk2NTdFa0g2RkZBR0pqLzVta084QTVHblNmQmQxei96RE1md3RS?=
 =?utf-8?B?VDhoWjkxUDF2WFFEYWt0eHl6NmhFalpaSmNHU015ejNXM0ZvcDFleDJjUzZy?=
 =?utf-8?B?UE5EUjN0K1JMQk1FZnZZak1QYXJiaHBrL0crUGRONCswR2s1ZENQSm5UaFI1?=
 =?utf-8?B?T0djOWtVZU1ucGNiazRHQWxaU0VHdDlNTXZibmw2ZG5ZNGErSDhsV0x1SjNq?=
 =?utf-8?B?NkhkMkdYVUVzRXI1Nnd2Zlh1R0x0WGdvMGxmT3BwMEc4Tm1ja1NBZUhYMGJn?=
 =?utf-8?B?dHJKZ2owaC9yUGpFK01CbCtGVlFJdlhmUTIzUlpNVTdESDlyNUJZN1U1YTA3?=
 =?utf-8?B?SEYvckZlTVdzdEQ2ODN2NjNJVTN5c25PUjNDcld2M2xwd2JuejAwN1FyeFJt?=
 =?utf-8?B?N3Jmc0kwS1RBc0YyN2hMOUNPMENXdkxnVFJhNjdMSFF3THFvL2gyYXFSNytD?=
 =?utf-8?B?ek5SbTFKS1ZvckY4Ti9sUXJPbkpsSVFVRzhyWmxRdHQrMTU5MmJQQWp0QkVY?=
 =?utf-8?B?aVg0UlhtclAyTDYwblVOUVpuTTNWeDVTM3V2Tmp6dk8wNjZjY0V3SmtoMDYz?=
 =?utf-8?B?TS9wejlmaVJhTkk4QXd5S3loditzV0g5dWN1WVpweGpFQmo4TG54NW15K28y?=
 =?utf-8?B?NDNHalpvVVJZMCtEOXdDUFBXNW9NQXhLWlVZb1ZKUkw0OC9WY25SYzdMb3hk?=
 =?utf-8?B?WDBwcEdBS2Ezc0kyRkRtOGtodGVrR2hNZDhLSVJtVjZvNmtHYkE2dmtvdmVt?=
 =?utf-8?B?dk9PL3NJRkdJWURkUWNOSlZmMXZua1lZdGtqeVhRZXArbVRXcHVXR0R3QlVZ?=
 =?utf-8?B?OU0wejVTNy9JUzB1UERsVGFWZEE3T3p1KzUyaFhoTHN3bjBhazFDNm53RzJP?=
 =?utf-8?B?Vi9nRFRBK2pEMUpVaUtQUHFxNFFDdVlQSGdkalIwL2xsbVhoTTVHZkNyM2xL?=
 =?utf-8?B?dFNoVWRJcUVRRWR2SkdEU3V3aVFHWFRHVXF4czBncFZERWsvWVpyMGZwTEJS?=
 =?utf-8?Q?/KZsC3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(13003099007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzZIUTdpWHpTN0RnRnp5bU5raytINStnc0FFVlROT2hBZDhtbkR4bDI0aEpH?=
 =?utf-8?B?Wnh1NWxqdVFLNnMwdjJVQk9MVkhFU2VqTDdXaEdaaXJIYi9vTFllMjNhZ0Rh?=
 =?utf-8?B?QW10dFYreUp1UGZ1QW4yQ3gxUTduN2hmRHlnSzRXN3BZczROS2lJNktYcnFj?=
 =?utf-8?B?bzNpRUR5dzF1Y3JMUGZuT1ZQam0xbVVZTS9kSDQ5VUlkbExoQkNFV05Pbnho?=
 =?utf-8?B?V0djQkJzWU1rbjJBak1sdGNFUVE3eGk5SGlwb1BXTFl0ZzRNZko4T1RGOTN3?=
 =?utf-8?B?allhcTdZd0taYjUraUhLK0xkRmhPRTlwVUtCVUlRWUVNSmlDM0RtMXZkNUVF?=
 =?utf-8?B?ZWtDbDRoQXB0UUlnanRrZUFQdGR5UlhqY3BpcTlCQytoelMrNjZ2Q0FiK0x1?=
 =?utf-8?B?OUZQNGNKUmdLUTVZeENIeElHbmtZYmo0a295Z1BqdVFCbnN5cW5XTlU0T2xp?=
 =?utf-8?B?LzNRUDA2S3V4STBUbDhvL0pXTzdPUVEyZnFSM1hXMWtpRUU3SzNwbGJ0M1BR?=
 =?utf-8?B?MTZETmM0UUs3dFhwNU1pRlZvYytTMDdYYmtSODNmWkhwU1hnRWE0c2hibEdR?=
 =?utf-8?B?bm9IMy9QRmJ4TExsQVg5eExPMlBBb0ozR3J6UDFZcE9mblNBUVdZZVZmY0Zt?=
 =?utf-8?B?QldmVG1BL0tlSkdtcnVYTGJqSmRRNmpCYityMHhjdG1PS3pIQUFpZWtueElK?=
 =?utf-8?B?Y09VUlBPVFNuMXZhTnQxVHYwZUVkRC9lUFUyaVlkVmtHeWVhbXJFVlFORXhG?=
 =?utf-8?B?d0hHTmw3cU54V2VYQW5obDVWMDVlTXh4Q3dBQ3BlVnFhTU5KYUE3dzVrUjdY?=
 =?utf-8?B?blNRdk80THlnMFJ0UG50VmVUWDY3a3RNTXhwTDVlMW8yaGQ3V2dQckF6dm1z?=
 =?utf-8?B?QVRoeTdWVitsdGQzM1pVazVtVWlNMjRReEhpSVNDNjBKaHZqa3M0bFEvcTB1?=
 =?utf-8?B?am9NbWttRTFyc0liejFSakgycjkreFRzWHk0MVJFRlloN2dCTVFZY3FuUGxU?=
 =?utf-8?B?NG9HYVkwNTNKYWNwaE8xdDN5Y2ZZeDBVTjdUc0tNOTVaNTNidi9jL3NyaXRU?=
 =?utf-8?B?STNZTzBJMjJwS1M5ZWxrQ2NiTFRjc2ZlRW04Qlpka2FjRTdkZjNEK2VCSk5H?=
 =?utf-8?B?QVpIOFhaS05GVTc3NmgyUklqbDQ2dXN5bFF3M2lGMTJxZDRYZThnZmNGeUZO?=
 =?utf-8?B?K1UzditDd09hN1JIUmlEMDNsS0tnYXU5VG1MODBaR1BSaFBhOFpFVjFrdldH?=
 =?utf-8?B?RXJPSXU3M1Vyd01ZTFpmMGd6RjkrTWlTRExFdE9tNS94bmd2eWgrZXVrMzli?=
 =?utf-8?B?MXhoZ2FHYTBVc1VIL0RoRDNLbmNxcjRGc2h0M3YyOG5qd2hzOTZQWFQramtt?=
 =?utf-8?B?Y0hPTTR5ckJ4bjNOaERhMHNodVdvR050ZnpEZWVXM0Y0S0Y3T0d5YjlNRnBs?=
 =?utf-8?B?SlVua054SWd0Y2h2amNFejRDeVFLQXluU2RVZjhPNEN1T3J3SU9oUFI2NWZU?=
 =?utf-8?B?R2JOQTFOV2xnWnU1YWpPaGVqMHdVd1p1aFhuRzhJOGo5amtoNkVYVEdzcGll?=
 =?utf-8?B?Z21rbkU4OTVxK2EwVm1UUm44SzhNeXFCTXhhY2hRZlNNRjkwYW9zQ1Jqcy9U?=
 =?utf-8?B?TXQ4T2MrK2ZINm00b1V6VWEvWXA3bk1HdkpUS2tUd0ZUdVM3N3FRNzNzWE01?=
 =?utf-8?B?NnJPUWNZNGhHQ0dhYXFhMm9vK256TENZcytETUNWNWZwZzNtQUtEdjN0U2V4?=
 =?utf-8?B?SEFOMVpuVHVQQjF2RTgwNVA5Y2lobGllMnZXS1FxZFphZ0tvRTlqQ2xjTWhs?=
 =?utf-8?B?MDZ4RFIrK3VIN0R6aWVRUmlJZGRVSDdLNEV1cVliQm1HeGZnK2F1a3dQKzdN?=
 =?utf-8?B?TEpYVFdPYVo5RU1HUS9DQXV0d3RmNGZ5cnIwNGZHRGVtcUR0U2hzZzFkVWVp?=
 =?utf-8?B?VnUyck13dWpRRnYvWWp2cTlBNDFxNGIzKzlNbWQ4bDIzRjJ0QjIxUURiT2wz?=
 =?utf-8?B?TTJNTzlGZlNIMlJFb2J1b0VWb0x3cXpBQ2NjeUY2NlVVeW9Ydmh5UTJnYTNY?=
 =?utf-8?B?ZXhCV0dFWE04V0Z2anJLQzF3U1BkVU9FU0E5V090RkN2Uzc0aUlEZnFtYzli?=
 =?utf-8?Q?XpiQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81df041a-22ab-4c94-504b-08de387541b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 05:22:19.7240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RLr9w0DhW1fjPeAZrbcaqEyEPbR8tCKv+o7NBd91uGVcdWp6XqTB7ldvHh3QVaww+Zy1qfrzqvhN0ODhh1PE2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104
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
by5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMTEsIDIwMjUgMTA6
MzQgQU0NCj4gVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogU0hBTk1VR0FNLCBT
UklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPjsNCj4gUHJvc3lhaywgVml0
YWx5IDxWaXRhbHkuUHJvc3lha0BhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT47IE1hdHRoZXcgQnJvc3QgPG1hdHRoZXcuYnJvc3RAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBkcm0vYW1kZ3B1OiBmaXggYSBqb2ItPnBh
c2lkIGFjY2VzcyByYWNlIGluIGdwdQ0KPiByZWNvdmVyeQ0KPg0KPg0KPg0KPiBPbiAxMi8xMS8y
MDI1IDE6NTMgQU0sIEFsZXggRGV1Y2hlciB3cm90ZToNCj4gPiBBdm9pZCBhIHBvc3NpYmxlIFVB
RiBpbiBHUFUgcmVjb3ZlcnkgZHVlIHRvIGEgcmFjZSBiZXR3ZWVuIHRoZSBzY2hlZA0KPiA+IHRp
bWVvdXQgY2FsbGJhY2sgYW5kIHRoZSB0ZHIgd29yayBxdWV1ZS4NCj4gPg0KPiA+IFRoZSBncHUg
cmVjb3ZlcnkgZnVuY3Rpb24gY2FsbHMgZHJtX3NjaGVkX3N0b3AoKSBhbmQgbGF0ZXINCj4gPiBk
cm1fc2NoZWRfc3RhcnQoKS4gIGRybV9zY2hlZF9zdGFydCgpIHJlc3RhcnRzIHRoZSB0ZHIgcXVl
dWUgd2hpY2gNCj4gPiB3aWxsIGV2ZW50dWFsbHkgZnJlZSB0aGUgam9iLiAgSWYgdGhlIHRkciBx
dWV1ZSBmcmVlcyB0aGUgam9iIGJlZm9yZQ0KPiA+IHRpbWUgb3V0IGNhbGxiYWNrIGNvbXBsZXRl
cywgdGhlIGpvYiB3aWxsIGJlIGZyZWVkIGFuZCB3ZSdsbCBnZXQgYSBVQUYNCj4gPiB3aGVuIGFj
Y2Vzc2luZyB0aGUgcGFzaWQuICBDYWNoZSBpdCBlYXJseSB0byBhdm9pZCB0aGUgVUFGLg0KPiA+
DQo+ID4gRml4ZXM6IGE3MjAwMmNiMTgxZiAoImRybS9hbWRncHU6IE1ha2UgdXNlIG9mIGRybV93
ZWRnZV90YXNrX2luZm8iKQ0KPiA+IENjOiBTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tDQo+
ID4gQ2M6IHZpdGFseS5wcm9zeWFrQGFtZC5jb20NCj4gPiBDYzogY2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tDQo+ID4gU3VnZ2VzdGVkLWJ5OiBNYXR0aGV3IEJyb3N0IDxtYXR0aGV3LmJyb3N0QGlu
dGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4NCj4gPiB2MjogQ2hlY2sgdGhlIHBhc2lkIHJhdGhl
ciB0aGFuIGpvYiAoTGlqbykNCj4gPiAgICAgIEFkZCBmaXhlcyB0YWcgKENocmlzdGlhbikNCj4g
Pg0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMTAg
KysrKysrKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYw0KPiA+IGluZGV4IDhhODUxZDc1NDhjMDAuLmM2YjFkZDk1YzQwMWQgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4g
QEAgLTY2MzQsNiArNjYzNCw4IEBAIGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVj
dA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ICAgICBzdHJ1Y3QgYW1kZ3B1X2hpdmVfaW5m
byAqaGl2ZSA9IE5VTEw7DQo+ID4gICAgIGludCByID0gMDsNCj4gPiAgICAgYm9vbCBuZWVkX2Vt
ZXJnZW5jeV9yZXN0YXJ0ID0gZmFsc2U7DQo+ID4gKyAgIC8qIHNhdmUgdGhlIHBhc2lkIGhlcmUg
YXMgdGhlIGpvYiBtYXkgYmUgZnJlZWQgYmVmb3JlIHRoZSBlbmQgb2YgdGhlIHJlc2V0ICovDQo+
ID4gKyAgIGludCBwYXNpZCA9IGpvYiA/IGpvYi0+cGFzaWQgOiAtRUlOVkFMOw0KPiA+DQo+ID4g
ICAgIC8qDQo+ID4gICAgICAqIElmIGl0IHJlYWNoZXMgaGVyZSBiZWNhdXNlIG9mIGhhbmcvdGlt
ZW91dCBhbmQgYSBSQVMgZXJyb3IgaXMgQEANCj4gPiAtNjczNCw4ICs2NzM2LDEyIEBAIGludCBh
bWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2LA0K
PiA+ICAgICBpZiAoIXIpIHsNCj4gPiAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3Rhc2tfaW5m
byAqdGkgPSBOVUxMOw0KPiA+DQo+ID4gLSAgICAgICAgICAgaWYgKGpvYikNCj4gPiAtICAgICAg
ICAgICAgICAgICAgIHRpID0gYW1kZ3B1X3ZtX2dldF90YXNrX2luZm9fcGFzaWQoYWRldiwgam9i
LT5wYXNpZCk7DQo+ID4gKyAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAgICAgKiBUaGUgam9i
IG1heSBhbHJlYWR5IGJlIGZyZWVkIGF0IHRoaXMgcG9pbnQgdmlhIHRoZSBzY2hlZCB0ZHINCj4g
d29ya3F1ZXVlIHNvDQo+ID4gKyAgICAgICAgICAgICogdXNlIHRoZSBjYWNoZWQgcGFzaWQuDQo+
ID4gKyAgICAgICAgICAgICovDQo+DQo+IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoKSBpcyBy
dW4gaW4gdGRyIHdvcmtxdWV1ZS4NCj4NCj4gTm93IGlmIHRoaXMgaXMgdGhlIGNhc2UsIHNvbWVv
bmUgaGFzIHRvIGV4cGxhaW4gdGhlIGxvZ2ljICAtDQo+DQo+IFRpbWVvdXQgaXMgdHJpZ2dlcmVk
IGhlcmUgLQ0KPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIv
ZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluDQo+IC5jI0w1NTkNCj4NCj4gVGhp
cyBjYWxscyBhbWRncHVfam9iX3RpbWVkb3V0KCkgLT4gYW1kZ3B1X2RldmljZV9ncHVfcmVjb3Zl
cigpDQo+DQo+IEFmdGVyIHRoYXQsIHRoZXJlIGlzIHRoaXMgYWNjZXNzIHRvIHRoZSBqb2IgLQ0K
Pg0KPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvZHJpdmVy
cy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluDQo+IC5jI0w1NjYNCj4NCj4gQXQgbGVhc3Qs
IGluIHNvbWUgY29uZGl0aW9uLCBqb2IgaXMgbm90IGV4cGVjdGVkIHRvIGJlIGZyZWVkLiBUaGVu
IEknbSBub3Qgc3VyZSBpZiB0aGlzDQo+IGlzIHRoZSByaWdodCBmaXguDQoNCldoYXQgaXMgdGhh
dCAic29tZW9uZSIsICJzb21lIGNvbmRpdGlvbiIgeW91IGZlZWwgbGlrZT8gSXRzIGJldHRlciB0
byBicmluZyBwcm9wZXIganVzdGlmaWNhdGlvbiwgYW5kIHRha2UgdXAgdGhpcyBhcyBzZXBhcmF0
ZSByZWZhY3RvcmluZyB0YXNrDQoNCkJlc3QsDQpTcmluaQ0K
