Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52F2C7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 13:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D16110EA19;
	Fri, 27 Jun 2025 13:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vnjfiLie";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E4CF10EA19
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 13:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwvAgwVLNrQ6bIasUN/O2vuwDsG9vy1DIcUnQrpMDKEm3zp7nJgQeGS/Verf7wlEI7t9Ha/9dkIfgAnLRlLsGRFMBl1xJZhuwTvCAR79jSi9bIAr8E7sjdOV08EKP/6k/+bEgaYe8VMaOoTaeetf71l3iA/Uf1OSaOPxNjiiR7OkYRr8YvAWNixukTJ/R8bwoX1/hLHbsaOC+oVFOknQbxDCJrV8Xz6taJv4DpDg0yjDo+qIVae1264+BvHywNJWSAE1JTCH3a8DOQDaMagzZm2N9E206DzvWLv6pYs10IXLcfdhmPs4AnTTvksXvM4zJxXPQuVejfxsyP3EJts/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzCePN43q73EBPZbSVc7a4rTsg5g1gH8xocajFg34C4=;
 b=vG6xFPQFHjcmgh8vQDTAeJWgPnq+iy8Aubu/kvx5+12ROCXwF+fgcRdfoP1if0bzq6XCt6xF+u+jSAKlKTdvAix8hUoPo0ES3dvOhiI3z3GpQqyfwXHodZP3oJrO8XQYmTJ9iaPIMh5ifUEAQAuyK6EVz7R11bWTT9RVCeeO6+0cXCLgmotZHmVP4xOzcQh4ZnkJ0YMRbB1z51IDDOgyi8y07/Z58jKgVQKzTEpzTinl08LcAJSZiLSApC+XoXqA/wn30CvHm2uPey0R0hiJ2YcTZ9X+auS1sCy3NaET6o2ChZ+9rFB1/pVvwSwCDm3yodz0DUnpGRm7rS19JW4EmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzCePN43q73EBPZbSVc7a4rTsg5g1gH8xocajFg34C4=;
 b=vnjfiLiesnFfI16cvbkcvAfL42s6kcSUSEQru8omkPXz2JMiil0bcds0f7CC9QnujzrwyLuwbm16oBeNKRTgr0K8nf4NwonvbHoy3fkHTdaYPBwB2iah8Oa1yKtB7QFCutSP54/fGjQ3vZlUI0rqKbR4U8SHIg3YNB/I5P2FS7U=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA1PR12MB8888.namprd12.prod.outlook.com (2603:10b6:806:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 27 Jun
 2025 13:05:28 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 13:05:28 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v4 02/11] drm/amdgpu: validate unmap status for destroying
 userq
Thread-Topic: [PATCH v4 02/11] drm/amdgpu: validate unmap status for
 destroying userq
Thread-Index: AQHb5ORjnIKMwFL8PU6RdHNyEs9hMLQThDAAgANzKhA=
Date: Fri, 27 Jun 2025 13:05:28 +0000
Message-ID: <DS7PR12MB600510BF73D79C9716915922FB45A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-2-Prike.Liang@amd.com>
 <b88388c7-c984-400e-83be-1daf3a819172@amd.com>
In-Reply-To: <b88388c7-c984-400e-83be-1daf3a819172@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-27T12:39:57.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA1PR12MB8888:EE_
x-ms-office365-filtering-correlation-id: 5af58e80-39c7-4c37-e36b-08ddb57b4a28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RkpBbnFOenJXNERRbVVDVWYxbWR3SXhtMy9SRllmaU5XNVE0T3gxdVBYVDgw?=
 =?utf-8?B?OVJqTDJBa3FSUG1NWlBPRndvaEJVcHdhdTg5dFNMTTdGUkE2YldrY2JncjF4?=
 =?utf-8?B?SnZBSEZxRTEwTDErUTB3NUdFZ2Q5c09PbGFwaGEwbWxOWWpSajdUMFJxT3JD?=
 =?utf-8?B?c2t4dDdFazh0SVh6K2o5c3BGNzZrOE1kZVZLVEVnWXFoZDM4QWIwUG9Fay9Z?=
 =?utf-8?B?eko1LytIR2g3ZzdxU1RwWTRjcDdrRjZtcWppdkRLQnFSMGdJUnd4azhDclBX?=
 =?utf-8?B?UDU3Um1vc1FQK2MwUmQ3OUpJeVdtRzNwVE8zSVhEUThFMDRpQlI1ZVNDaWRP?=
 =?utf-8?B?dytjL1pyYWtsRUJVdk9mY3VyZ05yU05Yc3hkMk5nYWx0VUtaMWxScmZCbXF0?=
 =?utf-8?B?MUxqamMxREV6TFNSVDRtUFd1ellESGZ2ZktqTjJwQ3Z1V3lpSjZ4R09FVnN1?=
 =?utf-8?B?elkzZTB4NU5RS3hVZENSMmRJaXR2ZzFNdG0zblVSbzlFQUtRZktTWWZiSHpD?=
 =?utf-8?B?MkVWZy9CVFJuN20xU3JPZzlKN0F0eU0vcFE5Z3gwVldMbjYvaDZObnpSUHkw?=
 =?utf-8?B?Q2xUTnFzVk1zQWFlRE9ycmVmZ2FSY0xSeU9wcGlSdkEraUx1aHpGcittL1ha?=
 =?utf-8?B?TER4WEJta3Q2RDZPakRnbk1BcW44dDQyaXdtdStTbFRDWWZqemNpRmNpOTdv?=
 =?utf-8?B?bmtuWXpNWFNUUWdkOHFsdExtSlZZOUxlWEIyTkNTV2RJWVJnU1ZmbnpVVTBy?=
 =?utf-8?B?YU1UVW1SR1NNNzREZ0ZvTUU2RzJGM0wvT1V2d3d0eFEwU25IUys4UjNTbFNU?=
 =?utf-8?B?alpRdjFlOEdxTnlxV1dJeXVLZ1pnN0VWcTdMTkQvUUxDTmtpVDdmV2MyNzhG?=
 =?utf-8?B?b3JmU1UzdUNoT2FCZUZJclh6eFMrUnZEVzhHZzlxcVdqYm9aNitwbk41bVQx?=
 =?utf-8?B?NHBpbUQrZVJxSklwRjV0a0xQOGVJU0FUc2VyWW55bm1XWElndUR4RVA1bUdl?=
 =?utf-8?B?MzhpaTJLVDlHWUF3L1AwZHVuY2hXU3NZY0g4S2RPeHBzVHZjVE5EeWgwcVFs?=
 =?utf-8?B?dVBPNm80K3hZeG5NdUFCUHhMeFZNTGRpRSs5Q0ZlbW9ublozWHkxZjJvWUph?=
 =?utf-8?B?RjgwdlVkY3RyaHVOdEdLRDBUK3Z0bTU1RTI5RWd0Q3Z6emxZMWN3QmJ3TmtZ?=
 =?utf-8?B?dkpkaU1vdGhJZG95M3ljMFp3bnZyVmEvemRSbytkM0JzeU9tNG5WMWJrNkhm?=
 =?utf-8?B?V1YvRk1iTFAyemxvZ3NRR3FQd0c2bVNTOVBma01xcURtMHI4dWhGTW1Sb0pj?=
 =?utf-8?B?N3NLRzNsMXJZUEJhNGx5SHBCOERhTG8rWXpxMGd4NkdmTzg1aXAwTE41ZE5Z?=
 =?utf-8?B?VkhWODh0R1VlVVlNTWdLNTZGR1A2UWMzaUFrMUV0ZHZVc25nOU15djZkQTk1?=
 =?utf-8?B?aHpxeGVXdXBXY3RBTGZ4ckFIN1hmeGVQeGJ0dGZxOVBuNTIzT0g2ZEU1Umt6?=
 =?utf-8?B?VlVHSTNCS1pJWjZqeWRqUERkNmxhTTRNM2hHeUdOZ0hCVDBkbVU0STFaSDho?=
 =?utf-8?B?Mis3dEI0c0p5U0V2MGFzeHM4MXhuTGFLcnREd0RrTzZDaDYzTWk0YWd4ZjNO?=
 =?utf-8?B?dWJIS1NZZ0JROCtiRXFLTUxiNEk2VlhBQmlpODlHRVBaZFIxM1RBNGtJOEc1?=
 =?utf-8?B?N1YvZGc5ZlU1ZjQzVlRaanQxUm1BQlZVWmtnVUpHM0lvV3djU1FraWUvSzNC?=
 =?utf-8?B?SFdhbWNLeENVYTlPeHM4NnArWVNVajM5Y1FMNWp1NkpUWFVKTlBZUlZCYjEw?=
 =?utf-8?B?Y3VzQ0FtYU9JSmJJa1pJdDlDeGxXTUUzNDdjV3NUdU9palNSRWlZWm1lQUZM?=
 =?utf-8?B?L0lDNWZyUm1sdkRXMFpGYWdSTG96MDZZUE1CaWNwNW1PMTRYdk0vbG15TDM1?=
 =?utf-8?B?UUNES1A0SWY1OGdwdmFJSGl5NSt3TkdqK3VuOHAwOXMxY1M4SFV4S3RERGlQ?=
 =?utf-8?Q?pL/llMMYuuBDV/hIzMQ0DZMnGcuio0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STJLME1JUWM4VEpkQVp0aENYdExFV3BLN1I5RGtaSFZEN0U2c0M1N3FpSmJQ?=
 =?utf-8?B?cmdDU0J1anhVWFMwUzdIbEMrUVF6djA5UFJ3d05DNGltYzFjNktYYjdiMGZs?=
 =?utf-8?B?b0p2SVFCQmNCYVN1MzhHdGZRQjNhTDh1NVFKUWdXeVJ3WWg1dUVLNnlQeE9N?=
 =?utf-8?B?OXRUejl3QUdUbnd0MXZoS1FmUUtKb3Jua1liRGdMRWUwSmdnMzRxTnpWMVNw?=
 =?utf-8?B?K05mZWlUc1BRNHJiWi80MUFGTjNCSnpBUUw3NndMV3BCOVh3VXBpOUQ1OTFY?=
 =?utf-8?B?N3MvRFAwWXhIV0svVXFVOWUwVjdpY212ellpWEJZTzJxa2Z0NkhpaTNkS0NG?=
 =?utf-8?B?dVNOUFdVck95ak5DeHg5WnY3WU5sVmZ2ZzVuZjM0ajZQSXFMdXI5eUpVN3Jw?=
 =?utf-8?B?Z3BLS1l3TmR4SWpRSTZKeUtDUk5nci9GdUhIQU1PZ1JOQU9Va3FZdUxjdzE4?=
 =?utf-8?B?dFBIeDBwVTM1TThFNE45THgyT1dweTRraGZPMC8wbFJGTjNIbnVVUkJ1UFJB?=
 =?utf-8?B?VEZtM2xxZ0cyY2lUeVJ4T3E2ZUZZZks2MWwwZG44d0VWZnM2bVFDOVF1d0Jt?=
 =?utf-8?B?VjNBb3g5dW8rcVB1OXFVNFpyeThHdjdWYkFvam16aktOZy9qUzFmRS9UeXFu?=
 =?utf-8?B?VlVPSkNFUnJTZkx2a0tRRE5FdFJjSFJoOGhSMmZ3SXh2V08wL2YwZlBzYVJa?=
 =?utf-8?B?Y2dtMGNlRlFYT1hlc0hMbnZpNSs0S1NSVVE3KzlZODRZRUkvV2JKbHBjanJi?=
 =?utf-8?B?eVkyNVphaUxoN205dkgva0kwSWZmK01QK3draFBuSkZMRVRWQ3owQ3luTTV3?=
 =?utf-8?B?L1VVRnprQjVtWm5qbFNZNGNpR2dWY21YL3AxbzdhaGcrMmkzUVZjTFhSdjJR?=
 =?utf-8?B?aHBpbDBBdW81dFFQd0poTFJTZnVTZWlGVndMcTFkV0xXbXVpL0Q5Tng1SVFL?=
 =?utf-8?B?b0UxWFk1MHlFUHZHUUVxUzEyRzVOUDVWenYzS1JxTG4yTEhFOHd3b1RiemdL?=
 =?utf-8?B?ZFRrbzFwQ2E5c1JPQStBNUw3Yld5VWZTcU83SzlNMkI1TzBEeVNjdUJXQlBw?=
 =?utf-8?B?S3lvbGs3cEtkeWJhaC8vVmJvZ0U1ZWgxallrc1QxTS9ySVFGRXVIUnRidzRM?=
 =?utf-8?B?dWxxQVcrZGtQdFNWOWJVVmRlRzFaWWVvY3pFd0F3eE83ckRyNHpPUXphdTVE?=
 =?utf-8?B?L0VETmFGYTFVcWVkMnEwN0NBNzFESCtSN2xOWHF3T0ZkZGF3L2cxaEhqTmlt?=
 =?utf-8?B?ZHFNdmVaazlVWkRQd3Q1N2Z4RFFIV3U3Z2ZTMExwRTg5QTRlK0xSLzVLMGx6?=
 =?utf-8?B?NVJ0UEg5NVl6SnoxZytHbkJJbGU0R0FkN0lwdEMzQmpIeUJNbHVuaUNhS0Ev?=
 =?utf-8?B?b0ljbFdZK1NPM1RqV2VHSG5pL1dUWGNYN0FYYnFpNmlzL3F6MzdmY2I1ZllR?=
 =?utf-8?B?VFBNOTRZQU5TbEIxMDhsRXhSb0k4bUcyeHliYWx6Y0JZUDZNRit3Tm5Rb1I1?=
 =?utf-8?B?TFRzOGNZdll6WUxoZ3RsY3pxVUg0UFNXOFAzRzE2dXRQeUFqY0dpVUZlZ0FC?=
 =?utf-8?B?elVQWk9XYklNOWRvNVVJUHpzUG5iS3VrTzU4VEpwemNwUE4zR0U5TmhablFK?=
 =?utf-8?B?WHpHVFpoVWVKZHJhdVdnTkJQKzJmSGk1Tk9CWElLWmtJcGgxbGcxakUvTEx2?=
 =?utf-8?B?MmY1bmxieG1iL2prTDdmWWE3dzNBNTIzdWVoS3paSUxiRFBJTE5OWnVPejZv?=
 =?utf-8?B?eHBiUlRjTHRmRDhHb1h6dUhPbnp6T1pXNTBHNE1zaXp5cXVCdHJqVTdMVDA5?=
 =?utf-8?B?b1FNa0t5QVJYajkvdzJ6QS9XaDlHT3pPd1pGOGl2WWVZSVpvdGpEMXZER1Uv?=
 =?utf-8?B?VUhldnMrM05HdXVwSzRVd1FSZFdoVTh0ZzIzUjk5QVJ5NjkzUUVESkRob0Ja?=
 =?utf-8?B?TEhOK2hGS3ZZemt4ZnZrbzMxVjZvTDliUSs4NFZBWnRUbVU2azB5WTI0c1pM?=
 =?utf-8?B?RFZrTTBBbG1EQkRleFBleW83MW56dDcvVER5OHBla2piWUZIaldCdW8yTnMw?=
 =?utf-8?B?MWhRNnlscjZ4bit2OGxGU3RWdEhNY2FNanllVk9xZndlelM5ZllWVUhIcFM5?=
 =?utf-8?Q?mtBU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af58e80-39c7-4c37-e36b-08ddb57b4a28
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 13:05:28.6109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vv+XvhqMJmJO6r6OK+5Sm/Hdv8LPFH3GyuVsnCAMuHLJ3JyIzDb1BFILtIErDN5K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8888
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDI1LCAyMDI1IDM6NTkgUE0NCj4gVG86IExp
YW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDIvMTFdIGRybS9hbWRncHU6IHZhbGlkYXRl
IHVubWFwIHN0YXR1cyBmb3IgZGVzdHJveWluZw0KPiB1c2VycQ0KPg0KPiBPbiAyNC4wNi4yNSAx
MDo0NSwgUHJpa2UgTGlhbmcgd3JvdGU6DQo+ID4gQmVmb3JlIGRlc3Ryb3lpbmcgdGhlIHVzZXJx
IGJ1ZmZlciBvYmplY3QsIGl0IHJlcXVpcmVzIHZhbGlkYXRpbmcgdGhlDQo+ID4gdXNlcnEgdW5t
YXAgc3RhdHVzIGFuZCBlbnN1cmluZyB0aGUgdXNlcnEgaXMgdW5tYXBwZWQgZnJvbSBoYXJkd2Fy
ZS4NCj4NCj4gSHVpLCB3aGF0IGlzIHRoYXQgc3VwcG9zZWQgdG8gYmUgZG9pbmc/DQpUaGlzIGNo
YW5nZSBhcm1zIHRvIHZhbGlkYXRlIHRoZSB1c2VycSBIVyB1bm1hcCByZXN1bHQgdG8gc2VlIHdo
ZXRoZXIgaXQgaXMgc3VjY2Vzc2Z1bDsgaWYgdGhlIHVzZXIgSFcgdW5tYXAgZmFpbGVkLCB0aGVu
IGl0IG5lZWRzIHRvIHJlc2V0IHRoZSBxdWV1ZSBmb3IgcmV1c2luZyB3aGVuIHRoZSB1c2VycSBy
ZXNldCBpbXBsZW1lbnRhdGlvbiBsYW5kcy4gSSB3aWxsIHJld29yayB0aGUgY29tbWl0IGxvZyBh
IGJpdCwgYW5kIGFzIHRoZSBmYWlsdXJlIGlzIHVubGlrZWx5IHRvIGhhcHBlbiwgdGhlbiBJIHdp
bGwgYWRkIHRoZSB1bmxpa2VseSgpIGZvciB0aGUgY2hlY2sgY29uZGl0aW9uLg0KDQpSZWdhcmRz
LA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8
UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdXNlcnEuYyB8IDUgKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdXNlcnEuYw0KPiA+IGluZGV4IDdmOWRmZWFlNDMyMi4uYzdjOWY5ZTU5N2YxIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiBA
QCAtMzE5LDYgKzMxOSwxMSBAQCBhbWRncHVfdXNlcnFfZGVzdHJveShzdHJ1Y3QgZHJtX2ZpbGUg
KmZpbHAsIGludA0KPiBxdWV1ZV9pZCkNCj4gPiAgICAgfQ0KPiA+ICAgICBhbWRncHVfYm9fdW5y
ZWYoJnF1ZXVlLT5kYl9vYmoub2JqKTsNCj4gPiAgICAgciA9IGFtZGdwdV91c2VycV91bm1hcF9o
ZWxwZXIodXFfbWdyLCBxdWV1ZSk7DQo+ID4gKyAgIC8qVE9ETzogSXQgcmVxdWlyZXMgYSByZXNl
dCBmb3IgdW5tYXAgZXJyb3IqLw0KPiA+ICsgICBpZiAociAhPSBBTURHUFVfVVNFUlFfU1RBVEVf
VU5NQVBQRUQpIHsNCj4gPiArICAgICAgICAgICBkcm1fd2FybihhZGV2X3RvX2RybSh1cV9tZ3It
PmFkZXYpLCAidHJ5aW5nIHRvIGRlc3Ryb3kgYSBIVw0KPiBtYXBwaW5nIHVzZXJxXG4iKTsNCj4g
PiArICAgICAgICAgICByID0gLUVUSU1FRE9VVDsNCj4gPiArICAgfQ0KPiA+ICAgICBhbWRncHVf
dXNlcnFfY2xlYW51cCh1cV9tZ3IsIHF1ZXVlLCBxdWV1ZV9pZCk7DQo+ID4gICAgIG11dGV4X3Vu
bG9jaygmdXFfbWdyLT51c2VycV9tdXRleCk7DQo+ID4NCg0K
