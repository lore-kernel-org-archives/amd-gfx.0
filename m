Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA86CC04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 05:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 362F410E3A2;
	Fri, 17 May 2024 05:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UOYpwNdY";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BAA10E472
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 05:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obtTwmR+e9w+GyvvnxYfjuCGyoDX3AQ9M39IhizWkGSfZ7D9shIcXEIpucgJ0ognjIZynFHIC+zyw9N4l1NdkNMzHA6uNgWa9VcuI/dbiC35fqijd24F6SBRN06JlgHV8CfO8TRBrp2QC0jR6Ts5yenQwooMkKW4CU9u6/xmu+8lRkpiPn2uKj9/ySsCxZ4aQUywkJ2mV1QPvjMgz9dTXXa6VD0mlRbqrkB0vzGIXpd/PVBP1WjUQwWD8MwVLRwHEIMDPQbZ5aVNoBs4uAQ1lSUrO4ADRqHFbezpL0RNVVPxlYFmHDjSnKyi/jySKewskucZ1dVm9fur8aG4XELt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdOJDLLG0sbOne9ZVwLktB0DM5s2WJqgaNNcYRABmps=;
 b=DO+kEz90cIej/1fCIA1StgDTyUB4GPWJScDoPjbBp3zK2nXteIBnX0d8fMFLw9jhJaPDcp8n7B0MQM0rst4IG9K1FYOwzLoY2hYSR8yziLTDnNCb3T82LphaIOk1wpYxNbFymzq98yqg7HQuS5NSI2/MyDbsM6r651e7hEemfLoOcMACg/9pGFsCc7fp4HHToLiRlrOkh0kaqAOfImzJQCZwvs/XfGnFp8sLKU5ap4XGzPNtas1IvRup2foLFS+LzItx3Bqhl0N6psw8akAC3fNjRAfq4hyl7bWN7hSTdGes4QxZjA/3VgJH6M0B1jF7+MnxO5dMTZxcwqGste9m9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdOJDLLG0sbOne9ZVwLktB0DM5s2WJqgaNNcYRABmps=;
 b=UOYpwNdYZpLkMsSW+xDyKdyKu+Ij4gUoAk8OFjXrwHyugLwljxpVWD8a8OVr31NsRMwmMaW55bFSFW69sQ3ld2pmPRP/4gKMGHSkkCQi0l64l3vEDGdCb25HMsKnBtbOsGeeaT8knSmisP0hoIdC1QeiL9rciYZHYQZCoE76YSE=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 05:14:27 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 05:14:27 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH] drm/amdgpu: Remove duplicate check for *is_queue_unmap in
 sdma_v7_0_ring_set_wptr
Thread-Topic: [PATCH] drm/amdgpu: Remove duplicate check for *is_queue_unmap
 in sdma_v7_0_ring_set_wptr
Thread-Index: AQHaqAryMJofkvLdV0qdmVQD037PcbGazbaAgAAUUqA=
Date: Fri, 17 May 2024 05:14:27 +0000
Message-ID: <DS7PR12MB6071C64E5B1C34E31F32248B8EEE2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240517033244.1825782-1-srinivasan.shanmugam@amd.com>
 <DM4PR12MB518198136AEF25F364CE9935EFEE2@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB518198136AEF25F364CE9935EFEE2@DM4PR12MB5181.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=399747cb-ee17-468a-a52d-68e63207f52c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-17T04:01:00Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|IA1PR12MB7541:EE_
x-ms-office365-filtering-correlation-id: 363b01bb-93bd-41f6-5846-08dc763039a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TzNKS0VYRFFpZ1gyNEJHaW9xYTJWd3kxWVFKRWVMWjN3ck9WRmRiQUtNQ2N4?=
 =?utf-8?B?MmQzVVYxUWJyK0pEalhCZ1M4cHhDVUNTcjRsZWFTbFprTlhLSlI1aHlnTEFE?=
 =?utf-8?B?aE9Kb3dnL0lpdThlUEpZWWNOUngwMEgzbVJaMDZxMXNmRFNWc0p0NS9WVjlD?=
 =?utf-8?B?T1Y0a0h6cUt4RjVSRmNETm1DNUQrSUZXd1FSNWlSUmJVMGVoY2VzNWtNbmVn?=
 =?utf-8?B?UWxIY25ONCtsRmhqWkwrdWtRS2c1NFVuZFh3OE53ZTRwMGgyU1VmZ0VPbW5G?=
 =?utf-8?B?WWpua3NBRnpobkRKZVREYW1YRVByTjRCcWNMTm8vSG91ZkFrVWFnbFowTCtB?=
 =?utf-8?B?V1FMakYwVjJLeFg4a2tTbnQ0czhTQ0JRZzRkR1VMWWJVbDRqZm1wbWhEQlpV?=
 =?utf-8?B?ZDc0RzZ3QWFIWUNBYloyWVUxWHVuRU9uR0lUcU5pTlFkc2duelRnNzJPaVRB?=
 =?utf-8?B?aGJPb3ZIS0RGNlBiN1Zuemx4am1tTDRzVXM2cmpReHYwczdFRHk2ZEFjR2dO?=
 =?utf-8?B?ZC9IWkNxMHJTZUhwdzhZcXNhUnVqUEE4OStNcHJPWnBleFh4QitnTnBjajVx?=
 =?utf-8?B?Si9FQjdvajZjeFZtbHZzRkZNMkludjh4Rjh5eG9kL3FxaktBRHpBMVFoMS96?=
 =?utf-8?B?K3A0V21lakpyUG82cUJwVXVCaFcrS0ZTM1BWTTdGUDJ4VkdMQjdUMHp6eEFD?=
 =?utf-8?B?Q29yUUd2b3RXRVF3NlZJY1RIcFVpTUZseTZxRHFudFZYQ2V0MlhjUE1WRGpv?=
 =?utf-8?B?U1k4QVY4NDZ2OFRKbDc1RHdveDBQOFo0MEZINnl6cVdWcjZVaTBJRitiSlVD?=
 =?utf-8?B?d1dCU1RlbkF6RFBtR1p2MnhJcXF3MDZOVllvcE81UUpZMEVBM1ZpcURwZ2dn?=
 =?utf-8?B?Y0NoWkNtOVVQWmE4ang4Sk5qZUEySVNpa1B0V3NnbTE2ZVZHWXR2aWl0MnIr?=
 =?utf-8?B?YTU3QmVBYXN2M0NPdDErWmJlZ0JVcFd1RXJvSzREcTdXQkhYRWtHNCtNQ2tj?=
 =?utf-8?B?TW1QYm1xVkd2L0dhdGIvQWtMNmlhdWNwTmVoSGxxR2FwbURaZVp5S1pSWldy?=
 =?utf-8?B?Uys3VHBaN3J6YnhJQmorK1dEMVNnNlVWM1kvSTltT2lud3R1ZTJJM0Q1cnFO?=
 =?utf-8?B?Z0JWSHBvWHpnUm9JTThkVFRSTm5neXd3V1gvVEM4YXVMVEZIOHM0cERybFo1?=
 =?utf-8?B?TGlhSXN1MDM3ME5XSmZ3S1NSWXI1UHIxYzNGa3VOcHE2R0s2WVF3VUZhemNZ?=
 =?utf-8?B?MU5HQXpja3pveUJJTFJjMVRwY24zY2hUQ1R5YjVmOWx2MmpTdjVTR3dMckNM?=
 =?utf-8?B?bzJFb0hkVDNVVkZtbWpuQUhKUEpKbUpzVi9lbFFIeTB4emFRRnJWbllhM20z?=
 =?utf-8?B?RDZheWFUNmY0NWUyMXRwMVZHQy9zcnU2QnJ3cEkrdmZuMHZXNmVkNUNIcTBn?=
 =?utf-8?B?SURVL2xLbWtQZkFnOUJOUHRSblVXSUJlSVhtTjZsRnZBS0xXS2drOTBwb1VL?=
 =?utf-8?B?Q013M1pVaXRrbzlvL082ZGJzcVNMOTNnSjl0RmhlS1hFcnVCbGNCSHRmbXg5?=
 =?utf-8?B?OGN2OVpSSVNLRVRDSFRIMkxWNlF3ekt3UmU0WDE4NzJLSWZYNzNyTHROZFFU?=
 =?utf-8?B?a3grOFFNVmdQekxJZlJHTGRWZnRRcDNCbkkzaDVabDBNSVlJRitnQjVmQnhZ?=
 =?utf-8?B?QURycmVyRDlFRlhYSldTZTR1MVBIZk95OFRsYTFza2NlejFkSnhCM1JZcEJL?=
 =?utf-8?B?bU04VG52RUV1SWl0TE5oRHoxc2lmS3p4N2ZsNFVNRHkvQXVRWVZwTzFrZE52?=
 =?utf-8?B?U1Rya2tCQmp3dnZwUHN3QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTlVUWo1SjRvZ0JlRGdPOWdod0lzcU1YN1hYUyt2NTlmZGYyczZvZHZMaDB0?=
 =?utf-8?B?RjEzSlg0b0xkSlVPVlFTbG5hb0ZzN0RNKzlKYzNVOURBNXJ6YjZMVW9PaFR0?=
 =?utf-8?B?VElpOFJyYjZOMGZBdlE0ckg1Z2Y4ZEY3cXFxYjVTZmlFUmZPZno0dGJ2S2to?=
 =?utf-8?B?WUtOKzFDMkRCeUtudlZSdXNaTFhZeW1ZaldlNzNZYk05cDEzYys3YVlxU1Zh?=
 =?utf-8?B?TnY5elFpd1BjMFBuVW5rb3dRc0QweU1Ud3lzZlg0MDZ6OVRJVVhmMEJNVWxZ?=
 =?utf-8?B?dmkwSjJSWUh4V1lLMTFjdWFXemQ4N1g0bnZBZlN6L3AxOHVpV25lVDgzUHNh?=
 =?utf-8?B?N0tJVHROSlJjZWI5TXFGYjdxakduZmF2M0xkanNDb3ppVUp5ZFZmMTFmdnpZ?=
 =?utf-8?B?WTNFcThva3kydDlIc2dMSmtFSWt0UCtsOEg5dWR6QmpPTmxMeDRZaXEzMjZK?=
 =?utf-8?B?ZE1GTlFwdHlhWXZuR2RVcm8zZjdzdmNleHVLQWpMclltYzFoS3dqTGNOcXcw?=
 =?utf-8?B?MWpZME4ybGdmV2FaYXA1dU11QnlTZTNzaEpwNHB1YTdIaVkzVmUydVNCUGpy?=
 =?utf-8?B?aGY5OC92R3gzbjdWMUQxUGlucWVSOVgzc3JDaG9Fd3Bxc2xhMHUyUm5nYzlv?=
 =?utf-8?B?UHZZelZDSGRaMWw4MXlTdEcvSVFyRnVkbEZRYnBPNzdBUEtkL1R5ejJ2cmsy?=
 =?utf-8?B?dzl1RFdrb0NYUE5ITXVRU1VjNTNDd05UK0ovUTgxdFVnYk1wdmE5TlJSc3Zt?=
 =?utf-8?B?a0NuYXNVTU4rakczNGhOQTlJZ1h5VTZlVTlyUVZPanQvRnFNRHlHS1M1TUUx?=
 =?utf-8?B?ejFwZ2l0dGVxQjE2WEw0QTFtVVBtS1VhLytCUG94cmdVaUltUE9teEZ5Uk5r?=
 =?utf-8?B?VDNSZ0w1OVV3Rjl1bkZoTDJBVGdNNHNqdVk2UjRubVRNcnRxSFlJeGJXRTUx?=
 =?utf-8?B?eWp4YVFiZUJBWklSNEwxT2tmM2laWm5Md3VOa0h6My9MdW9ZSWlmcGZaaHhn?=
 =?utf-8?B?M0JDSE5memd6WTZEeUxNUHV1UkFBcGxkQ0Zpbi8xaWdlNXczck9HTVRXSHBT?=
 =?utf-8?B?ZW5NMkp0UFVsNm5DSTdVSGZLNm5aOFVHTjVtNXVodU5TaTQxckZHRVVUaUVy?=
 =?utf-8?B?YTBkNmNYejg4UTdTcE1Rengwa0gxZm5IREZQOGdIOS85S1d3WkY0eUExalg0?=
 =?utf-8?B?RmtNWXlzQ2xGcHYwTVpKeS9ieUt0S3ppVFJWU0hvYllmdTU3SHZkUG1VR3Nz?=
 =?utf-8?B?b0piMmhHSzA1ZWsrOEtnVlA0OTNRSFE2bkVIVVVseVNhL1hycnJiRkhlY01l?=
 =?utf-8?B?anpNTGtGMGpTb2V4ZTBVQkJ2UHpoTHp4Q29Ob0Q2L3hIZTQ2My9sMDhqYkND?=
 =?utf-8?B?M1BPa3EreXBSY1dwRCtCWnhLNzlzQmRZRE8xUWJpUDlTY0VnbVBFWklXNHlK?=
 =?utf-8?B?cUJRV2VXaVNoWkFmVDE1Ymp6a3BsTDFPQVVGREVLcm1rSExWWFBST2phU3dm?=
 =?utf-8?B?K1lpUVh3d0EwZlA4bG1NK1JaUWM5bTdpZ2crWXRIMkRnZXZqSUVwcUtabXV1?=
 =?utf-8?B?RC9SUTZIcEVjMHpTNjg0d1FOSjdZWmVNNGtuMFBHVDFYQ21vT2kwci9mQjNr?=
 =?utf-8?B?WG1mdjVqMmtncFI3VlhyK29vSUdGQldRWlJwYWZwNnlJQlV1cVFSYkpob1gx?=
 =?utf-8?B?bE04OUQvWHBvK0JPZE1sZzBJRFl0SFZTclFoUWRBT203ckQvMkxEMXhtK2tl?=
 =?utf-8?B?RXF4SmRPRjU3UmxIWTZwNXBvSG1QWHFpL3lUMllxWi9sTDR5LzRSK3V6SkJT?=
 =?utf-8?B?YWphaTZ2cUppc214OVFmdElDMUJWYytsOS9OeEZHc1dSSGdDYW9PdjREYVNl?=
 =?utf-8?B?TnNXODlaSDhqZFNUeFNCZmlQQTVlRFNQOXpJSTZUOUlDekFxaC96dXVCQ0Ey?=
 =?utf-8?B?ZWJ4MWZPa2tsM21vLzFxbzVSUWVzYkNWN2FyNEgvd0pxdkU4bnpRdVpISVcy?=
 =?utf-8?B?ZGMvd3FBQnRqTmpKTWNYUGhwVG5qMlNHbE1XTS8wSEVZVSs3L2lCSkZsWk8y?=
 =?utf-8?B?R2cxVHBZb2E2dlk2eksxbXJmUStSTkx6djd0Y3pKTjZIN3NIREpZTE9sbW5x?=
 =?utf-8?Q?LpwA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363b01bb-93bd-41f6-5846-08dc763039a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 05:14:27.7066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NjIcprWMj0ch4K+6VhRvG3IvqPk44dEzxSWJ6RM09IH7LeFJuc5C7pehmZy63JwgD/BCVoxTRCTMSigEPbygIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
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
Cg0KUmV2aWV3ZWQtYnk6IEFzYWQgS2FtYWwgPGFzYWQua2FtYWxAYW1kLmNvbT4NCg0KVGhhbmtz
ICYgUmVnYXJkcw0KQXNhZA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IEdhbywgTGlrdW4NClNlbnQ6IEZyaWRheSwgTWF5IDE3LCAyMDI0IDk6MzIgQU0NClRvOiBTSEFO
TVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRGFuIENhcnBl
bnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KU3ViamVjdDogUkU6IFtQQVRDSF0gZHJt
L2FtZGdwdTogUmVtb3ZlIGR1cGxpY2F0ZSBjaGVjayBmb3IgKmlzX3F1ZXVlX3VubWFwIGluIHNk
bWFfdjdfMF9yaW5nX3NldF93cHRyDQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50
ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQg
SW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQoNClRoaXMgcGF0Y2ggd2FzDQpSZXZpZXdlZC1i
eTogTGlrdW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4uDQoNClJlZ2FyZHMsDQpMaWt1bg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxT
UklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KU2VudDogRnJpZGF5LCBNYXkgMTcsIDIwMjQg
MTE6MzMgQU0NClRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
PjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5J
VkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBHYW8sIExpa3VuIDxMaWt1bi5HYW9AYW1kLmNvbT47
IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBEYW4gQ2FycGVudGVyIDxk
YW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IFJl
bW92ZSBkdXBsaWNhdGUgY2hlY2sgZm9yICppc19xdWV1ZV91bm1hcCBpbiBzZG1hX3Y3XzBfcmlu
Z19zZXRfd3B0cg0KDQpUaGlzIGNvbW1pdCByZW1vdmVzIGEgZHVwbGljYXRlIGNoZWNrIGZvciAq
aXNfcXVldWVfdW5tYXAgaW4gdGhlIHNkbWFfdjdfMF9yaW5nX3NldF93cHRyIGZ1bmN0aW9uLiBU
aGUgY2hlY2sgYXQgbGluZSAxNzEgd2FzIGNvbnNpZGVyZWQgZGVhZCBjb2RlIGJlY2F1c2UgYXQg
dGhpcyBwb2ludCBpbiB0aGUgY29kZSwgd2UgYWxyZWFkeSBrbm93IHRoYXQgKmlzX3F1ZXVlX3Vu
bWFwIGlzIGZhbHNlIGR1ZSB0byB0aGUgY2hlY2sgYXQgbGluZSAxNjEuDQoNCkJ5IHJlbW92aW5n
IHRoaXMgdW5uZWNlc3NhcnkgY2hlY2ssIGltcHJvdmVzIHRoZSByZWFkYWJpbGl0eSBvZiB0aGUg
Y29kZQ0KDQpGaXhlcyB0aGUgYmVsb3c6DQogICAgICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NkbWFfdjdfMC5jOjE3MSBzZG1hX3Y3XzBfcmluZ19zZXRfd3B0cigpDQogICAgICAgIHdh
cm46IGR1cGxpY2F0ZSBjaGVjayAnKmlzX3F1ZXVlX3VubWFwJyAocHJldmlvdXMgb24gbGluZSAx
NjEpDQoNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjdfMC5jDQogICAgMTQwIHN0
YXRpYyB2b2lkIHNkbWFfdjdfMF9yaW5nX3NldF93cHRyKHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZykNCiAgICAxNDEgew0KICAgIDE0MiAgICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gcmluZy0+YWRldjsNCiAgICAxNDMgICAgICAgICB1aW50MzJfdCAqd3B0cl9zYXZlZDsNCiAg
ICAxNDQgICAgICAgICB1aW50MzJfdCAqaXNfcXVldWVfdW5tYXA7DQogICAgMTQ1ICAgICAgICAg
dWludDY0X3QgYWdncmVnYXRlZF9kYl9pbmRleDsNCiAgICAxNDYgICAgICAgICB1aW50MzJfdCBt
cWRfc2l6ZSA9IGFkZXYtPm1xZHNbQU1ER1BVX0hXX0lQX0RNQV0ubXFkX3NpemU7DQogICAgMTQ3
DQogICAgMTQ4ICAgICAgICAgRFJNX0RFQlVHKCJTZXR0aW5nIHdyaXRlIHBvaW50ZXJcbiIpOw0K
ICAgIDE0OQ0KICAgIDE1MCAgICAgICAgIGlmIChyaW5nLT5pc19tZXNfcXVldWUpIHsNCiAgICAx
NTEgICAgICAgICAgICAgICAgIHdwdHJfc2F2ZWQgPSAodWludDMyX3QgKikocmluZy0+bXFkX3B0
ciArIG1xZF9zaXplKTsNCiAgICAxNTIgICAgICAgICAgICAgICAgIGlzX3F1ZXVlX3VubWFwID0g
KHVpbnQzMl90ICopKHJpbmctPm1xZF9wdHIgKyBtcWRfc2l6ZSArDQogICAgICAgICAgICAgICAg
ICAgICAgICBeXl5eXl5eXl5eXl5eXl5eIFNldCBoZXJlDQoNCiAgICAxNTMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZih1aW50MzJfdCkpOw0KICAg
IDE1NCAgICAgICAgICAgICAgICAgYWdncmVnYXRlZF9kYl9pbmRleCA9DQogICAgMTU1ICAgICAg
ICAgICAgICAgICAgICAgICAgIGFtZGdwdV9tZXNfZ2V0X2FnZ3JlZ2F0ZWRfZG9vcmJlbGxfaW5k
ZXgoYWRldiwNCiAgICAxNTYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmluZy0+aHdfcHJpbyk7DQogICAgMTU3DQogICAgMTU4ICAgICAg
ICAgICAgICAgICBhdG9taWM2NF9zZXQoKGF0b21pYzY0X3QgKilyaW5nLT53cHRyX2NwdV9hZGRy
LA0KICAgIDE1OSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJpbmctPndwdHIgPDwgMik7
DQogICAgMTYwICAgICAgICAgICAgICAgICAqd3B0cl9zYXZlZCA9IHJpbmctPndwdHIgPDwgMjsN
CiAgICAxNjEgICAgICAgICAgICAgICAgIGlmICgqaXNfcXVldWVfdW5tYXApIHsNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl4gQ2hlY2tlZCBoZXJlDQoNCiAgICAx
NjIgICAgICAgICAgICAgICAgICAgICAgICAgV0RPT1JCRUxMNjQoYWdncmVnYXRlZF9kYl9pbmRl
eCwgcmluZy0+d3B0ciA8PCAyKTsNCiAgICAxNjMgICAgICAgICAgICAgICAgICAgICAgICAgRFJN
X0RFQlVHKCJjYWxsaW5nIFdET09SQkVMTDY0KDB4JTA4eCwgMHglMDE2bGx4KVxuIiwNCiAgICAx
NjQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJpbmctPmRvb3JiZWxs
X2luZGV4LCByaW5nLT53cHRyIDw8IDIpOw0KICAgIDE2NSAgICAgICAgICAgICAgICAgICAgICAg
ICBXRE9PUkJFTEw2NChyaW5nLT5kb29yYmVsbF9pbmRleCwgcmluZy0+d3B0ciA8PCAyKTsNCiAg
ICAxNjYgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQogICAgMTY3ICAgICAgICAgICAgICAgICAg
ICAgICAgIERSTV9ERUJVRygiY2FsbGluZyBXRE9PUkJFTEw2NCgweCUwOHgsIDB4JTAxNmxseClc
biIsDQogICAgMTY4ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByaW5n
LT5kb29yYmVsbF9pbmRleCwgcmluZy0+d3B0ciA8PCAyKTsNCiAgICAxNjkgICAgICAgICAgICAg
ICAgICAgICAgICAgV0RPT1JCRUxMNjQocmluZy0+ZG9vcmJlbGxfaW5kZXgsIHJpbmctPndwdHIg
PDwgMik7DQogICAgMTcwDQotLT4gMTcxICAgICAgICAgICAgICAgICAgICAgICAgIGlmICgqaXNf
cXVldWVfdW5tYXApDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5e
Xl5eXl5eXl4gVGhpcyBpcyBkZWFkIGNvZGUuICBXZSBrbm93IGl0J3MgZmFsc2UuDQoNCiAgICAx
NzIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBXRE9PUkJFTEw2NChhZ2dyZWdhdGVk
X2RiX2luZGV4LA0KICAgIDE3MyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJpbmctPndwdHIgPDwgMik7DQogICAgMTc0ICAgICAgICAgICAgICAgICB9DQogICAg
MTc1ICAgICAgICAgfSBlbHNlIHsNCiAgICAxNzYgICAgICAgICAgICAgICAgIGlmIChyaW5nLT51
c2VfZG9vcmJlbGwpIHsNCiAgICAxNzcgICAgICAgICAgICAgICAgICAgICAgICAgRFJNX0RFQlVH
KCJVc2luZyBkb29yYmVsbCAtLSAiDQogICAgMTc4ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAid3B0cl9vZmZzID09IDB4JTA4eCAiDQoNCkZpeGVzOiA2ZDljNzExNzg2ZTYgKCJk
cm0vYW1kZ3B1OiBBZGQgc2RtYSB2N18wIGlwIGJsb2NrIHN1cHBvcnQgKHY3KSIpDQpDYzogTGlr
dW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4NCkNjOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpo
YW5nQGFtZC5jb20+DQpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPg0KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NClJlcG9y
dGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQpTaWduZWQt
b2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjdfMC5jIHwgNCAtLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y3XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NkbWFfdjdfMC5jDQppbmRleCA0YTUyNTJlMDg4ODMuLmFiMWRlYTc3YmU2ZSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjdfMC5jDQorKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y3XzAuYw0KQEAgLTE2NywxMCArMTY3LDYgQEAg
c3RhdGljIHZvaWQgc2RtYV92N18wX3Jpbmdfc2V0X3dwdHIoc3RydWN0IGFtZGdwdV9yaW5nICpy
aW5nKQ0KICAgICAgICAgICAgICAgICAgICAgICAgRFJNX0RFQlVHKCJjYWxsaW5nIFdET09SQkVM
TDY0KDB4JTA4eCwgMHglMDE2bGx4KVxuIiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByaW5nLT5kb29yYmVsbF9pbmRleCwgcmluZy0+d3B0ciA8PCAyKTsNCiAgICAg
ICAgICAgICAgICAgICAgICAgIFdET09SQkVMTDY0KHJpbmctPmRvb3JiZWxsX2luZGV4LCByaW5n
LT53cHRyIDw8IDIpOw0KLQ0KLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKCppc19xdWV1ZV91
bm1hcCkNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgV0RPT1JCRUxMNjQoYWdncmVn
YXRlZF9kYl9pbmRleCwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmluZy0+d3B0ciA8PCAyKTsNCiAgICAgICAgICAgICAgICB9DQogICAgICAgIH0gZWxzZSB7
DQogICAgICAgICAgICAgICAgaWYgKHJpbmctPnVzZV9kb29yYmVsbCkgew0KLS0NCjIuMzQuMQ0K
DQo=
