Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2205C369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 12:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4255B10E267;
	Wed, 16 Apr 2025 12:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wCKwGC79";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE2AD10E267
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 12:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDBx+n6H4KQdqXVYZSxA9fccI6a1DUK8AmgTOKctbtBq4zUEYsbOSYNPmnL8xUQNt2vvH0ePyueIFVFIKH7jLNvDRtkPV9vAKKY8SyxaJXLCxNb3eryp8bwO4aRKZrqrvzyLdSTiIu38+rAL/IRgNwLFD+nhERRBK788YqBTk2VR8p8bwS17xD5SVo1tw6kYZmMaZ4DYnOZdx1P/Ze+S3lS+bh3s9ALGw0qEgaUeZGXllZd9d4xGTvS6wPtUojQRcPRzaaWiWK6hjXCd1aYFSFz3gMUshBHam1gnKBFY5Y8PNoHRp2RUppJdo1DmOKvNapawufMxJkg9wqnyrQBgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhdb7WdDs565pjCsQVQXH9lW02tmkiGNATmXLHw0mHw=;
 b=p76eAqYoS+IJieIuDXwcAD637SUWp7hSfLhKP5HDCk9D2tW4xe+5dyYlb7t7yU2ERfte8bDgsj6To00bJyQ4US6/AzzodjigK7N/yh5MhvXpU4bL8OFdcdJCSfJjdnEYbZZ10HAPSnPY5wbw6OajcDTgBssPgdkP5/7DA7Ckkc8HeZrOLnoMWJtspfyx2rOR3u8QlMabhHvgOmKy3WuuJ1+64EsCov829JD9fU213n9VO/W+jl86UXv3lSbce0FPaV21wgf5og2xx4hNSLpLRPY6MS+qv8pOsWuOFLMbeSeM2CrX2asreopt0IskR4BCAROsEXvk+mc++VTVPnivgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhdb7WdDs565pjCsQVQXH9lW02tmkiGNATmXLHw0mHw=;
 b=wCKwGC79qWy5InH0OhLQ+8BxCSwToH+JY1sjvHmqoTxPaiGBaeZKXq6YD5ut0N7j/bD14MB1dGMM2mnq4eYGJMAtQ3LyV78tf60gy0clSLxb8MwO1aYM9DGUVfaDm36LJnIPkdvSAM3rGUdEivmCrSpurecOJrmamSfYleArbKI=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Wed, 16 Apr
 2025 12:56:55 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 12:56:55 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/4] drm/amdgpu: set the evf name to identify the userq
 case
Thread-Topic: [PATCH 2/4] drm/amdgpu: set the evf name to identify the userq
 case
Thread-Index: AQHbrqylbl6d51WcykqiQpAcp1hFWrOmILuAgAAfTzA=
Date: Wed, 16 Apr 2025 12:56:55 +0000
Message-ID: <DS7PR12MB6005D9590525F84D79614C14FBBD2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
 <20250416085029.2278563-2-Prike.Liang@amd.com>
 <b89e4f0e-158c-4bfc-a5ae-8c95841850b2@amd.com>
In-Reply-To: <b89e4f0e-158c-4bfc-a5ae-8c95841850b2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=54d9601b-cd3b-43c1-9f34-a24fe5b255dc;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-16T12:54:50Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MN0PR12MB5785:EE_
x-ms-office365-filtering-correlation-id: 527ad05a-cfff-4df0-a490-08dd7ce62a5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Y1N5RGJnOW43dzZJeVV3Tk5JdE1SYTNTcVgvenRvNXAxam4yVnFDeFlNaUt0?=
 =?utf-8?B?UmxlNyt0VmFIY1lEa2xXaDdWcytMQWttMW14ZUJLVFVJMXRrcTlLS1JMNGt5?=
 =?utf-8?B?ZkFQUUtPRlM1N0J6YUZQaDE5eGhCWHJrVVFPcnZ2SGpTWFlFVmxTd25LL3c1?=
 =?utf-8?B?SVRPQjBRblk3aTFkVTFwQmNGcVBZZm9iak0xc2xJOFFxZ3lCandFR0ZWei9U?=
 =?utf-8?B?bnM4bS9SeUV0NGNFNDltc01ZMkJVcjhEbEVnSnA4aXdzdWJWOEF0Ymo1RllV?=
 =?utf-8?B?dXA0TmdkWGN0aVdYd2VxQ3AxcGx1T2ZpNEluWkRVNHc3cjRtNUxxcWxWZ2Nw?=
 =?utf-8?B?N0dzS205L3diK0pwQ3hkRjVxZjJjRVlHYWhkeFBCQ05oOW9ZektZdVFIQXdL?=
 =?utf-8?B?WUlGdDBRL005S3FibFBSRVE4WkFhaGM0bWFXcksvSEthR2dDR2t2czV5Q2ls?=
 =?utf-8?B?L2Rlc2hyUDlNakljRzRVLzFpTjNtY0JmK3U1SFZoSU1WU2MxSzM5Zjh5b0JT?=
 =?utf-8?B?K0o1S1dEK2kxeDJFZzBMdGRxWUVSbE5zQkljR1hPbWNiYW9heXVIUytHU2xj?=
 =?utf-8?B?bmZNa0RDcU9rNU5vVnhKc0JKU29tTXFqZVVobFZxOXgyaDhJdWo0SzFhOFlH?=
 =?utf-8?B?aEFmWlhpdmNkNU1YQkQyTWIzR1FHZ25pNy9vUXVySVJOQmdzaGpNblF6aFNa?=
 =?utf-8?B?eHBYLzh6K1lUU2NGb0dTT2tiRkpQbWxxL3dqUlRQdGRrR1ZtbzQ3UjJ3cHFX?=
 =?utf-8?B?ak1JbDU5VU42YWVuTHlraUhlVU1aL21TMGg5N01jQU9ITFQraHFnT0xzTVdh?=
 =?utf-8?B?TjdZL1BuQk5QSFlyVlVnUWxVbkVxbFpHR2JGUC9pckNtTUNPZTN1ajlKODZZ?=
 =?utf-8?B?ZXZ4STc0SXhYTkdUajI1TmIyNTZXQ284RWV1ZlU4MGg3aXJFVUw1ZXk4bDNa?=
 =?utf-8?B?cHowZjcrUzdvUnpoeWpIRVh3OVRVYjFCYXhwb2lKSnFSSXlaODFWeEIwekFG?=
 =?utf-8?B?K0VuWlZ1Mkx6R2JXOW9TZVB0WW5JeWxwOVF1V2xKa0lRWEhqTERlblpRUkxz?=
 =?utf-8?B?aG51ckFKTFFxVWJuclFhaThaM25zQjdoNDNrNW1NK3huSDR3cmNsZkxyZDk1?=
 =?utf-8?B?d1dYcC9CODF6ZUkwMm9YcFRTN25Vd2Z6TFVQYmFKclJFU1VmWk02ZVl4U002?=
 =?utf-8?B?d1RuN00rcm50NXV4ekpqYjRqQWphMDNtR3VxcTYzT1RnZHlIZjJkWERUSjl6?=
 =?utf-8?B?d1NXOGFVYnJ5YUZGTjJwazM1aldNYU95bENEeGR4cnlYL2JHUEpkaGh4VUsr?=
 =?utf-8?B?NXdXMngyeHRCYmlyVFNoNzNyYll4TzhaRjVLdkRLT3BzMVNIRkQ5cUJQMHZ1?=
 =?utf-8?B?L2VIOW9hUHN3eUs3OFNXUE03WUQ4aUhyRlR0dkxjS1pQUU4zYkJpcVo5U0tx?=
 =?utf-8?B?N2Zvb1NBd1BnWWpwQWNtcDJhNUd3eXZJKytPTXF4d29YLzNQbzROaXV1UTRY?=
 =?utf-8?B?c05iWjVHamhUQlZldkVZbGJWbTJheGRCSkEwUklaSUJFZlVFZ1RIbC9RWXhu?=
 =?utf-8?B?d2crdXVuVDBhNWxlb1pLSFlmTUwvczViYUZSOEhqMWZXUy9uNFg3ejU1dnFE?=
 =?utf-8?B?dEFVRStEbDVVVUxUMnBJRktrTVVETlV3OVJYTFVPT3Awa20vUWFFU0ViZWFs?=
 =?utf-8?B?VEJTQ214Q3lVT0E4MDVmTEtpSzJsZkxVUzdOQlQvbjg0K2kwTDJPQ0FCL0ZY?=
 =?utf-8?B?aTRoSXZmdm1lSE5XQTl3OG9kdlI3SnZWek43U3A0a0ExR1VsNVJCRlpBbXpw?=
 =?utf-8?B?RXpSMEJTeHc2NDIvUEQ1UHZ1VlhpYmY1cTNvYUNTLzVQdm5pS1R6cHBNTlh5?=
 =?utf-8?B?SFBHZjlUY2g3aTVmMlQ0clRJck9GN3VVYWNQRktMNGtoQXVjd0VLbzBVditm?=
 =?utf-8?B?N2JWNGdiUDV4R1I4L2RPUEZaTHFvZEtzRUllR3k4NktrU1VDWklHWVFtM0ow?=
 =?utf-8?Q?Lf4f0HRRJalApU1u6tiD8r8YuSIVUI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDZTTmE5dUdPcUVBRGdMK2I2REhyRVVyNFU1TnNnM3pqNEpnc0RYQ1VuQXV5?=
 =?utf-8?B?TGxXaHR2NHRobCt1eS94RkY2a2F4Z282aUh2RmQybFRvMnY3aHN0Y1VOcEVw?=
 =?utf-8?B?ZlMzUXJyS0RqV0YzUHhFSGt4Q09MRVhpaG82VTZNSjYzUjFFaDZlSk5yWksy?=
 =?utf-8?B?SkFMOVV6eDZ3bVdCWkZPRlY5U1VJcTVCcWVpdGxuR0dSWkg5QnZTMHljQ2lB?=
 =?utf-8?B?TmxncU5TYzduako4a040M21CbGNRVi9ibEdmWXNJcDQ0dVd6OUdqNWcvdGxt?=
 =?utf-8?B?MnQwQjgrWVliRkhOblM3MWpNOE4rQWtKc0svK2VzZ0Ftc2lIMDE3NFRMMG93?=
 =?utf-8?B?czZaR0piek1NUEhmcVJqY0pWOHgrVTNDcXd6OTBEb25QQWdFTjdZM0s3a2RO?=
 =?utf-8?B?OFJzR2dUVWxhNEJMK0swbGVOeGo5Mk8vTG5jQmZqdVdqUjlaMW01SzREOEps?=
 =?utf-8?B?NXc5WllPalRhUVlUNkhtS2g1bEhSM1VpNGRlM1J3blpmOEVsVVlZWVhPbWJ4?=
 =?utf-8?B?WWhpMTR0YisySUhURUwyR29Cc2ZDVHhOZnErVVh3bm5YRU5CSGxiQ0ZlSEsx?=
 =?utf-8?B?VXhrOEdOb1NERkRsVUVIeXJDU2czQ3d1c0d6VHJnZ1RRWS9KRmJhbGptM1p3?=
 =?utf-8?B?b0hEWTRDSHQ0Um1ZcjRROGxYbTBkOGpSOTRFQS95dnFGWUhLTGQ4S1JNT1U2?=
 =?utf-8?B?dGJNNytDT2pzZWdmbTFmdUNxWC81NDBsblpXSlppYWd3MnhkQlhVUDFtc3FW?=
 =?utf-8?B?N2RJcWJWSmVkNEFkS21ZMzZ0TGFua08vM3lxc0tjVlRnK1pVZ1dERmx1RWF0?=
 =?utf-8?B?NklEekdaa0VxV01PMU81cjV2MzU0Z3RHUTNQRUFFaXRMUm52T0JGUFcrS3Ri?=
 =?utf-8?B?d3NrdGEwRU5mM1VjZllhNmc1ZklmaXBGSDJjcHdGaFQ4NUd1WUdHK2xIb2la?=
 =?utf-8?B?TTh3YUt2TXBPSHdZZ0luQ3F6U0lwTmdHcWhEczVIRFVoMWFaWkxGdkJrUlJC?=
 =?utf-8?B?cXZudERBaWJNa0FSS3pWdWxnVUcraTJhWTBTQXZRUTZNUXNBVlBHVHorM1R6?=
 =?utf-8?B?N1dYYkVobUtLa2RkamlTUnFkL1hPaFhnbFord21BOFdVNGxKUmxGbG44LzBI?=
 =?utf-8?B?SHYzSzIxMFFTOWhEam1BVENLTHRyeXo3MGZ1RDZLYTZIK1ljSExsTFcwZ25F?=
 =?utf-8?B?T0hldEVoa3g0TVZ1NVhIL0lBd0kvY3RxYmc3b2lCZ01Pb0VoeW0yeU1FZVJN?=
 =?utf-8?B?RlZrSzYwV0ZuamlnbFRJVzk5V3RCRmFVV2JqN2I2OGxVaTNFMkdueGVIVzRq?=
 =?utf-8?B?S21meGE2eUZpVU1IQS9qWWl6YkRTMU5tUzB4d2kwbGJreDRRaTQrNnRWQ0Ft?=
 =?utf-8?B?MkdJUzBtMXA2RlJSMUlOUUxwa2tiTWVFRkdIV0J3ZSt3bjQrcjZKYVNvd0FZ?=
 =?utf-8?B?eW84cDcwQWE2THNzY0gwYmUxdXY3UU1adUt3akQ3RGhrREYxd0t0S3dSdE0z?=
 =?utf-8?B?ZXFRR05TQXE5cWJOUHRkQWI5cFNVWEorT0hnSXdmNTg3NGJGdjB1WThvOWY2?=
 =?utf-8?B?SkJRNGNrMDJlblRwRzdsb2xCVTl5clhjcU90a2tlNzh2T3Q0MERMVTMwVXZq?=
 =?utf-8?B?cy8xWHMwakxhTmVyWG5lY1dPNUZyUU1WQzNaQlk1dkcwVXRPVjJwQVE0ZjBw?=
 =?utf-8?B?em80TUtLQnFxMEVob1BmVjFIMWlJUHdUeHhZcnpLK2RDcWk0cXJTTm5JTDkr?=
 =?utf-8?B?Vzd4L1NxYWQyQ1AzTncxV3FCWDdsdkpxMEVLcVNEd1ZZNTVRamM1dlNybEhy?=
 =?utf-8?B?NWdHYlhOU2puZDg5RmlCdEV4dDJVaW85bFZGRmYzeWovSFNxalREcjlVRFpY?=
 =?utf-8?B?ZmhsbmRzY0FjTFJHNWR5RjZxc3Z3NXBRbjFWTGhEQ3I0aUhhdjBCNzYwTWJv?=
 =?utf-8?B?WU9QQyt1cXhxUnlWSzVqRUEySE9nMzlWV2RGTzlxbWFiWWpHWFQvRmVjSVI3?=
 =?utf-8?B?Syt1VEVSREQzOU5Cai80SUl6ZENtdmNtcWpwNnFvdnRqb2NtbFhOeVZuUU9T?=
 =?utf-8?B?dVZsNnVLUmRFZ1gwa0pObEZJaUcwTXNWdFREWTd4Y3lWdFM3Tk5SZC92MG1Z?=
 =?utf-8?Q?8XQQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527ad05a-cfff-4df0-a490-08dd7ce62a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 12:56:55.1132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HE8RzvEKQwKELj1dx/Khl2tTOW4obkZu5VGoY7Zl4EKdns8ordk6e2vt9qs6oKF9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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
bWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE2LCAyMDI1IDc6MDIgUE0NCj4gVG86
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi80XSBkcm0vYW1kZ3B1OiBzZXQgdGhlIGV2
ZiBuYW1lIHRvIGlkZW50aWZ5IHRoZSB1c2VycQ0KPiBjYXNlDQo+DQo+IEFtIDE2LjA0LjI1IHVt
IDEwOjUwIHNjaHJpZWIgUHJpa2UgTGlhbmc6DQo+ID4gVGhlIGV2ZiBmZW5jZSBuYW1lIGNhbiBj
bGVhcmx5IGlkZW50aWZ5IHRoZSB1c2VycSB1c2FnZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYyB8IDIgKy0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2Zl
bmNlLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9m
ZW5jZS5jDQo+ID4gaW5kZXggNzAzMGQ3MjExOTZiLi5iMzQyMjViYmQ4NWQgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVu
Y2UuYw0KPiA+IEBAIC0zMSw3ICszMSw3IEBADQo+ID4gIHN0YXRpYyBjb25zdCBjaGFyICoNCj4g
PiAgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX2dldF9kcml2ZXJfbmFtZShzdHJ1Y3QgZG1hX2ZlbmNl
ICpmZW5jZSkgIHsNCj4gPiAtICAgcmV0dXJuICJhbWRncHUiOw0KPiA+ICsgICByZXR1cm4gImFt
ZGdwdV91c2VycV9ldmYiOw0KPg0KPiBQbGVhc2UgdXNlIGFtZGdwdV9ldmljdGlvbiBhcyBuYW1l
IGhlcmUuDQo+IEFwYXJ0IGZyb20gdGhhdCBsb29rcyBnb29kIHRvIG1lLg0KDQpUaGFua3MgZm9y
IHRoZSBzdWdnZXN0aW9uLiBJIHdpbGwgdXBkYXRlIGluIHRoZSBmb2xsb3dpbmcgbGF0ZXIgdmVy
c2lvbi4NCg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4gIH0NCj4gPg0KPiA+
ICBzdGF0aWMgY29uc3QgY2hhciAqDQoNCg==
