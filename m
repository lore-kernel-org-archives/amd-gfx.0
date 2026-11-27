Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4B7606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G8Uxpf8T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E13710E494;
	Fri, 27 Nov 2026 08:52:40 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2AC610E494
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 08:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zd0sB2ogGSUulg3NBIeror4kgxbYgDVv44m0TD0hUPoPwvkt1nXkwMsIVnhW5pUIH1af+8SqhdHlcPdb2zJ7m2IKhkHaDCN5w83wfCJAhWszFMixQzOEixhvYPRLkR+fbUfs/LwBAwTTTN36t5mBaIdhMikup5Kj0pthNfp9oeHsGycdgqgk8kRGCLbTaT0WDVmJkO/hiIoP7ImpsVh/VBUOwUKxtACNqftSQviF86MBHEadH5HoehqXbm2YwM65AeTBPS+v2Gp1W8gdJu7/PdWo8q4m4jo9XgBjp66htQtsaetYRDTLM+euy9a0SqExV7mpeB6WkN/YHQhnaUF1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arIXMs4KotEVd4NUORz/WKGvP4VpMjDT4ASRGNzAcPY=;
 b=aSFAWbX+1UrmgPL3xszM7OaY2e942jX0H30BhHcqiY+Z45wlAci7DRNs579FaIPjlBRWpo6eit4MnU63MzYIp0K+abA2hr6d3sruN9JyPPiPBOuZVLQBF1R/m1uIjVXvnEonsL8YA1XffLqN0JkYxVH5wgsiLj9r5zxu36HtCtm8RRK6EDxsw6VD6b3Rn2ZdnD4fxB8jfPNekWfvrp1O4SEdWqaXSzHlI90acyQHMv0vAqz4+7jTN/X3kKiCMGboY8MOl1LvCEUhdrPkTpuDNcuTm07/cOgn50qLeqVPIUDvb0X5tzVqj7vJ1cTwwJ5gynAOXRh8/B9Q26MJ1OdltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arIXMs4KotEVd4NUORz/WKGvP4VpMjDT4ASRGNzAcPY=;
 b=G8Uxpf8Tha1yaMynNyYz0Svmk8wrO+Bvcl2nrIWeS6byko05v4TG3iH3RGweWNG/4CaJg/VR0/kgTzq2dW+dD5Ify+GBjQAA3iKNS57tg6nmB+QCl8elmUFm1htjgIrf1AfJcNYdHGSTZR9Gl43NKosPf3t0gRvMIoydhXRP5ow=
Received: from PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 by DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:52:29 +0000
Received: from PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::7bd4:6ac4:fd7a:ec87]) by PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::7bd4:6ac4:fd7a:ec87%4]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 08:52:29 +0000
From: "Stamenkovic, Strahinja" <Strahinja.Stamenkovic@amd.com>
To: "Hosur, Priya" <Priya.Hosur@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
CC: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>
Subject: RE: [PATCH 1/2] drm/amdkfd: bound APU available memory by host
 available memory
Thread-Topic: [PATCH 1/2] drm/amdkfd: bound APU available memory by host
 available memory
Thread-Index: AQHdfklfgm6kllrEAkG/62E/p2DwOLdBnB6G
Date: Fri, 27 Nov 2026 08:52:29 +0000
Message-ID: <PH8PR12MB72089CA68BCDDD2660E3E0F0FB412@PH8PR12MB7208.namprd12.prod.outlook.com>
References: <20261127082854.112025-1-Priya.Hosur@amd.com>
 <20261127082854.112025-2-Priya.Hosur@amd.com>
In-Reply-To: <20261127082854.112025-2-Priya.Hosur@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-27T08:52:28.216Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7208:EE_|DS4PR12MB9793:EE_
x-ms-office365-filtering-correlation-id: 2a3010b3-f8cc-4707-5684-08df4c63c477
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|921020|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003;
x-microsoft-antispam-message-info: 7TDN5/vSAO+1axBtSCXELrpwR9ENSfzhPgMXgcEEj9dB5ebzLWQGdqgf5dycrJ5PFL5DSZedeGPMhviRZqVB+d4agB5gPkm7mltLlSLZ/kq7NrEckP9K4ZD2BjncPsu/ogWidfgmrkRKNPXvVi+D/R8vBFjoLvxCk5jrj673o1X5aS5yxlFusVWXWBTF7ywgjUrilqANQLKlmYOAk5WZ024d1q2xwYgKLDB4YvZIUu2xzp9nMxljX/yAcBfzUP3pU23orX0lEwTzrmeLLlDlt9+1xPP4IYFigD9LdNC+ujiMpB+TxyUTd0Op4M1b/aLOqAApPXgjElzjQcnFhIhtTBJ8OJjmpE7H53VEGwEQlhPooHvJUOTDOlN+dRam1FGEb+d2hQrXzC9yVe9xg8PjLTmr3R460qmIgYqyEmueRhSQiMr9ZFxj9v+QLQMfx8xDvGT6meGeHhPjjz0A19S4MxYYYrQKDPFqXgWl9aF4HnI6K59HAW04k1qJ9B8yn6nUkBF6TjzanFdhjE3zUCMSl0WpJa6eBxLxYSdigE9FHgUIRZZ3WKiur47Mzgcqdo0daaAaSQ9p0mtSwQxjTD4MPZRVvXIODEbOE2Eo3B2zbo2BePhGMMFTWVQPEgVqZyPp1e37a5BrfxlvgR7J6HZdP2Mx7g7bp/tnhqrdZizVDfB1TJyRz5O1wRzkRNOBWeOKV16f54D0geNueXuYrNeLcOvQmTuw0NfUVy7awh2QN+LGcoJ03+TCTO4D6YTNDfUc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(921020)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EWsB530wfkeMouAQwuq4J0HJwL/3NSn1G2ev4w+cLNUnFXOJ7RAQB6+c0T?=
 =?iso-8859-1?Q?Rh9iGRd3ernblKM+5EWiyBx24bTjJyHKZnc09BBXsQj8i/EOWQDsJZDicI?=
 =?iso-8859-1?Q?EJ/1gXgVKTPxj2kw9gzWQns42uG6jZSg2e/65yyp1DD4g++4W7ht+TeH+0?=
 =?iso-8859-1?Q?2k48kaOkNsGpbodr0By2KUzilcMVhEBehcJFYfX9rBsQpWgB8w8/HZKPYI?=
 =?iso-8859-1?Q?4Flf827l8qyTOfaXadTE9V2q4q/3AtJ2Zp+H3zIcfE6Nb5S17IVRFwFG6J?=
 =?iso-8859-1?Q?xNCSEXX0j1gJXnasvdV/UkNhprgvWyMMsy98qEoLqhqo1DKxWmsI1c3O7B?=
 =?iso-8859-1?Q?wjRdjcxZxcvfnp8aEaYL+SJa8oRKzadRTA0vl7WI937uvHWwpPDDRw1l3f?=
 =?iso-8859-1?Q?cLHj6/z/AtyK1DldUx05ARrE8Vn/JJ7wkbo+7NO5HlzRT/18N86xbZU7SM?=
 =?iso-8859-1?Q?eY9qY6k7+8dbNeVWR/Hqx3qt39hqLsJdCoznsq2kdecMY5njv20yjXDR78?=
 =?iso-8859-1?Q?l+iJ79YKjcokq8bQmjQiaur4RJ3JFopVuCOUsBiZRT85DxCEZvrrtAA2xR?=
 =?iso-8859-1?Q?9EBPXgtQCEOPFmONStv/r758XzGdDbdvWHr8IXCK7wLlJ70sd4tnBCZfv1?=
 =?iso-8859-1?Q?TYeMz2cfMChVAubO1YMS8IqRw3xBGJrfD96GD3BDj9J4ffTmdFykSwr7ce?=
 =?iso-8859-1?Q?+5j89WU8OzHFrY2TTtMqliswFUNURSjMMqs0VUmWAqJ1s3t36ZGUgTiTU4?=
 =?iso-8859-1?Q?NA8RF3JLNZPctVwcAe3w+b9rzYpHfQ4bRpvcTaIMo4P5bmQDoShrUON1yo?=
 =?iso-8859-1?Q?CwstWba5+RtrpepxbbZcozKU/Jo2LroiRV06bY6nxbqGKtRR5DDCrPprKz?=
 =?iso-8859-1?Q?fznKKG3bDCR2dp+HTtHOLXU3P5RRS/H6i/YXlAi1qJzjKKjzlkPNKndtqC?=
 =?iso-8859-1?Q?4fYkKHKD4Km6PX2CG1CvOY5o/lMwbL3MlUPqCc2dzsSf5XopwHeSTOdKMu?=
 =?iso-8859-1?Q?/w3NqB/cf/reeG5G+PmqVe1cJUbGM6RywlT440GpeJRASmUL6Uf6LVT+If?=
 =?iso-8859-1?Q?ONVcRjoLJPMOe/OKJzTFNnOXiwoigkghVmAXE3eSSB5W8umVz+93mpPanL?=
 =?iso-8859-1?Q?ukqmLMstEqTkDKMd1OqRh+piAw+IXQzJXvcDAkg+HDM+FD1ZYYmNCw8tf/?=
 =?iso-8859-1?Q?NBxnMnT5QyMLCu/htnLURG+T49X761ANFDp0BVy6IBGqi/+T/bv67vLtwc?=
 =?iso-8859-1?Q?g4LThbzPMFOOXXXdBI4FfwUWQEf89Syzphwq3sq9uZeTa2lj4mH+LSsYJ1?=
 =?iso-8859-1?Q?w6/MYua783WgX1ezwbbRjo3Oq8Ng3nP8cTrijm9byAYg3ACe23X+9V3YFg?=
 =?iso-8859-1?Q?ImZbn/M8raXGipFFOt2IV9q5wRzbeXaUmzrr0LwXl0CsjoHWo5ARYUKj1Y?=
 =?iso-8859-1?Q?VNJN9/hJBiWuhDeqi85JJCZsf+WxMPEnqNvjx1u9KjbFxsXSCjy6YUWh0q?=
 =?iso-8859-1?Q?NsWG9lPh4p8hwk2Bkfu91dJroLXSClou/1z+HVWOiNU05BSuWDG04/cxbt?=
 =?iso-8859-1?Q?RzOWtKEGp5SRTWZmnkin8OxGZ1PT0NOhhBP9r2gWhIRHLlRSNQLSx4nHK7?=
 =?iso-8859-1?Q?4JoK/SdvaV+EIG4T0v5IBg8bMjVwFrFpDngPU8lW4tQoUZlCE1Tt1G3PoG?=
 =?iso-8859-1?Q?Weml5t/hV3vzkiRXVCpdEZ3v8iAGC4qHtuRt6uMzlDtaVOKoYvaAR7sPKb?=
 =?iso-8859-1?Q?a58hyY/s/CnH3MQatOhp4+iJav0q+rKViLa7SqtD8wLhyRZ39UaDF2HE4E?=
 =?iso-8859-1?Q?k8YRuvPjHw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3010b3-f8cc-4707-5684-08df4c63c477
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 08:52:29.1335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Acyg+8Z2C0ox6TN53GQlpKkEhSHA98U8H1MNDDhhu1lUl28mTusKzmg9E7v/WKTxUuO4qaT6B3BmANi0zzqnAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Strahinja Stamenkovic <strahinja.stamenkovic@amd.com>=0A=
