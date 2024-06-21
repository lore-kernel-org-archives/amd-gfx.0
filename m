Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D7EC2BA18
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 02:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A5910E054;
	Fri, 21 Jun 2024 02:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NsLNTKNS";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E80E410E054
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 02:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZ7O1e3daUU1JaPVYBdtSR8R5jQXOWYaRBBVfCMq0YSIvEWFLxj/BgXgo9zybxMl151DvU0XsAEnVPC08AK5F5tw+kcMistR4bD/z75CgxZMKHzaJZKIm99vEMvNLC+q0pCiHTC4FP0+YEy+O3xrh+rsrRuA1YiwX4gVbZ0AKx/iiL2Wq4BisqijwTS9mAmH2IGVLktiKAK4ngjXld1ZSYmidso/vWYox0mche5lglW3Yd5NSczCqPe7oNKh2puu9wozBOC4VDqk71bT3xyUXIW3+12l2dK4/0w5cY7D2hZCOz+dSZC5yLelXa5+WpRVAFKjysujahdvbVmlA3msXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyXN2ImK58uhyUIIpWhKH4zQmcAjKAa9dDvNq/+CLfg=;
 b=KOChCbuW+NW6ripVZylwMhFgz0dMWC8Ky/QcgYcios/mxTkiuXFkWDiY7bufLBzkEa+OU6xMwcuKIY9GUlEFJdqEuW0vRGMAVSUfWy3G9fpGYhnJxCM8/0mYC26fJQtxB6aUReRinyW1a9HXw9e+gbvEaNoq/q/XsSIkRSrBlnyMINb8L050MAHELDFC5FjtCQCm899rk8R4fkjrSwIW0fa9bJjC9mtiawprYJmadGboSFYvOP+cFKaVjOTiNuxyFK8CiGFNzsMxsWY/PJeEcPX0rz3KG8gD9ORyXJpbZ3xLB45EvJofvMeBM5ZKOIbb5WqMVGBhH9iGq7rrQ9BZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyXN2ImK58uhyUIIpWhKH4zQmcAjKAa9dDvNq/+CLfg=;
 b=NsLNTKNSe9aDDQqduzuEn+SIvOgI6o1H4VuLeismwHvK+Iq9pFNQxxJWxnHPRf+4IBh2fdY2Xk52uQgUtKk9MWKgsyU+3PdtRNJlF0yVZ3fdcGm4Hwzg3YNVu4H6GwMYgb0/HW6l2D7WV1UI1eNEeaPrxhxGVjhsRd1OL+QeMQk=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by SJ2PR12MB9189.namprd12.prod.outlook.com (2603:10b6:a03:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Fri, 21 Jun
 2024 02:46:43 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 02:46:43 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add missing error handling in function
 amdgpu_gmc_flush_gpu_tlb_pasid
Thread-Topic: [PATCH] drm/amdgpu: add missing error handling in function
 amdgpu_gmc_flush_gpu_tlb_pasid
Thread-Index: AQHawuUaclxYfiz59Ey0SO+gSpPvvbHQvwmAgADFXiA=
Date: Fri, 21 Jun 2024 02:46:42 +0000
Message-ID: <CO6PR12MB53940C876217D0BB848D186194C92@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20240620074006.11922-1-bob.zhou@amd.com>
 <CADnq5_Oz3cBte-8R3aEYcay5bTrbm6X9qV391e-aFUSdmiViRw@mail.gmail.com>
In-Reply-To: <CADnq5_Oz3cBte-8R3aEYcay5bTrbm6X9qV391e-aFUSdmiViRw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1eb794c6-ada3-4d9c-8fc7-f3c3d1316543;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-21T02:45:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|SJ2PR12MB9189:EE_
x-ms-office365-filtering-correlation-id: e707bcda-5199-41c5-c82d-08dc919c624a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?a1htVzh5NU9FNWYzRFYvK0ZOdWpMcUFzYXp2dDJCcHdDdnhyWnBUa0FPWTlv?=
 =?utf-8?B?L2oxWDVZa3JONUZzdlY5UWx1dTBSakovbWdqR3p1NnpCVFdNeU9xZHMzZWt5?=
 =?utf-8?B?Zkx5bjVZZFRjOW9SbEJzR1M1WHVHanNmcDhJVjhGNDdaaEUrWXNtSjVwN1BO?=
 =?utf-8?B?cXlDcTdXREtmOTZRMlJUcUFuSU1ISG5MTmZvU3FydDU3YXBNQy8zZ0hmVWgw?=
 =?utf-8?B?TDhOemRSMGZseEt0RDE2WFFoVkE5VkdMMGJpZ0Z1MmREZlhJWmtzaUwrYjFo?=
 =?utf-8?B?NWNoS1hvRXRQWTJ4WW91QzRuRzBpWVQ1Nk1CaEZpb2ozSldrcTkyeXYyM1M3?=
 =?utf-8?B?S0hoRUtiZTZQU0w5SFZ2WW9qajNoQTFLMDFwMTAxQWJad1U2RTkzak1DSXRK?=
 =?utf-8?B?VXlzR0NpMHRJcFhIeDRqbTVGMnVTM0NsRTY5WVhUbnhnNit3ZjhhUVhSbFdx?=
 =?utf-8?B?UURmalV6U3c4RU9RWHg0YkJqWW9jcXI5ejB3WUVVMmtKK1cvcDlCSWFVVXov?=
 =?utf-8?B?RnFrbjlIRUcwMEdnenNtT2RmVzVHOExGeWE5S0dDTDJhajY1M0hTbk1UMWo4?=
 =?utf-8?B?Q2lhcllqNFgvbVJhZkNlbWhCZ2QweWhDRHdIT3hReStBMTdUTlAvQ05kQkoz?=
 =?utf-8?B?VDM4MVB6QzIrZStIdTRwek5KMlM1cTJibndZczVCR1ZzMDZxRXkrR25uRnQz?=
 =?utf-8?B?cUV6cW5jbGlsWjRxbDY2dTlFeGErbk9NZmFjS014aGw0VUc1SlRmK0diMXlx?=
 =?utf-8?B?UUIxVjB1YjM3Q1BzTHM4MmV4YjJEYTRYTVBmZzZmR3dHMzQrZFM3eXRqZ1py?=
 =?utf-8?B?UmtWMlc0c0lPVlpyakxFZE95dTlwTDRaNWtvY3pjUm03aU9CK2xUcC9xSlRP?=
 =?utf-8?B?L1ZUR2M3bHpYN0JncG12UGg1LzgyM1lyTUhwazFSL1VXWVF6SFh4dS9mTE5h?=
 =?utf-8?B?OS8zdko2MHY1OXZnSzI4czFFQjRZL1lHcURhVld1cEw5NDJOT01XNnVRMU9C?=
 =?utf-8?B?Sk1zRkwwZWxOQmZLQnppTDJ6bnhBVHVzQTJvNWhuK1NNRDFaMFkrdzEvUzl4?=
 =?utf-8?B?ZWRtbHRjNUZNVUJmb3picXVoNUYva1ByY0JkT1o0QlRueVg3WTJLMjFWaE1I?=
 =?utf-8?B?OVk1dDBDaXFCcFhsY2NGV1BQbE1hTTdScVJMOUVjWmdrU3B6cTVURDZKaGJ0?=
 =?utf-8?B?MDIydytZdTlhaEVhQTZHVkdicXZkVHRJVjl3ekhITmV2U2VRTHBLb0x3S1BQ?=
 =?utf-8?B?ZFE1clJkUWpzQjEzWVFlMXRzVS94bmhTTUt4K1lTeE9RdEZLQi9VbzhlMGR5?=
 =?utf-8?B?VVd0NThUUXZYck1jbVVTR1FBQmM0K2Yrc1FMYm1nNUVlUWp3bmpXUFhoUjNF?=
 =?utf-8?B?NXAvRXd3T2NMaEk3UDE2Ym1CaXlrcG1DTUxwVEp0Y1hkVU4vYmVWWFBBOXU3?=
 =?utf-8?B?a0xHQ0JNZmdQZWdGU0lCZ2xUeFQ5RDFlTDFGQ0M0L3N4WlhlQXhkQXJ0NEEr?=
 =?utf-8?B?Qndqc3FrekkyOU1vVkN1RjB3ZkN4djhXTkh2RWVvR3NxUGZ2OTRYa09pblBz?=
 =?utf-8?B?MlpsYkN4Q05GU05tU2ovUTh1MUp5Wkx3T3dkWXRNb0R4ZnBoN2d4Yy9LZmtT?=
 =?utf-8?B?bjBkditQaXR4NU1PN3RzYWJFV0VTQUY4dmFrZG9RbUFNUjBBZUU3WjdiUWZ3?=
 =?utf-8?B?dEVtSnRXM1Vzb3I1TDhGT01WN0xOVUUxK2FKWXAxRHF0WGpnaWNxQktucGJO?=
 =?utf-8?B?Sy95cEh0c0RoengwOVJJY0dtSS9MSktYK1hGYzZrRVlJamhBc1A3Qmd1UlJq?=
 =?utf-8?Q?09BFo6e6SmafR+bh+m0YpDaHCGv71g0ljtLEw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWcxd0xOUXRVWGw1cE1oaFdKYnRJVGE2VDBkUElVVE9BSzFuM1BoUzZxNDJ4?=
 =?utf-8?B?TEk1cDUyTGZ0MnJXaG5CZHFEMmlYNWRnRmRDTlp5bWZPVXFXV0c4NWc4VGNL?=
 =?utf-8?B?WEVCMmdBQ2UrazYyMGRzQ21pTHd0VWxseUs4ODJrQzJMZHFkd0YvUnRRZS9F?=
 =?utf-8?B?dGFZVndhM1p6b0trZ3NrMGJnb0NlajFxdGVmc3ZjQ2lPQ2R4TkNlckVMS1JG?=
 =?utf-8?B?a2U1WndsV2JmejVsRkp6cDhsWnlFVHhkanZaNEo4NERzeEMxaGVueFRCRUVM?=
 =?utf-8?B?QXFNYTVlaEJHcUJCd3NOK3Y0Wnl1U1ZDR0xmTDV3UDFuOU9reWVWWlVEai9m?=
 =?utf-8?B?T05rcEUveXpNUGFBbllhVEZKejl5OUFtU2FqWFV3NENLaUU2b01GMkMvWjlS?=
 =?utf-8?B?RER6anNjVG82T3R1THZCcmVnM3h1cjV4TUN2bDAwcjhpWXNKVmlLbGV1R0t2?=
 =?utf-8?B?SlFybnpDam1IUVNZcjFLOEx1UEVxd2cvTFVvQ0lqaUJaaFlZSFFKakNsL1c5?=
 =?utf-8?B?WEhSdUkwWWFMM3NZNTErek9SWXIwMVorRnNsTlN6Q2IzMUdXZkpzNmhSdW1h?=
 =?utf-8?B?N2I3dEgwamF2am45OElibE1XTWhCTGhKNTZIZWRRUlZDUm5jcllxRGFBTHVE?=
 =?utf-8?B?TEdCNGRmUDlXTnJCU3NXZnRyV0ZhRGhKcm92TU5xMEFoV3kvREtGajh2a0VY?=
 =?utf-8?B?RnlsNnlzOFZsWld1SHdIbkpYeklzVTVsN2svRERCRUJjbVd6bUczeWd2VVRD?=
 =?utf-8?B?dWdCYTRJSEV5N2xvVVNiNytEakhUVTlJNlNYS28xRmp3OFdMTW9vWVptS001?=
 =?utf-8?B?VkpIR1l0UUh3cVJZU01DUmRtdlN2amlHQWRNTFBwcVBlYjlkK2xxdUtMQWhU?=
 =?utf-8?B?ZHRITndOOU8yZTJrOUU2M2NUaThjZFA3MWRHVTlKV0hETWU1Tm51dStmRHVv?=
 =?utf-8?B?Zldqa1pmaC93MFN2Zld5b2lFbE5OMDF4UWJ2NW04cUMxNG5Fck0xUjF2UVcx?=
 =?utf-8?B?WXpMcS9VdGRxUTNEKzBMMmN3UHdwczllTHplYVB3VWVKdTVNRWt3MlhPTW5l?=
 =?utf-8?B?R1JmNW5hNWZJbjFybzZ5eHlETC9LZnFaNCs4Kzd3ZkZvcTE1MGZ3M093MUdh?=
 =?utf-8?B?eG01alpZcnNWOUU3VkFmNDJqdnAxVXp4dTlhQks1ckIxU2RvRmtNRTIwTVM3?=
 =?utf-8?B?Qy9Ccy85YytLRzd4M3VNK2dSYTFFMWx2TXByN0dDbThwK2E2T2RLZ2NSOUJj?=
 =?utf-8?B?NUg2b2tGL0VINEFlc3NDYk1XM2p6TWtVdC9lVCtCWlRkOEcxQXVyeTIycEJP?=
 =?utf-8?B?cnlLVDExdXFYaFFVeEdnL053RjgxSGhLYlVmRTRKMEFYV2ZDaGpqbFhuVTQv?=
 =?utf-8?B?bHdrazVQbVArUW9ZL1BuVzBVN1JhU0pFQTRFUnd4NUw4eDhNYmhta0h0M3hM?=
 =?utf-8?B?NEdUSFZQWk9KS2pJTDMzdVVsYUtoQytHeDhYU2tTYmgwL0ZQcWgySW1ncVRJ?=
 =?utf-8?B?dVlPNllCVW1KUUM0bGh0ejNZa3R3eU50aFlIUCtNazFORlpDSWdQTnZycXFx?=
 =?utf-8?B?RDk4ZTdWd1pRa0ZRYkE0am5Db0JsNzJRcWlXUmd6R2lsa2NhMmIwbjVocEFB?=
 =?utf-8?B?aHpRUENRMHBma1lWZGZXaWpOZi9YRVYzdHZrckJQd1dDOFY4U2VyMGR4Q2or?=
 =?utf-8?B?Qm42L1NINS9OV3laOFBvZXhkRytGWlhBZVBqMFhIakhJTlRtSmNTdGlOWjFN?=
 =?utf-8?B?azZkbnlUZ05QL3pNenBGVzE0RnZkdkw3NU9HdXZlYW5xT1Nsc0VpcHNySzRC?=
 =?utf-8?B?KzNJRXY0cjJQWSsyRzhvZEM0Y3RKS3d6MkQ0cVZuOC9QclVDMUlCam9POEMy?=
 =?utf-8?B?MDdSZGpTMWRNU0tsTUdCTGQzbkY0b3kwSGtzejJaQ1g1a0FCQlZ0Qnc4MVRU?=
 =?utf-8?B?ZVpocEd6NVordFVIVXpJdGdRSGhDdVY3eUdHVnRLK0NDM2xkc0Z3V3ZMRDdz?=
 =?utf-8?B?eGZmZWh1YXNyTHdyakgwa0pnMStiYVBhdWZIWGZvUlZyUmtzOW9YYWZuMk1J?=
 =?utf-8?B?VkJzMFcvMzhXRkhFaVZRSDFkalBsbURYeFUvbExwWUpPWWtsVFlUbHVnQkVi?=
 =?utf-8?Q?wvLQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e707bcda-5199-41c5-c82d-08dc919c624a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 02:46:42.9585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eV1uHuRaCJpKzLnCflq5MoQOyvx5cArvPbo6WIp/eZqE2+i7OxIkpOD+f6tR1t7sD1oorRudCSNDWkZ7n0rcTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189
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
Cg0KSGkgQWxleCwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldywgSSB3aWxsIHB1c2ggb3RoZXIg
cGF0Y2ggdG8gZml4IHRob3NlIGlzc3Vlcy4NCg0KUmVnYXJkcywNCkJvYg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5j
b20+DQpTZW50OiAyMDI05bm0NuaciDIw5pelIDIyOjU5DQpUbzogWmhvdSwgQm9iIDxCb2IuWmhv
dUBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBIdWFuZywgVGlt
IDxUaW0uSHVhbmdAYW1kLmNvbT47IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQu
Y29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IGFkZCBtaXNzaW5nIGVycm9yIGhhbmRsaW5nIGluIGZ1bmN0aW9u
IGFtZGdwdV9nbWNfZmx1c2hfZ3B1X3RsYl9wYXNpZA0KDQpPbiBUaHUsIEp1biAyMCwgMjAyNCBh
dCAzOjQ34oCvQU0gQm9iIFpob3UgPGJvYi56aG91QGFtZC5jb20+IHdyb3RlOg0KPg0KPiBGaXgg
dGhlIHVuY2hlY2tlZCByZXR1cm4gdmFsdWUgd2FybmluZyBieSB3YXJuaW5nIHJlcG9ydGVkIGJ5
DQo+IENvdmVyaXR5LCBzbyBhZGQgZXJyb3IgaGFuZGxpbmcuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEJvYiBaaG91IDxib2IuemhvdUBhbWQuY29tPg0KDQpMb29rcyBsaWtlIHRoZXJlIGFyZSBhIGZl
dyBvdGhlciBwbGFjZXMgaW4gdGhlIGRyaXZlciB3aGVyZQ0KYW1kZ3B1X3JpbmdfYWxsb2MoKSBp
cyBub3QgY2hlY2tlZC4gIENhbiB5b3UgZml4IHRob3NlIHVwIHRvbz8NCg0KUmV2aWV3ZWQtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyB8IDYgKysrKystDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4gaW5kZXggMzIyYjhmZjY3Y2RlLi4z
YTc2MjI2MTE5MTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nbWMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21j
LmMNCj4gQEAgLTcxOCw3ICs3MTgsMTEgQEAgaW50IGFtZGdwdV9nbWNfZmx1c2hfZ3B1X3RsYl9w
YXNpZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDE2X3QgcGFzaWQsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIG5kdyArPSBraXEtPnBtZi0+aW52YWxpZGF0ZV90bGJzX3NpemU7
DQo+DQo+ICAgICAgICAgICAgICAgICBzcGluX2xvY2soJmFkZXYtPmdmeC5raXFbaW5zdF0ucmlu
Z19sb2NrKTsNCj4gLSAgICAgICAgICAgICAgIGFtZGdwdV9yaW5nX2FsbG9jKHJpbmcsIG5kdyk7
DQo+ICsgICAgICAgICAgICAgICByID0gYW1kZ3B1X3JpbmdfYWxsb2MocmluZywgbmR3KTsNCj4g
KyAgICAgICAgICAgICAgIGlmIChyKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHNwaW5f
dW5sb2NrKCZhZGV2LT5nZngua2lxW2luc3RdLnJpbmdfbG9jayk7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gZXJyb3JfdW5sb2NrX3Jlc2V0Ow0KPiArICAgICAgICAgICAgICAgfQ0K
PiAgICAgICAgICAgICAgICAgaWYgKGFkZXYtPmdtYy5mbHVzaF90bGJfbmVlZHNfZXh0cmFfdHlw
ZV8yKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBraXEtPnBtZi0+a2lxX2ludmFsaWRhdGVf
dGxicyhyaW5nLCBwYXNpZCwgMiwNCj4gYWxsX2h1Yik7DQo+DQo+IC0tDQo+IDIuMzQuMQ0KPg0K
