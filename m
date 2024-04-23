Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9CAC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 08:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D296A1131C7;
	Tue, 23 Apr 2024 08:12:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rm58qf4c";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 986161131CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 08:12:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6fT9bD/KBRC5CNN/5RoNcN5SwNGsa0vwPCIvb8GRQQMtMVYBfKFRsRd5Pg/0mzi9njueEIZ0oxUFs+0VbVJK5hHJpqfveI1El7kaliXU8BGpbSApSVjTDMzHB8eDPtvdTh93bjdiXuGpYKAy8zqcw9ccIpRyWGWpdw1Co9noPgQngOm9DN/3P+hi+CwQl8S9ypRCFcapzWbFwWYXAvyuUR+FLpyItxv9FE5JrBa29YzDkZklcIlZ/0scD01Rt5Fn51yAJItbgtzpqV6+ONc2xo2DHMXgD1KFLNAqEPuWGP/gpYTYdgiwHlMdumlb+hPeEsjX6PZv/UVv1vwq7GFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbLNCNZWmyu8QHtjaQyazkxAFq+eAzGXHtarf1958h8=;
 b=HKKTLRB1pCED5BM1wqiVknoqSWVuOgf/veOR+rlvtw6bJxbVKpwAO7dYLnbRXSQVGzFhD67Lls4HGqF2LreQefc0hGN8KYZZM1wfJtZ7wsoOaIfnV7VfKqhhebngFuvf1vOyM0GlP1W+M2g+xfRy00W6NwmkuEwC15BMQXJCuonpcPDCCpOb1xutOcYXrgpDgQWgxjZqr3aH6WdsYUzSPmlR6ouu8v1pJKi3tuIrBMvjvtEF0gkKYzWcX8BiGAWpoSfS4XYznUjB8ociVrZnZCQAWd75sxVKbjZuGqBDXPL+fJxj1jgmTfQ4od2SL2M8Ih3KWu92xQIQgK/krwmkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbLNCNZWmyu8QHtjaQyazkxAFq+eAzGXHtarf1958h8=;
 b=Rm58qf4cuF30Fp1WZiAeyuRTIoRTRsFm41L1tgrOFq0mOOEdK/xyq9Te+Xo6iWRnShVKYTPAQFkz2mAajgVKhYljFW3pN2zaudsmAaarN8qgBctjjX5a7DadhwuiXbHmuqXvU0nVajmm7NBkckL7XdoThUkB9QCkZRLepoZAK2k=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Tue, 23 Apr 2024 08:12:10 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 08:12:10 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
Thread-Topic: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
Thread-Index: AQHalUeaalRAQhE8DEyHzT7uU164w7F1eReAgAAA7FCAAAXWAA==
Date: Tue, 23 Apr 2024 08:12:10 +0000
Message-ID: <CH3PR12MB8074838DBE40AF8978A976FEF6112@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240423062853.1022925-1-Tim.Huang@amd.com>
 <5456f6b4-7fc4-4ac1-b85e-cf3b00b5c4c6@amd.com>
 <CH3PR12MB80747050F8AAA33C6F32851DF6112@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB80747050F8AAA33C6F32851DF6112@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b2619c08-234d-45e4-a7cd-a7360bd9bd12;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-23T07:46:01Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|DM4PR12MB5963:EE_
x-ms-office365-filtering-correlation-id: 6e309d84-fe9b-410f-cb62-08dc636d1311
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?U0dDMzY4MmZZSC84V1NnZm9MK3plSnlvYVdOaU54VEQ4ZUhCajlkdGVnSmxZ?=
 =?utf-8?B?UjZlUnNhb3g4ckJYa1NRMjJCcytreVBPTnFlbllZb21PVnVzMkZpRHVUWjVs?=
 =?utf-8?B?OXBnNHppdVk5NTNkb2ZuUnlaSmp0NGVRMjBVczI5ZVhCVjJnOVhxbkROc0p4?=
 =?utf-8?B?K0UzaDZTTmpsY3hYVXZ4MlhpQlJrZzJ3VG0vUUFRRFZBL3pDcWwyOUlPT1VT?=
 =?utf-8?B?RGc1SnVOYTZXeURoVFNmQmNJdzFtRHNMVmJITG9ncWQyM2dvZFFoVWZuN2tD?=
 =?utf-8?B?QndZL3ZZN0c4RTl6Yjg3STRvUHR1TmxrYXR5ZlJNUkNWeEhROGJkeXdEOXBx?=
 =?utf-8?B?WmVRM05zazBtT3NYKy93VlcwYlJmbndyZEpIdUllSEcvODU3d0pTanY2dmhr?=
 =?utf-8?B?TVZRcS83N012ME9jMmxUR1ZtRis4aEVZM3lWOVFFbWI4RitHTXhENm1mU0F3?=
 =?utf-8?B?MFRGNnRTZDBoRzg4VTZtSitzZWZGMVVlNjZjckVsYzByUE1RbXpTZ3RyamlB?=
 =?utf-8?B?ZlFNZ0FYdERQck9IVFU4LzdsRmJMOHQ4WnJ3d3VONDNpS3c2U0Q0QWZueEcz?=
 =?utf-8?B?bFhOUEpoK3paT1pXWkdxbXJ1dEV2TWdtUi90SGl1NjlxL2hCMENrYUpVZmxJ?=
 =?utf-8?B?TmJMYnN6ZlBDVk83MWwxNERnYk11YzUxK0Z0dlRlblpEczB6ekNCekx4dkti?=
 =?utf-8?B?S2JKOHU5WFV4b2RsMHp4UFUzb01wcDVVZUdwTk45anVsN2E4MTlLY2dhV2NP?=
 =?utf-8?B?ZU9mRURQb0JxQVlVNG5XYk9CUFlJSWs5TWp5VGxXZGNKMFF0K1lZSldFeGR0?=
 =?utf-8?B?L3BVRUpYcWt5YkhpN2IzZGdvWUFmMyswT2Yvc1l2RnRkd21yc1FSSTd5L0dE?=
 =?utf-8?B?RmJqRFpGQnVseVBiaExNUVlNMUQ2b2VVRDR4aXlialc0bnVIbFZWSjVCS0Zx?=
 =?utf-8?B?OGExTlM2Vy9mQ2QyeE9KMDA2YWVkeC9sSW1ISkwzalpLSmZ3ekNWdmtpZnYv?=
 =?utf-8?B?czg5TXJsZ2RrVG04SVE0N0hNUHJjWG55N1NBU0x3MEttNFRNNVgzNWxzb1hK?=
 =?utf-8?B?ZnNDbGNQNWN5VWVFdWpkQWxjU3Jpb2NYcWRJY3E5emFYOGh5Ri9FVVdtbUYv?=
 =?utf-8?B?d3FWZG41QjBkSzlWRUtGUEg0K2hnL3hpeVdyc2lYbTgwemJXMmM1Y0pmOElO?=
 =?utf-8?B?bmRVc0phMWlEMjE1T3dPTGIxMngzdGRUdURBaStLQlJDTDY4TURKVXdPbVBt?=
 =?utf-8?B?ZjlQb3hpTHB2bW5sUHdCdEo3cjZXeVdHYkNXeFdjaGdNaFh1TnIya1RuazdC?=
 =?utf-8?B?dHpxNHc0enQ4NDdIdytIQml2T2lWTWhwOGlIWWxHZEtLdXhxSHpxSjRhZUI0?=
 =?utf-8?B?OHpVYUFVTWdtakFXa1FGOVI2U2tLbGVuU05TSlFPWDZ0ZVpwSlR5TzBVblZC?=
 =?utf-8?B?eThSS3RZR01QYTlmeGtVY01SaUdlNi84TFlNaGwxY0dTOFFTby83MTRqZU9S?=
 =?utf-8?B?R1NTUkJvenZjR2ZkZUxXUlg0cnF5MDNRdUpDbTJKMTArNnU1M2dzbXVMYkQ1?=
 =?utf-8?B?b3hxUGE1eWs1dHNSenhRQTRsYmVTZitDMzNkWnpheEFrdDZ5NVJGNHVpKzJ0?=
 =?utf-8?B?MG5MNlZTeGViWWYvSnpyUUxHaHJOYng4ZjJMZDArdHBQZTZFTnFRTjJBSUdj?=
 =?utf-8?B?MEpmb0JKR2pBUkowRzg3bkZFR0dFVkRnOWg4aUExYmhGYm00aWFlR2RRTldl?=
 =?utf-8?B?MGdQZUhUS2Uvd3hHV0p5U1VRVzVKQzNBdWVEZDk2cGRPM2RJNXdvaFFZOHFo?=
 =?utf-8?B?VjBjRHU5TkdVWHcvRGN2UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REExRllGZmNZcUN5VGJ1WmVubmJ2cE9KOGN2SjhyWDl4VitkakVkZitKeFJ1?=
 =?utf-8?B?N202cHNwVHNhcXVHUUtlNVQvRGxKM1djRzFuNEdydHNlSTB6Wm0rck9OUjB6?=
 =?utf-8?B?M0Z6d3pMZXJHbVJJbXBrOXhqYXE3RnE3clozMjNJNS9jQXFrNlNyYTVrcmlw?=
 =?utf-8?B?cFNBU1ludWthRVl6VWNDdVFBVXZYRlIxOEdvYkZVOUxOUUhFaURSVlVBM0s3?=
 =?utf-8?B?dzNwZzY0b1cxT0xJVVhwcmNxOXByRDU5dG9lS0NOQ0hsS1owNnVuL1FZRDdy?=
 =?utf-8?B?L2tMQWZkVm9CbFdaSGNBQk94WjNYSDBvNzFhTlJnUDJVOWhWOE9OTFJGUDJx?=
 =?utf-8?B?c3UwSW1uWDJzK3YvOS93SXVITW9oazRzTlgrZzhHTW40UEc4d3EzTUFIZGJO?=
 =?utf-8?B?WWhReVdHeXRmMWR4VGUraE9TNnRhYjNaVjJOTXZRRjdxblYxK3NnTHBGcVlx?=
 =?utf-8?B?bi8walREdk56OFNaZWJiRUY1OW16OVFGaHAvTkdWL1k0czlWYUlWNXM4YzN0?=
 =?utf-8?B?VWZ0NkZJd0J0Z3F0aUxlZzdzYm5FWSt3ek40SVVBMUxWNUpxT0ptQUFkQjV1?=
 =?utf-8?B?cHByaVlFcTlsVDI4SXJyOTY2MXBDMTlaMmxRZVNPQjZNUTNwTjBxd3dyWmFJ?=
 =?utf-8?B?clY4aEFtUFNEUFZpTW1qL1hMQjErS2tQSVpmNGRpQ0pyOGRyb1cybDErcXUw?=
 =?utf-8?B?d25SaWQ5YkxrS2xGUHJnb1lxRFBIbVF0bkp2QUhlU01oMGsvcGFSMFFVTEQ5?=
 =?utf-8?B?ekR3bFZsQ0tEY3g2YWh4M2g0SmczbWpDdm85NVZUVXhMS1Q0bndEMjJQa2hq?=
 =?utf-8?B?cE9vcGg5Qm43d2RWbTlBTVJHaktQRGpoMU9CeE8yeHZjV0tUM21GSTJxbjl1?=
 =?utf-8?B?RHA1Kzg3Yk00cko0eUc5RzRWUU9rQ2o4QkZyM1ZCeDBJZGxrVE14R3RidTB4?=
 =?utf-8?B?KysvN0FLaTlXc0oyVVMzSEpCT1lRTjlxK1pmdnV6bGpnUmQwMnpSUUZtOEt0?=
 =?utf-8?B?QXU0UGVhRmtmMElhYkpWTXhKL0J5WUkyeEdBcnpsTTVqNzJKaVJpcThIRUpl?=
 =?utf-8?B?VzRsTnRTbHU4bzU5d2JjM2JDNXQ1MW15NElUV1FxOTk4a1c0dlFYS3pVWVFx?=
 =?utf-8?B?SVBsN1pPeUNLck1kUW13VEUvY3R5UW1PYVdYYVloWDFnT2g1KzNmZGhRNFNY?=
 =?utf-8?B?cmRuQitBUlZPbVE4cFEzc1p6RjJLTWFReDVKWG1rakx2aHB2N05mUnJ3c1lt?=
 =?utf-8?B?VUdhUExVdWZ0c2RVKy80cVZFODZYeTVSK1B0WjRIdDQwWG81cFZmaXhUY3g2?=
 =?utf-8?B?bHFzV1Y3ZU9xaCt2L1RldUFMK2NTN0krZXdKUWJGKzBuVkk3bWtRK0piYUtu?=
 =?utf-8?B?aEJCdXBBU3lianlmd1B0cjhDR1NDWVZFeHJSZFdpNzBSclczNzB2VWsxRyt5?=
 =?utf-8?B?UEhOeDlueURxa3BjZ3JOMzBxbFlEMy9KMWxPQURaSFJ5NWpFUEV0dFYvT2R3?=
 =?utf-8?B?dnpjTVh6emxrcndiNzZ0QkFTN0FXbytBaWhvZ3NIYk9QS0RDakhUaEpkMm5V?=
 =?utf-8?B?K0NNdldjL1BpVHVJVjhwVjhqY2dNTGE3djh0Ukh5STZySVo2aUpmd0I3dm5Q?=
 =?utf-8?B?L0Q5NjRRV3hvODZpMTVrWXE0a2N6Z0E4RVJ2SjhBenRGckV0bUZ0MWZJMUpI?=
 =?utf-8?B?WUliVU1waXh2aHhyclpXNlVPdlVZbjBPUnFHOVlYNk9MUnViWWxyZUFWVHJw?=
 =?utf-8?B?dmtkUVozUHBiTEdJMU5YNVkwaEVoZCtLSnRQR0xTcXJ6ZGZxcmd1Mklldmcy?=
 =?utf-8?B?UlpvSkxBd0pZRG9vRVRtaVFDNkt5R1N3MUE1NGVRU042am9WMlpNdXY2anph?=
 =?utf-8?B?Vmh1dVZ3WGtjTVdJVHFkemJqOEhjY0lwbERoY1JuN1ZCOVRueElDNkVRZy8x?=
 =?utf-8?B?Snl4SzUvN1JCRlROYktqenI4VE5JTFVEcDRnTG50WStEN2FLcTg2MkQ4R2Rx?=
 =?utf-8?B?ZGkveVhGbHZsNnEySlprQUdRZnMydE5LeVo1M2RuTUFzMGhSTDlvWFRiMDla?=
 =?utf-8?B?UW1JYm9yR24vMHA5MVNVbG1zWjA5UmRIWWJ4RnVXVFhUb1QyOXo3ZG1xSXVB?=
 =?utf-8?Q?sAXA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e309d84-fe9b-410f-cb62-08dc636d1311
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 08:12:10.2013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajZYGMqCgqWyGDd/C48Hr6oaG/ESWwUqVAq9ntAnA/WEFYFdSMsDYPN2Q3bwekLcJFxafmRcM7ldl4ZvHV26GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPiBPbiBCZWhhbGYgT2YgSHVhbmcsIFRpbQ0KU2VudDogVHVlc2RheSwgQXByaWwgMjMsIDIw
MjQgNDowMSBQTQ0KVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NClN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9h
bWRncHU6IGZpeCB1bmluaXRpYWxpemVkIHNjYWxhciB2YXJpYWJsZSB3YXJuaW5nDQoNCltBTUQg
T2ZmaWNpYWwgVXNlIE9ubHkgLSBHZW5lcmFsXQ0KDQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0g
R2VuZXJhbF0NCg0KSGkgQ2hyaXN0aWFuLA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6
IFR1ZXNkYXksIEFwcmlsIDIzLCAyMDI0IDM6NDMgUE0NClRvOiBIdWFuZywgVGltIDxUaW0uSHVh
bmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4g
PENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRn
cHU6IGZpeCB1bmluaXRpYWxpemVkIHNjYWxhciB2YXJpYWJsZSB3YXJuaW5nDQoNCkFtIDIzLjA0
LjI0IHVtIDA4OjI4IHNjaHJpZWIgVGltIEh1YW5nOg0KPiBDbGVhciB3YXJuaW5nIHRoYXQgdXNl
cyB1bmluaXRpYWxpemVkIHZhbHVlIGZ3X3NpemUuDQoNCj4gSW4gd2hpY2ggY2FzZSBpcyB0aGUg
Zndfc2l6ZSB1bmluaXRpYWxpemVkIGFuZCB3aHkgc2V0dGluZyBpdCB0byB6ZXJvIGhlbHBzIGlu
IHRoYXQgY2FzZT8NCg0KPiBJdCdzIGEgd2FybmluZyB0aGF0IHJlcG9ydGVkIGJ5IHRoZSBDb3Zl
cml0eSBzY2FuLiAgV2hlbiB0aGUgc3dpdGNoIGNhc2UgIiBzd2l0Y2ggKHVjb2RlX2lkKSAiIGdv
dCB0byBkZWZhdWx0IGFuZCBDb25kaXRpb24gImFkZXYtPmZpcm13YXJlLmxvYWRfdHlwZSA9PSBB
TURHUFVfRldfTE9BRF9QU1AiLCB0YWtpbmcgdHJ1ZSBicmFuY2gsICBpdCByZXBvcnRzICIgdXNl
cyB1bmluaXRpYWxpemVkIHZhbHVlIGZ3X3NpemUgIiBieSB0aGlzIGxpbmUuDQo+ICJhZGV2LT5m
aXJtd2FyZS5md19zaXplICs9IEFMSUdOKGZ3X3NpemUsIFBBR0VfU0laRSk74oCcDQoNCj4gSXQg
bWF5IG5vdCBoYXBwZW4gaWYgd2UgY2FsbCB0aGlzIGZ1bmN0aW9uIGNvcnJlY3RseSwgYnV0IGl0
IGp1c3QgY2xlYXJzIHRoZSB3YXJuaW5nIGFuZCBsb29rcyBoYXJtbGVzcy4NCg0KSGkgQ2hyaXN0
aWFuLA0KDQpJIHRoaW5rIGl0IG1vcmUgdG8gZml4IHRoaXMgd2FybmluZywgbWF5YmUgSSBuZWVk
IHRvIHByaW50IGFuIGVycm9yIGFuZCBqdXN0IHJldHVybiB3aGVuIGdvIHRvIHRoZSBkZWZhdWx0
IGNhc2Ugb2YgInN3aXRjaCAodWNvZGVfaWQpIiAsIHdpbGwgc2VuZCBvdXQgYSB2MiBwYXRjaC4g
VGhhbmtzLg0KDQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBUaW0gSHVhbmcgPFRpbS5IdWFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ2Z4LmMNCj4gaW5kZXggZDk1NTU1ZGM1NDg1Li42YjhhNThmNTAxZDMgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gQEAgLTEwODQs
NyArMTA4NCw3IEBAIHZvaWQgYW1kZ3B1X2dmeF9jcF9pbml0X21pY3JvY29kZShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgY29uc3Qgc3RydWN0IGdmeF9maXJtd2FyZV9oZWFk
ZXJfdjJfMCAqY3BfaGRyX3YyXzA7DQo+ICAgICAgIHN0cnVjdCBhbWRncHVfZmlybXdhcmVfaW5m
byAqaW5mbyA9IE5VTEw7DQo+ICAgICAgIGNvbnN0IHN0cnVjdCBmaXJtd2FyZSAqdWNvZGVfZnc7
DQo+IC0gICAgIHVuc2lnbmVkIGludCBmd19zaXplOw0KPiArICAgICB1bnNpZ25lZCBpbnQgZndf
c2l6ZSA9IDA7DQo+DQo+ICAgICAgIHN3aXRjaCAodWNvZGVfaWQpIHsNCj4gICAgICAgY2FzZSBB
TURHUFVfVUNPREVfSURfQ1BfUEZQOg0KDQo=
