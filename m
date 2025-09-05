Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066E3CA0FED
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 18:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D5ED10EC27;
	Fri,  5 Sep 2025 18:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XGP2SN1Y";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 872C510EC27
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 18:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeSq1dL5vBe4ytvXJG/hjz+Iled+1uHOL+sI1RJfp8XhsYq+noInVVShQQCh1jEx81cwDA75RWojuiKY4A2L3kawiLchxbVgLRvWJb+zt1473t858ccgO3fbd7gM+n+Koku6Ri8vxET8mAcPo/+v/yEploa1lhgaUbZEhjnxkpiR0G7PljXvSS+If2q/e5ntzTK1MbSjiqW3OgHtpamcPNcmjOEZ6Autjrr+rh7SVMpP4iZN0h1JsEUoLjIz9COQ9Xvm+lv3tOLLGa3ZV3KURJhOO88UvKItN1nQR1WZD0hapUKXRmXvgfXWtmb4AOK0vudo+kBxHpUGaNHROjXWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IK4KJBi+TsNXhf8O+bnh6KyhZuXMQcyd0NI2z0z/YI=;
 b=xqma/khxT3S60paOb544OEdk8oRR1PlcmjBiTaZQ9drtJ63AKwQpG9RVGszlD7GPCOS7HOeIAUxWTyOOpFfN4csGlf5EwPNUgNpVUwEDKujuY1cIH2hGQ6Auu+4ccSEsyg2FlUPDLWwcX/TzDcLtJsG2Ern+WKXZCKmF/quTLdq3SaQcnHOJ1PujdcVPWLqur1v64liP5a20Rx8PeLinLsfcI6Vl6YBvQwBVYlkQCSXn+udt1PAY2yd1bX+/WY0C+3A5AlFCtj5kI/hOJYNg2Nu/+POqSIrO9fYRqnf1k2tWlN4/TIcSAAnTRnCWkuvZczvzBZFNUIw28/8D3EAKoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IK4KJBi+TsNXhf8O+bnh6KyhZuXMQcyd0NI2z0z/YI=;
 b=XGP2SN1YoMk/kYmrEPTEvPnCQfFW1E0LaR3kJBTffmMSOafHwqfPQC2w/uZW34vd2OL6NhEEJ0d+xESiFTX9+Zxin/xnZDiTYWl0xnJEhwo8FMmx+XywgIRCqhOEir9OBXEkE+6Ejwl4ScIP9wXuuwBtt3rV4/CJUgdA9F+Neyw=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 18:39:29 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%2]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 18:39:28 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
 <ckoenig.leichtzumerken@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "timur.kristof@gmail.com" <timur.kristof@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: reject gang submissions under SRIOV
Thread-Topic: [PATCH 2/2] drm/amdgpu: reject gang submissions under SRIOV
Thread-Index: AQHcHmNMvB5q9fZCEE25g4DO9aGvqLSElhcAgABU3fA=
Date: Fri, 5 Sep 2025 18:39:28 +0000
Message-ID: <CH0PR12MB537231D3E692E6028C057F0EF403A@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250905124742.11305-1-christian.koenig@amd.com>
 <20250905124742.11305-2-christian.koenig@amd.com>
 <CADnq5_OmQkYaYSu-QYCXV7YcPLtbVsKqwsjwWt=coPoRcrvadg@mail.gmail.com>
In-Reply-To: <CADnq5_OmQkYaYSu-QYCXV7YcPLtbVsKqwsjwWt=coPoRcrvadg@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-05T18:35:34.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|IA0PR12MB7506:EE_
x-ms-office365-filtering-correlation-id: 4d18f20f-7266-4917-6d1e-08ddecab8be4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y0sxNkdSazFnZVhEQzR0NHVaR0ZkWUNIUVNQRmI4Y2MxQlcyOXY4NzA0L1Zi?=
 =?utf-8?B?dFF6N1pEWGVxdUtLNXovSEwrdjVNaGlUcVZPZmlLL3NoSkoweDlZUzZEcWVI?=
 =?utf-8?B?cUtOUGlMMWJ1Q2lLMkk2NkNZTDRVTUp0S3E0VFY3V1I0Q1dTNU5ZMTNUK1JQ?=
 =?utf-8?B?S1lEOGRVd05qenliamgxbWowUjQzNEZlZmFNcWROUVdUdFpZWE85T1NlTEtG?=
 =?utf-8?B?dHlGMGFlamR5dGdQNmd6ZHZsbGloK01HRHRkZ25CZHVycXRZd0FhOG9tR0FG?=
 =?utf-8?B?NlRzVGoyQkVBMld2NkdaSVJ6MzBHbVh3ekEzR0NaK1BJcWhOUjJRbCtHNTcz?=
 =?utf-8?B?MFhYcUJDRmMvbFJHL09yRUwvZkRJWXBWRWFweXZBMFQ1WUtJN3NFQ3p2TWhE?=
 =?utf-8?B?MWxTMmVKYTMwT1FVRC9YT005TzVEVVMyU2t6NmlKVmRxbWFtbW9icFc3QW9m?=
 =?utf-8?B?YUMwLzZXa21oOXgwRS9MYzNxWk11enZBdGljVW0ydVF4MXliV2dPanMzeEY5?=
 =?utf-8?B?TFhEOGYvWWZ5eWFia3FVS1M2cENBUzl6MEhFYy9CT0IzRU9TVjFNS0tCUi9t?=
 =?utf-8?B?b29zWDh5ZkV5STJsNXRKbnlDQ2VuR25HUlcxandMa1Z0enRja0ZMMG42a29B?=
 =?utf-8?B?MHorQ0dGWUJNT1haYlkzR3RsdEZUNUtiN1ByMmtXYnlXNGRhdGRXbVVFRzBE?=
 =?utf-8?B?T3VVZ3VhN0VQUkwrZFREQnAxbU9oVmQ2STBiaDNMMXhLZ2xzNWJDVjNFazBx?=
 =?utf-8?B?WW4wRkNJZTh5MGhYNnU4K2Z6cytsV3ZrUGpMSXJzTXcxd291Y3hFL01uSjZv?=
 =?utf-8?B?YVVsM1QxUGJWVHA2eXRZYWVTNHNuZFJZQnF0d0pGbjZ1Vm5WSjVQUnkxTVpS?=
 =?utf-8?B?Rk9VSllrMHV3R056WjNFdUNpSDJaQlRxMW9jL0JhWDAwUVdPY1FPQXEwdjhF?=
 =?utf-8?B?REREOHVlNlNVYUUvaXB5UGlWVG9QdVVlRWtXR1VlSEVSTEw0VC9oSlRuTTZN?=
 =?utf-8?B?a281NnJ3V2Y5MCtZMWlWY29BYmN2dDMyWG1URm44eWdsZEN5d2F2RWpoazYw?=
 =?utf-8?B?enlCd2pzL0tQNEQ2dDVTeDVyMitnMkN4WElOaGJpNjcyUUcwWGU1S1VwLzBs?=
 =?utf-8?B?ZGZUbTZIbVpEUWFaS09NUFV5VlM3V3FXaU1IUWJZNUZPelZuSTdDMzl6Znlp?=
 =?utf-8?B?MUc5RE9yZlhEaWJJT2s4UXFJU1NOcEFNUFprckh3bGVGbE5uY2I0VU80MFVp?=
 =?utf-8?B?TndPUGV6WXJhUXRLdzBEYklDNUN6c2JnZDZGdzJWUEtLR0hLbVNxT0NIUlJ5?=
 =?utf-8?B?SWFXd0g3Q29XdzhOS0I1eTB3LzBocEhvVWMyVUtsdlA3YkxCb08yMUxIQnhS?=
 =?utf-8?B?b2RDak5EdHpqNFhsVlR3WGJiVzVQZmZBUXNzdlpTRVFiSUtYQTBYZXJtUWg5?=
 =?utf-8?B?L2VQL3J3Tkw4Sk1BeXB5SmxQaDBHa1hEc0FsRjh0R2tTdVMyTDYrUURUT3NI?=
 =?utf-8?B?R25GMVlMNDNPdUNqQzY1UHFROURrTjhIeTRIUlFhOHRIQkpta2NmU0piT3hF?=
 =?utf-8?B?ck4wWDgzVzFrQzdTK05nVFc5NjJ2aDZpTmZacjVuazdjRERZdUo0ayt3Yy9r?=
 =?utf-8?B?cjk4NXJKbm13REdQTzgvbjVFZUR1dWRNTGpJRlZhY2xQcUMyUXZNMmh1bG80?=
 =?utf-8?B?QU9qdU5HeExQeXYvL2tkMCtaSjdNbWdlanF5dUpNNGJ6RlZJeW9WcWltTXg3?=
 =?utf-8?B?ZXJNZ0VZVDRjdEMyL1ZYSmtaWjhNdkR5NnN0Wk9rMXBHV0NFeElIVmVIaVcy?=
 =?utf-8?B?bG9zdEQzK25vNVBScWJIU1RBZWJFaWFqUHhKQy9yNytEaTEybFRBa0g2Sm41?=
 =?utf-8?B?dzJOaFRoUDNVSzByK3A3WURKRzBta0V2d2dCMExmMExsblMrQUtmc21mRUZU?=
 =?utf-8?B?VHU0enU5bzFiaUVxYnNvbElCTzB0azk0V0lVb3JHdUs0LzF1UElQQ0JpWHVh?=
 =?utf-8?B?UnQrSnNyYmFBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGZuWjlBUWMrZ0pEWTczTFBFZW9uLzdTQkxhU0M1dXpGc3lwRGkvbWZnM21a?=
 =?utf-8?B?RFpzZW51aGZTTjFwbU1sTjhkK3F0aHlnQXlLZUYybUJjTFRadC9FdGluaE1o?=
 =?utf-8?B?UGdCT3VZa2cya1pXN0t0M1ZwMFFQRTlmYlg3QnRoM2ZrZGFCSituMzRlMnFR?=
 =?utf-8?B?RUJ0ZUVkdXpDNHJNYVRJYk5ILzZ0TGJYdzJEK3piV3N5SjlHWnJNT0RFK0NM?=
 =?utf-8?B?MmVzMlNRRllVZ1hpR1g4QzFBMkxVL2Z1ekJVTmV0dkllMmlxUG5tUXo4T2k5?=
 =?utf-8?B?QW84RFZQNVNHUlVDUzdpUlgzSHdGd2I2SEoxTXVMTTRvWU5DSUNKZDk2WnFh?=
 =?utf-8?B?VCtzWFZsMEErTlNRN0paaWM1dnYyMFQ3MUZSTTlUeFIyNG5tQUNSU2dBcitB?=
 =?utf-8?B?VmpIN29JVlg2NUVDbDcwaDBqbVVnK0ZBL1ZNNThoMzRabWRacHdKb0R2dXpI?=
 =?utf-8?B?UTdLSExTcnhJZXlOcHduc2ljMmFQSXBac1pwVWhUa2dCYytTS1crYjE4eStl?=
 =?utf-8?B?K3A1a2dyVXptODJDTjV5SmlCY05YRFBjYXo4bnh4M1NOcTV4M3lpRzVJMjB0?=
 =?utf-8?B?aSt4RHpoUm5HREljS2xjOGRFVDg4RnRPLzJYUE9rL1UrZDZLb2l2dzk4eXhI?=
 =?utf-8?B?RzdJQVF6R3UvK1ZLWnRsQzE1YnVtSHZvNDNiN2N4N0VONkRkQ3VhbEFnUU5W?=
 =?utf-8?B?U2ZtUVgzMGpVVCtHRDhFMFhlUGdlWHFOdmtsRGJMUkM5OHRoMHliV1g0SFQ4?=
 =?utf-8?B?a3EvdGpIOHNZaDczcUZaM3FlK09seVA0K3pnamZsQ2dQUERCaHNTbWxtbnkw?=
 =?utf-8?B?UnY0RlZwYUJtNlNqc2cwanBYTEt3VkdhVmVEWUJ3c2JXMWZReGgzNEt5SC82?=
 =?utf-8?B?YUx4elA1ZzNiQmdnaXFJNUVScnJySllocC93VDRJMkZydUpyM1dmUU9ud2RQ?=
 =?utf-8?B?Mm1oODgvc0F3SzFkRnNDNHFrYUhGYVpmMUx6b3VVNm9WZEhJS0JvRmpLZkpz?=
 =?utf-8?B?R3JRSzRjTzc1OG14cTY4SlZjWGRPUG1VTytsM2tTT2NlUFYvVkhrem1ZakR6?=
 =?utf-8?B?M3lRbzdVdWlFTDJJQTZzdTVJR0pzTVlYUHBIZXpkVmpKVXhzZUVuODJMdGRy?=
 =?utf-8?B?ZmtGOFBTVnV1WWJscUcyc3FmUWNvVkFSdVh4NTNia0FQMGFaem1vV0EwbElh?=
 =?utf-8?B?VjVqcFkyQ2g0U0xpZ2g1ckxNS1IwdXMvMUo5ODBFSVRwYU1lbzhRSzROcUpu?=
 =?utf-8?B?anpuMUFFaUw0SXR3TU1XbzlUdVd5UUtLemxhTVdnKyt0V2kvV0dsMWZvVERO?=
 =?utf-8?B?L1NhbjFzKzdtSzVRRzJ4aW5NMnM4QWtqSkc2Rkd1NXBmYlhMQU94MGVwZ0M1?=
 =?utf-8?B?aUtQUmZTbzdLU2ZkQ3FlejJJcTBRRjgzRm81dHd6SlVDMEJUSVc4WWVLVFFY?=
 =?utf-8?B?eS9JYjdwdjNCQVdYbzZ5TDNiSnEwN3lLUm1XQ2gvc0g4QTRrSDJhMkNodU4v?=
 =?utf-8?B?RW9WRkZrWEZzNnZTVEFCdFFleGoxQlRTdHNRdk4vODd6TmhaaE5aalhPTVBj?=
 =?utf-8?B?ck5Pb05weG9tK29TWEU0cVVkNXJEUzg2ckNRVWFKU3N6KytGU0hJekFDR1d1?=
 =?utf-8?B?Wlhyb2pHbWpuODRaY1RPZDZXMWpjMjBXNzA1TlQvMUhJYWtVREhFeTdYNWZI?=
 =?utf-8?B?TG53YmxzZTFGb0FEMy9yRlJUWU5GSTd6bmVwSkR1b0wxWDhzQ0R0REJYUkVw?=
 =?utf-8?B?V0RqTmF6TVpNeDZJTURxU3lOUnpBQml2QVJwTTRBZGl6aDRNU0tpRmRUZGhV?=
 =?utf-8?B?a25qY05JaG5mNUt4SzlXNVk0bUViNi9pTkl5YnUxcXkwK0o3S1FkQzFFNXVJ?=
 =?utf-8?B?QWV0YUJzd3BLVWdsNUN5dTYxRTlBSEhhZ0xvUGduVWNGZHNvd2IzWTh4dUdC?=
 =?utf-8?B?SHFNSVgxOFdwT3N3bXFlLy9xcnZranFrWkpjUkdLbUpSa1N6YjVmUFRkU0pF?=
 =?utf-8?B?RlRER2ZmSytFQWtmdzZvUzFlakhhK2dHdDRnK3laZ2ROY2FEakc0eVlObE9O?=
 =?utf-8?B?clJUTTNpVWJLR1BJeGFWTnAwRURGUER1aGlBdjlIdVJBb3pOcHpWd0RJS25L?=
 =?utf-8?Q?ZKv4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d18f20f-7266-4917-6d1e-08ddecab8be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 18:39:28.6738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SChYynZPctyTdLT8YbPlwFqfuPJd8fZF1gOxEy/5YC7RVm39ZkiTFscyTpr/mtcUfodduSzHQjk7r5hEY6Ru7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506
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
Cg0KSSBjYW4gY29uZmlybSB0aGF0IGR1cmluZyB3b3JsZCBzd2l0Y2ggdGhlIGVudGlyZSBnZngg
YmxvY2sgKGluY2x1ZGluZyBnZngsIGNvbXB1dGUgYW5kIHNkbWEgZm9yIGdmeDEwKykgYmVlbiBz
d2l0Y2hlZCB0b2dldGhlciAuDQoNClJlZ2FyZHMNClNoYW95dW4ubGl1DQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleCBEZXVjaGVyDQpTZW50OiBGcmlkYXksIFNl
cHRlbWJlciA1LCAyMDI1IDk6MzIgQU0NClRvOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxl
aWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgdGltdXIu
a3Jpc3RvZkBnbWFpbC5jb20NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBy
ZWplY3QgZ2FuZyBzdWJtaXNzaW9ucyB1bmRlciBTUklPVg0KDQpPbiBGcmksIFNlcCA1LCAyMDI1
IGF0IDg6NDfigK9BTSBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdt
YWlsLmNvbT4gd3JvdGU6DQo+DQo+IEdhbmcgc3VibWlzc2lvbiBtZWFucyB0aGF0IHRoZSBrZXJu
ZWwgZHJpdmVyIGd1YXJhbnRlZXMgdGhhdCBtdWx0aXBsZQ0KPiBzdWJtaXNzaW9ucyBhcmUgZXhl
Y3V0ZWQgb24gdGhlIEhXIGF0IHRoZSBzYW1lIHRpbWUgb24gZGlmZmVyZW50IGVuZ2luZXMuDQo+
DQo+IEJhY2tncm91bmQgaXMgdGhhdCB0aG9zZSBzdWJtaXNzaW9ucyB0aGVuIGRlcGVuZCBvbiBl
YWNoIG90aGVyIGFuZA0KPiBlYWNoIGNhbid0IGZpbmlzaCBzdGFuZCBhbG9uZS4NCj4NCj4gU1JJ
T1Ygbm93IHVzZXMgd29ybGQgc3dpdGNoIHRvIHByZWVtcHQgc3VibWlzc2lvbnMgb24gdGhlIGVu
Z2luZXMgdG8NCj4gYWxsb3cgc2hhcmluZyB0aGUgSFcgcmVzb3VyY2VzIGJldHdlZW4gbXVsdGlw
bGUgVkZzLg0KPg0KPiBUaGUgcHJvYmxlbSBpcyBub3cgdGhhdCB0aGUgU1JJT1Ygd29ybGQgc3dp
dGNoIGNhbid0IGtub3cgYWJvdXQgc3VjaA0KPiBpbnRlciBkZXBlbmRlbmNpZXMgYW5kIHdpbGwg
Y2F1c2UgYSB0aW1lb3V0IGlmIGl0IHdhaXRzIGZvciBhDQo+IHBhcnRpYWxseSBydW5uaW5nIGdh
bmcgc3VibWlzc2lvbi4NCj4NCj4gVG8gY29uY2x1ZGUgU1JJT1YgYW5kIGdhbmcgc3VibWlzc2lv
bnMgYXJlIGZ1bmRhbWVudGFsbHkgaW5jb21wYXRpYmxlDQo+IGF0IHRoZSBtb21lbnQuIEZvciBu
b3cganVzdCBkaXNhYmxlIHRoZW0uDQoNCkFyZSB5b3Ugc3VyZSBhYm91dCB0aGlzPyAgVGhpbmtp
bmcgYWJvdXQgdGhpcyBtb3JlLCBtb3N0IGdhbmcgc3VibWlzc2lvbnMgYXJlIGJldHdlZW4gZ2Z4
IGFuZCBjb21wdXRlLiAgVGhlIGVudGlyZSBHQyBibG9jayAoZ2Z4LCBjb21wdXRlLCBhbmQgc2Rt
YSBvbiBnZngxMCspIGdldHMgcHJlZW1wdGVkIG9uIHdvcmxkIHN3aXRjaCBzbyBhbGwgb2YgdGhl
IGFjdGl2ZSBxdWV1ZXMgd291bGQgYmUgcHJlZW1wdGVkLiAgRXZlcnl0aGluZyBnZXRzIHJlc3Vt
ZWQgd2hlbiB0aGUgVkYgZ2V0cyBzd2l0Y2hlZCBiYWNrLiAgVkNOL0pQRUcgZ2V0cyBzd2l0Y2hl
ZCBpbmRlcGVuZGVudGx5IHNvIHRoYXQgY291bGQgYmUgYSBwcm9ibGVtIGlmIHlvdSBoYXZlIGEg
Z2FuZyB3aXRoIFZDTiBhbmQgR0MsIGJ1dCBJIHRoaW5rIGFsbCBnYW5ncyB3aXRoaW4gR0Mgc2hv
dWxkIGluIHRoZW9yeSBiZSBvay4NCg0KQWxleA0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfY3MuYw0KPiBpbmRleCAyYWM5NzI5ZTRjODYuLjQzNGE1NTEzNjVjNyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMNCj4gQEAgLTI4Niw3
ICsyODYsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc19wYXNzMShzdHJ1Y3QgYW1kZ3B1X2NzX3Bh
cnNlciAqcCwNCj4gICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICB9DQo+DQo+IC0gICAgICAg
aWYgKCFwLT5nYW5nX3NpemUpIHsNCj4gKyAgICAgICBpZiAoIXAtPmdhbmdfc2l6ZSB8fCAoYW1k
Z3B1X3NyaW92X3ZmKHAtPmFkZXYpICYmIHAtPmdhbmdfc2l6ZQ0KPiArID4gMSkpIHsNCj4gICAg
ICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQo+ICAgICAgICAgICAgICAgICBnb3RvIGZyZWVf
YWxsX2tkYXRhOw0KPiAgICAgICAgIH0NCj4gLS0NCj4gMi40My4wDQo+DQo=
