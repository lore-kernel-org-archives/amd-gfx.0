Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB74606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=j1qUuxby
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AFC110E4B9;
	Tue, 10 Nov 2026 15:19:12 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn19011033.outbound.protection.outlook.com [52.103.43.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E4310E246
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 15:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epJZxZytTw8QuPH/g/68Y/C4jwMV5AsdV5aatnXGp3a75hJJ7M5zzGVrwr92QbaygLUSgArwKNai78MuiqcQ7SO83EgULST2oYcbOLseiEkNNDXZGwVawYWliWXni6XmI0hxnwtil8R3fBVCM7rhBULvPyV82vK3kbBxcyk51/Q8r4SujsSFtEnnjM456tojuH3Xs9XtuVw4K+Opy6QL+yU42mbICwQ7nbz5p55UfGnT2eSXtwgbF3bbE4jfHQCVvSXsfRUOagvw4ki4WXUCkG1BbeGjORifkNj+3cezgXMiRd47AtIQ32wq9alMul2iqXvyu4iPQ5Uu1i1g+ylMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85iJXb5pDielMRledepkWrJ9gz3vaT1B0kLuoZ+29pM=;
 b=mNVKNOe/jBsgfHYN4WTKSsouobaLS0JbH/ihDdZ/yWPxtneYgjihD1VI9JSRVXGJvFB4b0Bfm0d1ltEiyev+C+Gx6M/Bf4XKFSMz8w8dyKq5IhPaaFZy/tYN2JQ8Poe/iMrw8CukagJ5S2809q+Xv/uu1cqrIEehmRzQrQG8kEwd2V7bulfSf4ECBVZhbHJdcs6y1tbHk66HwO+xRv2uUSy1IZ6IpINI/mWFvA2O1oR/bcrYFpgDsihOJd04PA6TSbdGnGm/Ft0D1Y7JQNNheiX12ceAt9xRGwWbecLKmeNSTuDdzOpSCjZQUGeu2+4RVThjd+rvayCmlCKIj3Oq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85iJXb5pDielMRledepkWrJ9gz3vaT1B0kLuoZ+29pM=;
 b=j1qUuxbyUjE7ptgTAIxo6Mp+3FknxkA86LN1TAjRQobXmAXitYhlkWMAC8tUilNz3jUbTx+n82mDLWKrMjF0dZWGx/vHTIGYiGC7p9yqAToQad/GVZfpGL81p/ubuovvaqmecqgFvd3aWJcU+rf5W8nb8KYaLc2fnEjd5YbP0PsnhgKhsK8Cu7ZT1LXF0rmbOMUKCIx3OiBFKUniHqARi6jZRB1Uq0rNJ95sglqN9H3YQrrGhyh7YdOdo0SmdDbhuwhO9swVCazk+S2aqbr4F+bdLHukpsG7Clsdyixy52P06tbO1/deCDByVgNgwWwJ47UxnnrLyTSY7WvaYZEOJA==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TY5PR01MB402489.jpnprd01.prod.outlook.com (2603:1096:403:50f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:19:02 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:19:01 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: Re: [PATCH] drm/amdgpu: unwind module init on failure
Message-ID: <OS3PR01MB102517DF6327A5363B646BF38E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: "Alex Deucher" <alexander.deucher@amd.com>, 
 "=?utf-8?Q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>, 
 "Kent Russell" <kent.russell@amd.com>
In-Reply-To: <OS3PR01MB10251D938EF380DBD083891F5E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
References: <OS3PR01MB10251D938EF380DBD083891F5E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
Date: Tue, 10 Nov 2026 15:18:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0035.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::17) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID: <a777a671-56f0-4aae-bb59-c27a0c511dc6@milk.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TY5PR01MB402489:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f6c14e-25ee-4459-afdc-08df3f3df2e6
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|15080799012|6090799003|8060799015|24121999003|22091999003|25031999004|5072599009|23021999003|51005399006|24021099003|55001999006|25010399006|440099028|3412199025|4302099013|1602099012|10035399007|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVEwRDFpWkZzK2dpUlhkOFVEOU8xcXVSSThlMGVac0ZsY3JIRDdRZFNVaVo2?=
 =?utf-8?B?VGdyTjlHbllRVCtZanZWMkt0TXhXUkcwVXViRmxhdlZmWWZBd0E2aGFqMnR6?=
 =?utf-8?B?MStCKy9HeHhTalBqMEZ4c3NyZ2sxUmpGeC92Z1MzS29rcjFoaDFLbTcrdDdl?=
 =?utf-8?B?dGNha0VEaUpCZ3ducEYzZU9IUk1WMk9NMmE2SG95TG4zb3RwWnJKeFd5U000?=
 =?utf-8?B?L1FDOHE2RmVpV0RmbS9OdW1iaXhsbmFZOTRUTlVwdFVZQ1Z5NDNtVzhmZVF6?=
 =?utf-8?B?RTFFUS8rdTNWaWVNdmNnNU1VZWMyOHcycTdmMGQyd2I4UkcwR0RUd2hlTkZz?=
 =?utf-8?B?K0FGa25tWHFlYWtSSGNhUEdLbDBkWTZ4a0dyVUpmajNYZjI1bzU4SWZ1NE9j?=
 =?utf-8?B?a0hTeWhmQy9mYUVOaERIMittaHVPWWM0Wm14dnBvWFRFeStVdXoxL01xdVdi?=
 =?utf-8?B?U0l4QmxsaGxlZzFyb2dROEgyWGttUks2KzlLWGZVUTZkUiszVWx2TDkwY3lT?=
 =?utf-8?B?TUR6bGdpMjR1Q0pCUkZiVVpSMzZuK2R2TC9CcmxUdmFxNzg4WUxhdk01eHRs?=
 =?utf-8?B?YitMSDJpSTU0c2dnZkRBNWcvOHAwREZYdlN4ZGdVSEJNL09LYmFkdnlKTlE3?=
 =?utf-8?B?NFFLRklYbk40U0liMnpKNUFtN2RlSmtaQjE2eE0vMENxTVd5c2gzbVAwUCt2?=
 =?utf-8?B?emw4VE5obStuTXlYYkFyQm9xQ1gvYmJPN1VEQjYxakM5c1dHMGpRWkZ5Kzhr?=
 =?utf-8?B?dnJENHEyNTAxODBkMjMrQS9oWUg2VkovdzZvYlp5OW1ZVkdBM1ZMN0lCTE9E?=
 =?utf-8?B?NHR2d2RHenFPempiYmlyNWdWUmI1eFdUeFJiMjVYbkxmc0JOZ25qSDEyT0p0?=
 =?utf-8?B?cjV5bFZTbEw3VFlOaUpwVk9LQ0hKclRXMWp6YUdEVmVseXNvU2NBV1B2TFNV?=
 =?utf-8?B?cXRFK2c3V2U4YldXU2Z2YkcrTzg1VVd6a2E2dmpQZ2pVdXlMYVdLb2Q2Q3dJ?=
 =?utf-8?B?UlN4S0dlTUQ5QkVWMzRYZFQrZk9RdHJ6SkFyeUFLcHpITnMyckRLSCtWNmNM?=
 =?utf-8?B?YXdNR3d6VDk1MEpHeDh6Rm5uRWN2WUVVTGVyeG5hanBNQndNdGJEazJ0eGNU?=
 =?utf-8?B?L081b3FzMy9LelBWcnN0NGFtZXlEdXRGMFNkL05FdDAwNnBMSWpGb0RGMzZD?=
 =?utf-8?B?Q3ErNnFYb3BzcXR5MklLbndqQXhWditwWFhzWW1zaDM2YjcwQkpwSnkwQjNC?=
 =?utf-8?B?NHBtaDVQTk1yNDRzalA0bklFSnZ2QTVVa1pXeXAvRXRWbGN3Z3Q5bFo4bkZN?=
 =?utf-8?B?YnU3dzJyUjlNQTdCUzhDN3FwRkM2eEhGbGM5VThNRDRFMkQ4a0JZMHc4NjNa?=
 =?utf-8?B?TVNFSkY1eVE3YXkvRGxVdUFVZXdtWjdwMnpScUVxeDAzbVdid0hXM0duUmVK?=
 =?utf-8?B?RmxzeDdrR3lFN04yYVBEai9TSzFyVlN3ZExJUGFwMC9ScW9pSGtIdVNvM0Nr?=
 =?utf-8?Q?FZ2R47BGueUtTtkTEejxHOrg+xk?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHdxelZNMUFQWUVwYVhhZEJseFJmRmw1MFhncmNQbkYxYmZBL3lpSEozK2N4?=
 =?utf-8?B?ZlJMYTErM2I1TTI0Rm1YOVhSUlJ6SVpOcjVzeFlXZDlURHJDWnk1UjJGbmNS?=
 =?utf-8?B?a0dkS1FzbWVoenBIQzhqVjE4eW9rWHFESkd5TTN5Vis2WkNFOXNPZHVQd1J1?=
 =?utf-8?B?TjBGYm1OT2hxZEhZQUR4MHJ5WEFTMFR4VmgwWHBZaUJOSmpsYnlCeFhJbFRl?=
 =?utf-8?B?ZEl3ZlJOaVQ3VWdSUWlHQ2hhdTlBTDlFaldDeVZvdnJpTnpKcGdMZVlHV3d2?=
 =?utf-8?B?MzJrMG8xUmRmVlRUM1cwb1FiaWREd2JkQ0VMcVNYNjJkemEvanowNEM3STZB?=
 =?utf-8?B?Q2FOVEJuYjhwMTZlVERwVnJsRkFid2VtOGxpSFh4TFY2cFkxcTAvenZPYnFx?=
 =?utf-8?B?ZnByKzluOWYxMnpTRTk5NlJENHk3Qmw0UUxLdmJ6dGs3VkxkU2N1WlVsMG5l?=
 =?utf-8?B?NmF2SURSMHQyY0M1OWpuQnlFV1hGeWloNjBmaGFodnhiYmJ1R2RPb04xSWxN?=
 =?utf-8?B?NFoxMHdiSVBXRWdvZjBsZVhXbnViMWkxeWV0STFIRDhoVWF0aHh1UXFXV3JZ?=
 =?utf-8?B?ZjNNNEVtT2FiS2NJK1lUaDViais5QWt1WGlERno5WEp3QjNEVTRZL1I4Q25U?=
 =?utf-8?B?NUZHbXM0RFVETGMxbldRQlZFUGJUMnBnMlNrUXpHZ2JYUU12dE1lRTFRMDlX?=
 =?utf-8?B?YVhqbDhYNk1kWHp2bW1PZzFKenZrT2k2aHJITktuTUpON0lVaWlLdXFwQndh?=
 =?utf-8?B?ZXFCaElmY2wxYTNsYVJIaEV2cGphQ3dhMU1CeWlMRlF2TGFPNC9seDlnUnJT?=
 =?utf-8?B?aDFxRXNIc1hyVUREZWJsWjgra1ZJVGttYVVkZTRDYWxibHRJOEFIWll2N2Ev?=
 =?utf-8?B?SWNpM0pKVEMwbTlpc2lpaGdoWWpFM29wS0JwWE5yLzU2Q3BhYVlXeWk2cGFQ?=
 =?utf-8?B?L1pnNkxSVUNXVUt5V1VValN0MTVkOGxyZzBHK0dtNXpYbk9nZU9DYUY0TEh2?=
 =?utf-8?B?dCtqaGJaUWtnVWJSSjNrbmJnQ1hSRm4xN2Q2RHZHVGtxOUpsNEtjdlR1b2I4?=
 =?utf-8?B?Nmg2c3QxSHU0dFFWdTNyZzZIaExxTXZQRnlPd1ByQjRRMlJCV3ExbE5PNm1y?=
 =?utf-8?B?VjZYbElzVEJaVmR0WWZaeFNibTZURldkdXpIdXJuNks2ZWdqSVJnbE5GMlF0?=
 =?utf-8?B?bzRlelRlUXhMRHdnZ2gydnIvak5OajBNek9tQzdkcmpOV29tekUrWGNhdFpz?=
 =?utf-8?B?bUI1R25DSU4xQTBBbDE2ODhLcFYwUGZDODR5QTFLQXJCUU9IN1VTSE1hSS9n?=
 =?utf-8?B?eXZ5V2pCVVEyalBkdmRlSG0vekgya3ZtQ0MwVmRyWXpxdVZ3NWV5c1lUV25T?=
 =?utf-8?B?dVJIY05yOUxIM214V2ZYMkZMOVVxZWgveG02QnZsemVRT1pGa1JOMlE2R3FK?=
 =?utf-8?B?bjNwUk5PM25NOXZXZ3RaN2k2V1EzYnBjb2cyVHdjOThWVHIrRTduQzR1aE5m?=
 =?utf-8?B?Wmc0ckhFRWZYVEkyMm1rZzVpUjJQRzNOS3d0Vk5ZaU5NU1RWZ1Vwc1IvRlhL?=
 =?utf-8?B?Z05IQkhZSndlaFFPN01XRGFxWmFYRUhnMThMTWFIRGJvUkdiWmlDSFI4L0RD?=
 =?utf-8?B?MFZPV2dib3J5anVzZmJ0M21wMXpNTG9tQ0czZTcvbExmUU1IWWhEenM1c3dF?=
 =?utf-8?B?VGRSK1EyNlg5MGZCWXUrV2hHYUdJWnJEVVlCa3k2ZU5ITVNxNEJWUVYzWGcv?=
 =?utf-8?B?ZFZ2cjZvc2doQU83WVRjZStQMzYyNi9Rb2NadGVqenlxSC9GWXIxaEVSK0ZD?=
 =?utf-8?B?TitzRVNiT2hPQ3o3TXk0UFhtaUZIeUtjaGQ3bjNaQUdIeTZndHlMVUNCYjNY?=
 =?utf-8?Q?VFZn3Dfdsk5cy?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f6c14e-25ee-4459-afdc-08df3f3df2e6
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:19:01.7558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB402489
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Superseded by v2:
https://lists.freedesktop.org/archives/amd-gfx/2026-November/157096.html

