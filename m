Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A526C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 07:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7BE10E158;
	Fri, 10 May 2024 07:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tzZqLxlj";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758DD10E158
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 07:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gp5QGwtURXxjoIce9F+c6NdxHXSfnoKvSng6og7Sp4T5dTCUfatEtDGhHfHuUOmHR+DsVutvc2bYLApU+ZHjXp5Yzm+TZxobOq9uWjzIKDLmxXuxJRtuD6+2dv2wEa6oJvB4Y/RSsVCuF1gibrPaDTahY3F3SnuGsZQMuqNhXmVc8ICHO0Y+GYZ67S7ugeRhFDF7dPMZyj8ncrPRbifjPpZEY9YTW9VACJnmarq/h1SniFf54bF7sG6ukB7xK+Ro3xjpASZvaTMBQukHhs4Zth4mfKPwhwAoAjWviJUNpk8hixfsflPCBbkf0K6/EJe1b0r5Aidnx8m9T0TEYPvMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zoa2RhqA4Z8+zygmxJz1f4iJ6OHabpshHFkrRW0KyJg=;
 b=bxIyi5CTqdd890fui4bCcdontFccDgLrVIp3LTzlAnXkjdLAJeBEV8aDgMWAD7dXWV9r005X6PeqzuB08DAWAGN4rsRt/8IbZbbpebmhsg60PmC1eRyjyIOfG7ehp7KcUz7rFNSIpQJTPEtgfa1hcNPFIEjFZ/eQD8x0pupHI0iTVyInJuJtGUGVSaoErVEVwGRj0qSno7vUMXrY1pZq+asICksq1nc3Dpze1Bb/1raEzxTzH9mh221HRS5Bxr70Hxw6/hbZ1aJrnkZt9YjZfgMpB9qg+6j+9VDjB+vyw+SZAiA1Iclbk9yElwQiBkrt8G8DErrrUQVcizjBHQcQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zoa2RhqA4Z8+zygmxJz1f4iJ6OHabpshHFkrRW0KyJg=;
 b=tzZqLxljVsUPbJ/g1lB95mOd+Na+Gb8yUHqI8Ewyp/R9YbbPdnI4LijTybiabfKWY3NLbdF1KuUrKHPZdV2fROhZe4BR9vKP8MIof1wpHdzNgmnkMREZ2BfDO2VGtBRKBD7B3xUY50OTI5sWcCk6/wzDpi2bhUyXsv4F3VytI9Y=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 07:39:44 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 07:39:44 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 19/22] drm/amdgpu: Fix the warning division or modulo by
 zero for the variable num_xcc_per_xcp
Thread-Topic: [PATCH 19/22] drm/amdgpu: Fix the warning division or modulo by
 zero for the variable num_xcc_per_xcp
Thread-Index: AQHaooVmmEuExxu0xk61Q2b7NdU/oLGQDtGAgAAGJPA=
Date: Fri, 10 May 2024 07:39:44 +0000
Message-ID: <DM4PR12MB51521E176AA69BDBBED80996E3E72@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-19-jesse.zhang@amd.com>
 <f82ed0c2-d90b-41a0-aa90-62ec8eceeffc@amd.com>
In-Reply-To: <f82ed0c2-d90b-41a0-aa90-62ec8eceeffc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8254ed08-56ad-4502-8b73-0071500a2131;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T07:38:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CY5PR12MB6624:EE_
x-ms-office365-filtering-correlation-id: 709d0598-2e85-4195-dabf-08dc70c45c3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NEhESXZQUERpRnQ4ZGIzYVN3dW9VaHA0L0RkbzRNalZ5UGZTNFBVNnIwU3B0?=
 =?utf-8?B?Z0Nzdk1CTHlYMy9DVzhEaWVrT2hjR09FQ3hHSy8wM2YrTkVBZkRBbzhkVjZN?=
 =?utf-8?B?a1Y4SXMxVFlHbThBN1RIelVsU0JnRFZnUzE5Nm9xTnljQ2lwdHBCWHlDWDNR?=
 =?utf-8?B?aWp5WjNDVHo2dnlSR1N2UWlqNGdjZmV5dVpuTlF5Ykc0RU9PTEdmd1lQejR4?=
 =?utf-8?B?NGdRK0crZTd4WXliTG85Q1VhejRwb25sR2V1bHJFOUlEN3lYUVRrK3VBN0lB?=
 =?utf-8?B?Nzh6UlBTc0dUN2trM29RK0h1R0FwMXZ4MlBGVEQ2U2twQ2ltU1FwUjhRM1M0?=
 =?utf-8?B?TUdyR2JlckFZMDdJSXRMT0tKM2M3M2xMMytKTkJRbEM3Smladkk5bWwxdTd5?=
 =?utf-8?B?MnhVTDEzZExxcVc3dXpWRjBNM1hMdXBONTdVSGlZL0xYV1pLQ2RWMmJXaDBF?=
 =?utf-8?B?RWJ2dHR6bThMUWNMbDU1QU5ZK1cxNVJicXpaRDNCUkJOQmM5T1FhVHdUK0VZ?=
 =?utf-8?B?dDQxbFNrcVRYSE5RRkZ2bXJ4U1F0WmdxeXNOaThSZDhqN0pnVlNhS2dCM1hF?=
 =?utf-8?B?NEhKS1NybzY4VGxNSHRiSW9kRDA1aXUwV1B6MnVZSTFqekgvdW5DVTZnVTdw?=
 =?utf-8?B?d3o1UDU4d2x3a1lWd1c0SVFNNSs3NWYxUnRTR1ZoVTBzSUdYdEh0RUVRcEFJ?=
 =?utf-8?B?ME1FdXY2Sy9laDlzaitlU0czbGNWNlFFSGp0ZHhBRFM5RUhyT0Z5K1JEM3RI?=
 =?utf-8?B?YjNxbDZubWtVSTJvRjV6SXVvWVRsNzFxSkFLcDRWZktzRXp3MWFZTVlZZDVy?=
 =?utf-8?B?bnBMTFYzdUdEY0Q5WC9mdDVDeXFTOVlKaGlGUkFmd21ZRk1YLzg2blBxeWsv?=
 =?utf-8?B?ZUJ2ejJ6SEY0M1V3WGVNSUFxYlNWUFh4VkRXaUVndlI3N2wxNWJ0d2xYK0di?=
 =?utf-8?B?NXZ0UFhtMkJqK28yREVOR0VYRUwyS3JXRUtiYlpmOFdDMTk5NC9QUnhYVHFK?=
 =?utf-8?B?ZExnTnpSN2dSMkZ4cWwzTE9pK1dtU1hHWmlXeHVpa0lhdHByNktNWXd4Q2wy?=
 =?utf-8?B?MHZiTDhvaGUxb29Sa0RNNU9CNmtQTjRMNW00Z2dQNTNzMDlNSlJMNkdJaFpD?=
 =?utf-8?B?QVc3dXN0Z0pTNWY1QS9vV0l2bXI1dkkxS0w5OGc4c3hvNVZPeVozTTQvaEdx?=
 =?utf-8?B?d1IyMUJTK2svVXhQRHFham5yQTlUVG5ybnpaWkNVQVJyNDZYQzYxYW9XRlZ1?=
 =?utf-8?B?dVlsSE9oRHUxZEMyclVwR1RKbHZyenVwK0xpN3Y2Z0lIWk9zYlR0U2JlcU41?=
 =?utf-8?B?YUI4YVZtaUJmWWJEcVRmSDVwbHlaYkt1WWZDUWNSUGRSNkVtWlozcmtGeGg0?=
 =?utf-8?B?YTlZNUxkaW1XbnlnYUQwYzNONEl4WFRWc3oyenM5enI2YWFkaWMyVHhTR0Q4?=
 =?utf-8?B?SkxtRFFrd24yMmY2MmlNaERjZHhZU1hIMVJOSW5yWmg2R1pFbC9CbExFR1Vv?=
 =?utf-8?B?My9TbzJ3VWNqV0tKTDdSeU5jVW1BdkROOUMyZmE4N3ZBVXJ5M2xUN0ZVdW4x?=
 =?utf-8?B?MUJnM0JGWnR2SEZSTkkraExnWkpEUHNYZkV5STN0R005ZTliUm02Nzh3V2px?=
 =?utf-8?B?c1Fka3I4ZFNTcDI2bXhZSHpuT3kwNEgzbVQrZWhmdDhCMHpJTkpYTXNMZ3pu?=
 =?utf-8?B?QUFaUEI3WGs0YlBvSW1PbXVCMVh0ajVjcUJSeWhwbjdPTzg1Q0ZkWG8xQ01M?=
 =?utf-8?B?cS9YSjQzS000eUNrLy9FelZtQmtGTGx4d25NeUtCTEN2c0VyeW52Q2tSazJy?=
 =?utf-8?B?UDI3OEJLd1ZMQjl3S1E3dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z096QVlTakhtamNlNzNOMHpYMFZ5Tzl5Tmh1NkFVSFNtb0ZybjAvYkE5VElI?=
 =?utf-8?B?Ylo2ZjcvQWxweXBPVkVvWmdpcjBUK0RscU9LUFNRWm1jeEhTM1k4TkU0ekFF?=
 =?utf-8?B?QjdMMXMrWFBWSW0rbWZkSXg3UFRnTENXa1ltWmhuNzc2OVY2VHVZbEpXSjZz?=
 =?utf-8?B?bWp6eXZPRGlQc28rVStGazdGSE5QZ3FLaVFQcXhJaDlmdXdXVXpFenVJK2Yw?=
 =?utf-8?B?bXI3NEVXRSttdVNLME9MbVBmSUp0ZnhrblN6WXVHZFVCV0lQYklYTWgyUjg2?=
 =?utf-8?B?WFd3MXI3QzVQeVkzYmNBZW9ZS3dsejRVUy9mbi83eEFFSElOM1hCZmxFK1Qz?=
 =?utf-8?B?T0hwYnZDL2FLaVVtT0JNdSthaXNWZkI4MUk5ekVZWVQ0d05GcmNRekMvektw?=
 =?utf-8?B?bmZBbGpBRnd6S2dKclpJZHRGMWpGalBMclVOTzJHT1MzQlN2czJmQVdDY1lF?=
 =?utf-8?B?ZlkwTjBZK3BsL3EvcWl4UU5MS3BPQit0cGZBQ3FQVTViSDY1Mm96aFVvWFhP?=
 =?utf-8?B?NjV0dEJxTld3bnpidzlQREliRElXRU9qc3dkYWtCUlo3dGNHWGxROWxxOHFt?=
 =?utf-8?B?Y21Qd3RaSXZkSmlsbExUdDl3V3E5WEhKNW4rN1ZVSUJZZXBPSEh0YWxNUzli?=
 =?utf-8?B?SExVcSt1QyttbEpyOXJ3bE9xZHNvMjRZSHlVLzk0RGhheVhWVWdXRm0raDFa?=
 =?utf-8?B?NzArVVBQS1JJQS9qNERNSHBpWmpFdDkwTWRZVnJqbGpKWnR6WWdwNGJHY3Ri?=
 =?utf-8?B?SFlKbE5QY2lPcHk1YmY4VUd0aG13c0FJdG95dDR5M2xCK3k2R1h3TlMrdzVi?=
 =?utf-8?B?dmZlN2JTb3NKZjRoZitFMGYrNFBSdWlWRFU2RHBobFVBNzR0dlUrbC9aOGtC?=
 =?utf-8?B?N0lXbEV3ZFZ6ZVJnOWFqS2ZTQUJXaTFDYS9qNnVsOGk3Q0V2emgwcDRvS3NN?=
 =?utf-8?B?NFZsUzdjcjk0SFVDdjlQRlRHTWNwaENsclhxNXJzTStKUjh0R2lGL0FaOEVl?=
 =?utf-8?B?YmdwN0xaTCt4MEI1NDB4OWJEZlg5UnpPK3hGTmF0dkg4MEh1OWZnL1VaRm1T?=
 =?utf-8?B?dmxjblo0Y1JTbEE2RUZkMGZOWURGMGtHaitqWUhTZld5T3JuRlVXdnJCVVhL?=
 =?utf-8?B?OWM1bkkwekdWcUc1azljei9XOWFWUXQ3Ykp2WnBZaEcvaEtsRFUyWEE3T1c1?=
 =?utf-8?B?L1c2WnJVaENaNGpBTHlxRVJPdjBiSE96eVdjRXlnbTM5dEpMMnhPbUV4M2pF?=
 =?utf-8?B?SlVIU205a3NmUEpkbll3VGkrZ3VUMytYaXU0YzZNS3gvRTRRRVlzRk1oSW1Q?=
 =?utf-8?B?ajVkZXhlOTdHT3QyWFBSOHh1T3hURjRnYUtiVFkzQU1aQVVLdyt2dWdIMEdh?=
 =?utf-8?B?VFBuRHRraUZKQ1pRS2NxaDZOY0RzbHhLNWhsQjFxaDg1eExTdTU5N0dFWDBS?=
 =?utf-8?B?aHd0UENta2JkZTZma0t6R05NSHU4Rm05a1ZDbWhNZ3U1WUxiUzNnWEIxb1o0?=
 =?utf-8?B?Wk53aTJ1YTA3dm1FSVI0dnpSamVCN1B5N283STZwYWUvRks0TzZoMkdDakFI?=
 =?utf-8?B?QVZjR2wzbFYxR3pFaDFKazlHQ2N1dWlTZDZNaStMOGxBTkJRSXh6bDZMa3BN?=
 =?utf-8?B?ZzM4bnZaTXJlYkROc3JnS2ZTRmljbDhsazE5LzM2TFR4U09zdDJ6QW5kRkIw?=
 =?utf-8?B?N1lVakV2RGtCVFRkQUhrTHhVYU1sQjZGM0FzaGhYQ3NYaWQ0aVo0Z1dURytH?=
 =?utf-8?B?MWxQR2VXWGlXMFZyZkErWFNVUWdCQnpDdlRoaVpFMitiZHJUNXllU1d2VGEy?=
 =?utf-8?B?dndGUkJzQWpxUnNneHZYaktvcDI3d1dTeE9hVTM1aG5TRlZ1MFVIRU94dEdP?=
 =?utf-8?B?dE5SL2ZnK3VlMlAycENMb0MvY2drT1pWeXlOR2RSWVRaMGlOVklSb3hRWGxs?=
 =?utf-8?B?MCs0VzFBNVM0dURHUTVES242VDRLSHNuVmoycVQxUHFCVU1URHVob24zckd3?=
 =?utf-8?B?YTU1VFhJZ0k0NkdxeUdoWURVeE9Mb2RseXhaUGVXUmQ1dWJQUE5pTmNZb1VJ?=
 =?utf-8?B?UjBoL0E3ZlRTcnI1V1BLMGxTUGNiNjlka2E1REE1SDM1ZU80TTMzMktjZm1m?=
 =?utf-8?Q?rM48=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709d0598-2e85-4195-dabf-08dc70c45c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 07:39:44.2962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RI+uz7h1AEABkLdcUpPmi5GFSNAxMYqZ+Wsd3RVPVUZiyhJzIuNENRM6245r8nofW5toOyB1KU776gk/+Z61vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIExpam8sDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgTGF6YXIsIExpam8NClNlbnQ6IEZyaWRheSwg
TWF5IDEwLCAyMDI0IDM6MTYgUE0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
U3ViamVjdDogUmU6IFtQQVRDSCAxOS8yMl0gZHJtL2FtZGdwdTogRml4IHRoZSB3YXJuaW5nIGRp
dmlzaW9uIG9yIG1vZHVsbyBieSB6ZXJvIGZvciB0aGUgdmFyaWFibGUgbnVtX3hjY19wZXJfeGNw
DQoNCg0KDQpPbiA1LzEwLzIwMjQgODoyMCBBTSwgSmVzc2UgWmhhbmcgd3JvdGU6DQo+IERpdmlk
aW5nIGV4cHJlc3Npb24gbnVtX3hjY19wZXJfeGNwIHdoaWNoIG1heSBiZSB6ZXJvIGhhcyB1bmRl
ZmluZWQgYmVoYXZpb3IuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5nIDxKZXNzZS5a
aGFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FxdWFf
dmFuamFyYW0uYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hcXVhX3ZhbmphcmFt
LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hcXVhX3ZhbmphcmFtLmMNCj4gaW5k
ZXggNDE0ZWEzZjU2MGE3Li41NzUyYzY3NjA5OTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FxdWFfdmFuamFyYW0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hcXVhX3ZhbmphcmFtLmMNCj4gQEAgLTUyMiw2ICs1MjIsOSBAQCBzdGF0aWMg
aW50IGFxdWFfdmFuamFyYW1fc3dpdGNoX3BhcnRpdGlvbl9tb2RlKHN0cnVjdCBhbWRncHVfeGNw
X21nciAqeGNwX21nciwNCj4gICAgICAgICAgICAgICBnb3RvIHVubG9jazsNCj4NCj4gICAgICAg
bnVtX3hjY19wZXJfeGNwID0gX19hcXVhX3ZhbmphcmFtX2dldF94Y2NfcGVyX3hjcCh4Y3BfbWdy
LCBtb2RlKTsNCj4gKyAgICAgaWYgKCFudW1feGNjX3Blcl94Y3ApDQo+ICsgICAgICAgICAgICAg
Z290byB1bmxvY2s7DQo+ICsNCg0KVGhpcyB3b24ndCBoYXBwZW4gYXMgdGhlIG1vZGUgaXMgdmFs
aWRhdGVkIGJlZm9yZSBhbmQgZm9yIGVhY2ggdmFsaWQgbW9kZSBhIG5vbi16ZXJvIG51bV94Y2Nf
cGVyX3hjcCBpcyBleHBlY3RlZC4gVG8gc2F0aXNmeSB0aGUgd2FybmluZy1jaGVja2VyLCBiZWZv
cmUgZ29pbmcgdG8gdW5sb2NrIHVzZSBhIHByb3BlciAncmV0JyB2YWx1ZSBhbHNvIChvdGhlcndp
c2UgaXQgd2lsbCBsb29rIG9kZCkuDQoNCltaaGFuZywgSmVzc2UoSmllKV0gIElzIHRoYXQgcG9z
c2libGU/DQpXaGVuIHRoZSBpbml0aWFsaXphdGlvbiBtb2RlIGlzIEFNREdQVV9BVVRPX0NPTVBV
VEVfUEFSVElUSU9OX01PREUsDQphbmQgZ2V0IEFNREdQVV9VTktOT1dOX0NPTVBVVEVfUEFSVElU
SU9OX01PREUgdGhyb3VnaCBfX2FxdWFfdmFuamFyYW1fZ2V0X2F1dG9fbW9kZS4NCg0KSWYgc28s
IGl0IHdpbGwgc2tpcCB0aGUgdmFsaWQgbW9kZSBmdW5jdGlvbiAoX19hcXVhX3ZhbmphcmFtX2lz
X3ZhbGlkX21vZGUpLg0KDQpUaGFua3MNCkplc3NlDQoNCg0KVGhhbmtzLA0KTGlqbw0KDQo+ICAg
ICAgIGlmIChhZGV2LT5nZnguZnVuY3MtPnN3aXRjaF9wYXJ0aXRpb25fbW9kZSkNCj4gICAgICAg
ICAgICAgICBhZGV2LT5nZnguZnVuY3MtPnN3aXRjaF9wYXJ0aXRpb25fbW9kZSh4Y3BfbWdyLT5h
ZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIG51bV94Y2NfcGVyX3hjcCk7DQo=
