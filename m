Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344A2C3DA70
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jul 2024 09:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC5C10EB8A;
	Fri, 19 Jul 2024 09:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qIVB5+TQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC82A10EB8A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 09:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cG6GV7vl7EEAbPt0+6oUkrxVTyNViaVG2Xaiy+RBdps42bYXBUBRVGg4ZqinNKcvY3qizHG/2z+t8AhCpP64Y0zIPT9tpaiUFY42CHr7XsUSoUdYKflvfsMI5CKoimTJgTCNKkGTneNmAefSPowjcS30LH4AfYolNmOFixIzq3rvK/Dd/qFqUpL+mzb7qSMr5g8TGYwN2w6wlXeF/gm0pYDuwtC+TSYPEIIQ2k/rcufryKeBD7OFArJ5tHncda9mubc2ppfvMJVrK0RXN3VuJvQuwsV7g66g1TPcUpVhWfU/rUdFAuwVucmNizcFShVktLhvZi8QtVdjUt6c1KbWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zHAOYE3Xumf/+I3dc7oQPsQ2va0Nnu45tcI5P0l0xE=;
 b=AgE7kxcNgk5+yAXWWOGW4lkXHj1bvXlqwPgcwzmfQic0rSqrP8yDID19Y+o9BS7mW6dApiti5ilHa7a1BU/PHWEM9S/sj+1/izPVqRGO0+uB0LvWUj3lBhNicjFncQmhX2b3eeWaPib/ZBjE4IXfTmeMrHkmt+gJYJMo0Q6KdeG7NJs9Ys51EEYZYxZp5/dFAV7uZL2IsIQvNXmjAZOPqWeMzM5pcI6h+vmpx3D9ZLJ8UoNJxT9G1VDNA/JMvFhplsV8THgpUdxUa6Z7zw12rMtGfK47ZlZvk3+SmWffgwz7XF/tbbii5YlQWdA4aJkq0OyVAUL7LEna4c8VoXXGAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zHAOYE3Xumf/+I3dc7oQPsQ2va0Nnu45tcI5P0l0xE=;
 b=qIVB5+TQF8BU3Id27UGIf4UEcSzD2vd0JNbt2z0AgrgJnAa1hdpYW8JKh78SaFS9PXR50P1pZLsWqrAYMTiOEJLHQfWTcARHYNPTPrIU4RcOKxCarI8fNg9Ll3+dvrAamBHRR2KtoV/mP0xS1gOvxNO/P1o41MJYPFBCIQ1fbE8=
Received: from MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 19 Jul
 2024 09:36:50 +0000
Received: from MW4PR12MB6683.namprd12.prod.outlook.com
 ([fe80::9e98:5170:cedb:5505]) by MW4PR12MB6683.namprd12.prod.outlook.com
 ([fe80::9e98:5170:cedb:5505%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 09:36:50 +0000
From: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: reset vm state machine after gpu reset(vram
 lost)
Thread-Topic: [PATCH] drm/amdgpu: reset vm state machine after gpu reset(vram
 lost)
Thread-Index: AQHa2bzH7xjHy0PLOkqL6wAPcmtGebH9xswAgAAAVkA=
Date: Fri, 19 Jul 2024 09:36:49 +0000
Message-ID: <MW4PR12MB66832BAB6EA74EDC8556B440E9AD2@MW4PR12MB6683.namprd12.prod.outlook.com>
References: <20240719091921.1213270-1-zhenguo.yin@amd.com>
 <e9f270ef-aacd-4874-b401-e4871c990692@amd.com>
In-Reply-To: <e9f270ef-aacd-4874-b401-e4871c990692@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d7349115-3a8e-42ab-9f82-9ff1adb04a01;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-19T09:23:24Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6683:EE_|SJ1PR12MB6169:EE_
x-ms-office365-filtering-correlation-id: 36b89bd6-a7c1-4ef6-f027-08dca7d650d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UUZMQmVPZ3Z1aEhRcklUQjlxODEzckV6SitmMzVGUldhQzVMQVI5Tng5bnhv?=
 =?utf-8?B?dnQ2dXVqS0F1NkNpVVZXa0pTZWNUWnQvZGR3OCtodGkweFFieUtEYWVURzRM?=
 =?utf-8?B?eHdaSFNLVEVmMFVlQU91RnZvRWFQVUZmcDE1a3NKak1ZVmRRSmJVUWxqVVlG?=
 =?utf-8?B?TnFDVi9Pb09lYWRPWFFzU09EcDByMXFIdEJzY1RXZ0RXR2dMYWZvNENzWUZq?=
 =?utf-8?B?UE1QdUJNQjJmeHhWclR3L3ZUcmJaTUZDaGNKeTFTb3lBZGFLWGtlRHdOd2x6?=
 =?utf-8?B?czc2TlNDSzNNYXJyQnRKZ3lVSnMvQUUwRHRXam5CWTdmaFZzZFVXOWtmeTZM?=
 =?utf-8?B?alE1c1BoZlo1YTlwaFJORXV4ZDB0d1N5QVBUbDJMWHQ2VTkvZCtSK0lXSkd3?=
 =?utf-8?B?U2tnUU9CbVBPY2ppMHZFcnhBNHFWdjNIcTQrU0p1U3dLMWNGK2lGUzkvR1Zw?=
 =?utf-8?B?N2xPakxaTkoxRW5TeVdBNDFleGlvOVN2RFZhODkyQU5qUXhWcWhETzF5d3BN?=
 =?utf-8?B?anBHY2x6cTVheXdWZ0xxaWpibU5tdFBPOEJIeTQyVm43a29vL0pTZS8wdXlk?=
 =?utf-8?B?YTN2S2tkaTQ2Ymh0WnRpbUdRY2VCSmtURWhUemRhbENBY0ZLbEc0ajBzcEQ4?=
 =?utf-8?B?REtHMElnOFdHS0NZZ1QzWVZRVFdvQ0xQTnd6b2lFRFYzMHJzTHdqemcxNFgz?=
 =?utf-8?B?d3B3Uyt1ZnR6SFM2azVncGQwR0ZibWdSQ3dJR1NQajZFN0JtdzV2Umo3QzF1?=
 =?utf-8?B?U0pyUk1YaURYTWt2Vm12SVFNVCtUY1ptT0lraXVHbHhUbm1kb3kzVWdnaXB2?=
 =?utf-8?B?bTg5eDIwZGNuUUdQVFdIbElFOVkxVVQzdU1kZ3FJMXkrbUV5VGwxcDNGRnBo?=
 =?utf-8?B?Qlh1Q005cnYzdnpJTGFoY1lSVERHbmo3aC9LbXdJWExPVmtYYXdnMktxeDlD?=
 =?utf-8?B?ZTRRdWpWd002NlRQaEQ3VEFhNDVFMHZNVFU1T1ZpYUhRTnZJa2xadGJEUk04?=
 =?utf-8?B?Nng2blYvb2pCVE1YSFRIWmo4MmpmNkUzSDRKM0JEWmlQUXdCclBrSThtT3Zy?=
 =?utf-8?B?eWhmUVY1dW11OHJKTVBTMWpYdEVwdEVJVXY4KzNYRnIrQm5zSzVlV0lmbTU5?=
 =?utf-8?B?Wkg3NlRVZDM0SmsxMW5PdG5BRWovR1dESFpvVklPRnVmYlM1cmN3dGFncXRN?=
 =?utf-8?B?Tzd0NklJSE9palhKN3E0RjllZ3RDOCt5SWVFK3oySVVNaklhUDFENnFFN1Ju?=
 =?utf-8?B?cE1sNkRSTzExSkx1NE5icjM2WWUweHVUclFjbExCQ0xUUW5xZDhPQzFiM0hj?=
 =?utf-8?B?VmdVODljbHVqM05zMUttaTY5cDZUenVNRDI3YXk4Qjg0QXBIVXFobUh1Z21B?=
 =?utf-8?B?dk1idldzTFIzVmFoNjZXVmF5ZHRWYkNzUmpXdkFXcDNnZThvcEpzNUF1eHI5?=
 =?utf-8?B?UHFJMTVKYTdpM05TOU9RUjFqVk0xSFViUDErb0oxVFlqNkFTQ3VZQ1graE9V?=
 =?utf-8?B?M0FYdm4vMVo1aWZnNEluNCtZRDFnZVVCVEFnUmthY203QUR3R1VoNHV6VnNj?=
 =?utf-8?B?SGNBUFRNS2JBNVZhc2NmQng3aVY3RmRTOVNkaldBektQZmtpSld5NVZJV3BW?=
 =?utf-8?B?MmxFR0o5T251RmQ4Yjg4a2FLSVpod0dxTzVEYzdPSjVqMTZLRExNSUlSekJW?=
 =?utf-8?B?NWFBYnpPb2dpRFNKaStScmRpM3R1YmlBUkY1TkppZFM4ZHB0bXMyajlDblpr?=
 =?utf-8?B?R3k1amduQnJ4Z2MyM2xRcFBybkdFNmJwUXZVMGJ6Z0xKQ3kzanR3QU5GMlBS?=
 =?utf-8?B?dGxtSnZmZlpIWEZiU1BHeFBWZlp0RmhRVVFTQ2hvN0IzUUY1L1lScUhqdVZR?=
 =?utf-8?B?ckxPOGN0Z053b2FIdWhNU1hJQmNJNFh3dFRkZ0IvaDUxWFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6683.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2xJZDd2VmpmM0tBbWgyc0ZXYkhLaTdwdFlzNGdHd3cxTG90VEpycUdUbDJ1?=
 =?utf-8?B?OG4vTFpGWkNhMDlWV2JBOCs2STVSSUFMN20xU1BmbnQvZENzUDVNbWswT2NM?=
 =?utf-8?B?WGcwZStpcUlaTzB0UmxOT2pjMmljL1VFU2ExYTVxUzg5bUpVeTIwcUlIK2t0?=
 =?utf-8?B?eHBrL0hybG83b2xoY3h6bkZzdngvekFyb2p5OEN1ZnBSb3NCbWYxWFR6TlND?=
 =?utf-8?B?MGp1NjhqWmUwWTgzTkRkbnBhbjRDVUpyY2lFaEs1elhNbmpPamJsSmxucmN5?=
 =?utf-8?B?MWZFd1ZSYmZtbTZpZnhmMGZDN0ExL0xzc2VzbEI5Z29xMm9QUytRd2x3OXhq?=
 =?utf-8?B?RHBBd0tHRWpDVVo1b0llT044VmZuOGRWWC9Zckc3bENIenBFTlEwVnV4bHBN?=
 =?utf-8?B?NjBvczhSV0drazkzcytJSlRaRVIvVXpwa1B2TjdWcDU0ZS8xY3B2TDVDN1kw?=
 =?utf-8?B?Y09uSTVFS29CSVlkZHlhNUlxV0tQcmgxZE1vbFd6bDZManNwSys0aSthNnhU?=
 =?utf-8?B?d2lhanZESkd4M1RRczRPSW05ZTdPelpYMVNqenlROURzRHVuYUIvVmVnelhl?=
 =?utf-8?B?SVpaRU5Hc0lIeFFXc1VOYWgyT0ljcTA0VHh4NXIveCt4aTFlL3p0L2hJTHky?=
 =?utf-8?B?TlJ5YUFadnJrSkZESzM3SGRWZnp3YUFPdHV4SEZSK1B5RVNmVWpicnpqUGVy?=
 =?utf-8?B?b3h4d2dIMnBtSjgvUHFsNTUxSUZlRXYyWDdORlprVXVMcDAzREJRdmF1eGE0?=
 =?utf-8?B?czdpQXRpTFFCK3VnejFFcXVOVWxZd212S0tTdzV1c3YvT3NITG04cFVvYUp5?=
 =?utf-8?B?U3R3Wmc2LzJMNG1BU25JSUozejBPUVNqNzR0THdSemlkSUhjVWF4TEY2cWZI?=
 =?utf-8?B?VXh5UzFhMG5TQnBqaHBRbTBDMzlvS3JoQitKZ0FmR21jWlpZUFFPalpXdXcy?=
 =?utf-8?B?RmpObHhxTTkvcmNMcm5teVBQZjlyekNrcXB3S1N0Rk5jN3FDMGVBRkxQa0Rz?=
 =?utf-8?B?WVkrY1g0dlpQWGFGMXVVbXJ1THkvYXF3NGZTa3VmMi9WWEsvbUdlS3lFSkt0?=
 =?utf-8?B?c01nRHYvQlliVXF5WWcyd2huYWZjQjNoSU53SXo3VGRvUnFCZmxZQ1pDMVJ5?=
 =?utf-8?B?cnlFUENyVUsyS3JzcTM2ZXBIemNNVnlVWXRtN1ZOZWZmaGhLMkc1elRrd0FF?=
 =?utf-8?B?dXF1SklUNmI2MmNHNVQwa0U0dC9QSmhaNDR4RFk2R1k0b0VFaHVHSFpKc3NU?=
 =?utf-8?B?b1lZMGZvZVdJUjhHaDdtKzFCSFQzUjBtSHhCdG4zZm94UjZ1R05zc0lTaFBn?=
 =?utf-8?B?OUhqYi9rNTZRKzZobmRBUitNVTFIY0xNU05qZG9wK0p3a3RFdmppanFySTlI?=
 =?utf-8?B?YzJUQkI1Wnl6L0V4VmRoZmFvSTFrNmtZN3VOcWV5cGRidzNudU1NRW1JMko0?=
 =?utf-8?B?R2ZVVDVkclVNUkFZcHBkUXl5N1VERTVMeWRYS1FIVFI1ZlUvWWR5T1VRbno4?=
 =?utf-8?B?dE82aVBxN05lVG1mNkw5RjNjcHhDZlg1V2hYdyt5aE5FZzMxc3BYQzg3ZjB5?=
 =?utf-8?B?bmloODlDaXFnZTYrNy9ZSlhIRUtPQzdJN3l4TGtnSmdJUjBPQ2E4Zk13Ni81?=
 =?utf-8?B?WXNxTzhzbDQyN2ZONWI1eTRnLy83a3JIK3hYeVZxQm5rd3VINUlFMmJpTVVj?=
 =?utf-8?B?QzFCMHVUbGtLdHh4LzNnVWtIT2YveFhVdUhDZFpub1J0am5jNVF6UStOWGpO?=
 =?utf-8?B?aEJUYzVYTUl0ZklsUWpXalZtcWdJRmhRbnBPNjhjTi9pcHhVNlo4dzdmbFhX?=
 =?utf-8?B?d2t6eXZJdXVWRHVwc2VGeXluY1FoemJSM0tucWN4V1ZxR2lJYzhWQjgzL3dC?=
 =?utf-8?B?OTJ0OVdFQytPaVlJaGRqV1MxR2pldHZIYzd4b0RmRDBFR1hvSlZQeWhmUS9L?=
 =?utf-8?B?SlJub1VVWVpGa0lkU1MxWm0vRTY3Nm5PTTNpMUN1eDMxano2YVZWblJXUVFG?=
 =?utf-8?B?d3hlNnExRU1aN1AwUDZBOUZwb0kwNjFWbkJNTWx4d05QTGh4UlczYzNWS2wz?=
 =?utf-8?B?R3dwTWFDVjZXdlFqdkpZOTczYU5pMzNySU1ERnZqV0pLS01jRjMwbmloWkdQ?=
 =?utf-8?Q?Q8qg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b89bd6-a7c1-4ef6-f027-08dca7d650d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 09:36:50.0320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fPh7tB77SY/HEVfgTf2rXEAm3Pe0fDpnep5icIweJHe9jxOs7EhT3OcbLXHhag6BzYxD8KG8RLN/XF41MelSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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
Cg0KSGksIENocmlzdGlhbg0KDQpXaHkgbG9vc2luZyBWUkFNIHdvdWxkIHJlc3VsdCBpbiB0aGUg
dm0gZW50aXR5IHRvIGJlY29tZSBpbnZhbGlkPw0KDQpJIHRoaW5rIG9ubHkgaWYgdGhlcmUgaGFz
IGEgZmVuY2UgZXJyb3IgYXBwZWFyZWQobGlrZSBhIHBlbmRpbmcgU0RNQSBqb2IgZ290IHRpbWVk
b3V0IG9yIGNhbmNlbGxlZCksIHRoZW4gdGhlIGVudGl0eSB2bS0+ZGVsYXllZCB3aWxsIGJlIHNl
dCBhcyBlcnJvci4NCg0KSWYgYSBncHUgcmVzZXQgdHJpZ2dlcmVkIGJ5IGEgR0ZYIGpvYiwgYW5k
IHRoZXJlIGhhcyBubyBTRE1BIGpvYiBpbiB0aGUgcGVuZGluZyBsaXN0LCB0aGUgZW50aXR5IHdv
bid0IGJlIHNldCBhcyBlcnJvci4NCg0KQmVzdCwNClpoZW5ndW8NCkNsb3VkLUdQVSBDb3JlIHRl
YW0sIFNSREMNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hy
aXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiBGcmlkYXksIEp1bHkgMTks
IDIwMjQgNToyMiBQTQ0KVG86IFlpbiwgWmhlbkd1byAoQ2hyaXMpIDxaaGVuR3VvLllpbkBhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGRybS9hbWRncHU6IHJlc2V0IHZtIHN0YXRlIG1hY2hpbmUgYWZ0ZXIgZ3B1IHJlc2V0KHZyYW0g
bG9zdCkNCg0KQW0gMTkuMDcuMjQgdW0gMTE6MTkgc2NocmllYiBaaGVuR3VvIFlpbjoNCj4gW1do
eV0NCj4gUGFnZSB0YWJsZSBvZiBjb21wdXRlIFZNIGluIHRoZSBWUkFNIHdpbGwgbG9zdCBhZnRl
ciBncHUgcmVzZXQuDQo+IFZSQU0gd29uJ3QgYmUgcmVzdG9yZWQgc2luY2UgY29tcHV0ZSBWTSBo
YXMgbm8gc2hhZG93cy4NCj4NCj4gW0hvd10NCj4gVXNlIGhpZ2hlciAzMi1iaXQgb2Ygdm0tPmdl
bmVyYXRpb24gdG8gcmVjb3JkIGEgdnJhbV9sb3N0X2NvdW50ZXIuDQo+IFJlc2V0IHRoZSBWTSBz
dGF0ZSBtYWNoaW5lIHdoZW4gdGhlIGNvdW50ZXIgaXMgbm90IGVxdWFsIHRvIGN1cnJlbnQNCj4g
dnJhbV9sb3N0X2NvdW50ZXIgb2YgdGhlIGRldmljZS4NCg0KTWhtLCB0aGF0IHdhcyBteSBvcmln
aW5hbCBhcHByb2FjaCBhcyB3ZWxsIGJ1dCB3ZSBjYW1lIHRvIHRoZSBjb25jbHVzaW9uIHRoYXQg
dGhpcyBzaG91bGRuJ3QgYmUgbmVjZXNzYXJ5IHNpbmNlIGxvb3NpbmcgVlJBTSB3b3VsZCByZXN1
bHQgaW4gdGhlIGVudGl0eSB0byBiZWNvbWUgaW52YWxpZCBhcyB3ZWxsLg0KDQpXaHkgaXMgdGhh
dCBuZWNlc3Nhcnk/DQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gU2lnbmVkLW9mZi1i
eTogWmhlbkd1byBZaW4gPHpoZW5ndW8ueWluQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMTAgKysrKysrKystLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IGluZGV4IDNhYmZhNjZkNzJhMi4uZmQ3
ZjkxMjgxNmRjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0K
PiBAQCAtNDM0LDcgKzQzNCw3IEBAIHVpbnQ2NF90IGFtZGdwdV92bV9nZW5lcmF0aW9uKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSkNCj4gICAgICAgaWYg
KCF2bSkNCj4gICAgICAgICAgICAgICByZXR1cm4gcmVzdWx0Ow0KPg0KPiAtICAgICByZXN1bHQg
Kz0gdm0tPmdlbmVyYXRpb247DQo+ICsgICAgIHJlc3VsdCArPSAodm0tPmdlbmVyYXRpb24gJiAw
eEZGRkZGRkZGKTsNCj4gICAgICAgLyogQWRkIG9uZSBpZiB0aGUgcGFnZSB0YWJsZXMgd2lsbCBi
ZSByZS1nZW5lcmF0ZWQgb24gbmV4dCBDUyAqLw0KPiAgICAgICBpZiAoZHJtX3NjaGVkX2VudGl0
eV9lcnJvcigmdm0tPmRlbGF5ZWQpKQ0KPiAgICAgICAgICAgICAgICsrcmVzdWx0Ow0KPiBAQCAt
NDY3LDYgKzQ2NywxMiBAQCBpbnQgYW1kZ3B1X3ZtX3ZhbGlkYXRlKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwNCj4gICAgICAgc3RydWN0IGFtZGdwdV9i
byAqc2hhZG93Ow0KPiAgICAgICBzdHJ1Y3QgYW1kZ3B1X2JvICpibzsNCj4gICAgICAgaW50IHI7
DQo+ICsgICAgIHVpbnQzMl90IHZyYW1fbG9zdF9jb3VudGVyID0gYXRvbWljX3JlYWQoJmFkZXYt
PnZyYW1fbG9zdF9jb3VudGVyKTsNCj4gKw0KPiArICAgICBpZiAoKHZtLT5nZW5lcmF0aW9uID4+
IDMyKSAhPSB2cmFtX2xvc3RfY291bnRlcikgew0KPiArICAgICAgICAgICAgIGFtZGdwdV92bV9i
b19yZXNldF9zdGF0ZV9tYWNoaW5lKHZtKTsNCj4gKyAgICAgICAgICAgICB2bS0+Z2VuZXJhdGlv
biA9ICh1NjQpdnJhbV9sb3N0X2NvdW50ZXIgPDwgMzIgfCAodm0tPmdlbmVyYXRpb24gJiAweEZG
RkZGRkZGKTsNCj4gKyAgICAgfQ0KPg0KPiAgICAgICBpZiAoZHJtX3NjaGVkX2VudGl0eV9lcnJv
cigmdm0tPmRlbGF5ZWQpKSB7DQo+ICAgICAgICAgICAgICAgKyt2bS0+Z2VuZXJhdGlvbjsNCj4g
QEAgLTI0MzksNyArMjQ0NSw3IEBAIGludCBhbWRncHVfdm1faW5pdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sDQo+ICAgICAgIHZtLT5sYXN0X3VwZGF0
ZSA9IGRtYV9mZW5jZV9nZXRfc3R1YigpOw0KPiAgICAgICB2bS0+bGFzdF91bmxvY2tlZCA9IGRt
YV9mZW5jZV9nZXRfc3R1YigpOw0KPiAgICAgICB2bS0+bGFzdF90bGJfZmx1c2ggPSBkbWFfZmVu
Y2VfZ2V0X3N0dWIoKTsNCj4gLSAgICAgdm0tPmdlbmVyYXRpb24gPSAwOw0KPiArICAgICB2bS0+
Z2VuZXJhdGlvbiA9ICh1NjQpYXRvbWljX3JlYWQoJmFkZXYtPnZyYW1fbG9zdF9jb3VudGVyKSA8
PCAzMjsNCj4NCj4gICAgICAgbXV0ZXhfaW5pdCgmdm0tPmV2aWN0aW9uX2xvY2spOw0KPiAgICAg
ICB2bS0+ZXZpY3RpbmcgPSBmYWxzZTsNCg0K
