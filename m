Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298BAC2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 17:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B782610E932;
	Thu, 15 May 2025 17:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LyOCd+nd";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2FA810E932
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 17:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHs0tIAAUluBy7waVrd1nRDMuoTIcDsav9rf+8d+f5PwJzyew9qwYvoGMo7vNVgpbSvdDDLq896xBfvY+5bCTu8X4hqHNy+HRejlGoZcgtwrpkO+g1s9NT4Wfan4AJcrlDKCapgcRrzHoqqzBvuDpFniKYvpwPqoAfl2u3cIG+8hbV8e1zyFnATFQfFju92gzWPrYt3e9gAfyH6k+raMG5SzxSCwvvtZkmnQogtIyN8Ph4USn4yVUGns3cJDSEnkwZzr6+wvG62pks9DXblAfgBZaY/8E2oAZOyeavwRcWsszxSYVS+qIDWNhzyLyhks714SPuMrNh9OTK4r+gYfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF+m0MAEnc62bNOOs1DsxYRojlht7f2J1fr4VObAeeY=;
 b=PsK+TLyE97ZmC4TWeULChg7+BGf8EpA4xsrKbDB4ipa+mRa4qAn2lUSu4nSgKYqg83msssGMKteQdXScukMzD1eajBnJzB+vFBwQYQWoEoHWGy1tjCPBWtnNcUSS0uN1qcAaQaXtbgES5SxpRGCIpyY7+8m5m7IvsPl9NxfLXw1Z14FqHv+FqTVwGlq49spGmRoucftqdK8DcbiJkoF/br1kLl3v513rllzcIjyZ/huw6hnBMwU5lXA82yEuISMKxm5D7mtcG/p/ZKtp6xIJExHeZ6J0wjOv9t4ttwqOgO+dXtrvgto9Z9EsQH3o+3XRt16w7cSm6toabkx23eHbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF+m0MAEnc62bNOOs1DsxYRojlht7f2J1fr4VObAeeY=;
 b=LyOCd+nd8LykPyyvzViEJ/d6KZZ69tbB22uSogiuraSecxfO/wzrthTxPApeJGBj57lbc3kzAwDml7T76w2sv7VM3JBm4C3WkyAFux5IWqKfRpqrsM7C40+pDysIpvRrCwn/rPS7XONj6ySl8ojXOq0h2PX8tsX5iec4QdJQwtU=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 17:49:23 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 17:49:23 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH v2 5/9] drm/amdgpu: read back register after written
Thread-Topic: [PATCH v2 5/9] drm/amdgpu: read back register after written
Thread-Index: AQHbxbgw2jXKOZN71UeqQmjN+FI4vrPT8SQggAABYoCAAAUngA==
Date: Thu, 15 May 2025 17:49:23 +0000
Message-ID: <SJ1PR12MB61945539EEEEDAEB8753E7949590A@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20250515164102.808954-1-David.Wu3@amd.com>
 <20250515164102.808954-5-David.Wu3@amd.com>
 <SJ1PR12MB61945DCC12B15B2F29F079079590A@SJ1PR12MB6194.namprd12.prod.outlook.com>
 <60bff45d-fca4-456c-984b-a09eaf081a86@amd.com>
In-Reply-To: <60bff45d-fca4-456c-984b-a09eaf081a86@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d0e2ae99-9420-41e8-bf30-97c1df7d6717;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-15T17:48:25Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|DS0PR12MB8453:EE_
x-ms-office365-filtering-correlation-id: 17213822-faed-4b27-a4a9-08dd93d8d40c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?R2d4dDJQSkF3SGNCMXIvbjJrcGl0dGRnS0drTFRXUC9vd2k2VHIwL1dieU0z?=
 =?utf-8?B?anNTUExMOXZ2TXFvOEtIK2Y4dUhHNDVoOVlkUWE2cXRrb2JYbWl4VzFjNXJ1?=
 =?utf-8?B?anJqQU8wRkRwY3dMNjRnUkRrMVNHeHMvenNFUm9ITGg5UW5DS0x5UzJXeHMr?=
 =?utf-8?B?NnZ4VzMzWFZQTitXaU5MYXJ1V29hODNoR1h0cmxCOTB0YUlOR2t1amh1TmVj?=
 =?utf-8?B?OFMzc2hIbFFyeFlrajRpbHpLSEw5WU95RktLWWhCSzUxbDdzQ3hUdVlvd2Jh?=
 =?utf-8?B?d2RYeDl1NVJQT2VQUW01b0djNmN4U0JKN2ZFK1MxY2lmNVNqV2NRSFYwWUg1?=
 =?utf-8?B?WW1RbStrZGswTStYRG9VMSswRTJTRHlST2paY3FXZnUxT012eFRadFNlNWpN?=
 =?utf-8?B?bVZKeUVGalo1SDNhRjdDWEREOWN3cTgyN0x5S0UxSVVyMDF3QndRUFRUcTJM?=
 =?utf-8?B?SjhIcHJFeFNGRmhxbnRpbDVHOEdyMGIzK1R3eEFvVFVJamt2V1NEdVdHUER2?=
 =?utf-8?B?QUpkVFR3THI3SkxlNWI0cVlGSnFiKy9JdnRxNVdkQktnUFpyVjRyenZBdzlI?=
 =?utf-8?B?UDJwcnVsU2hQOUM3enM0OUFFRGo0WCtKWldFWThhN3d6TDl2ZHhQRS9nMjFu?=
 =?utf-8?B?Q2d6dWF5SDVteVNqN1NmbXIxZTdFMnhSM1FVa3IzNUl0MGwyM1oybUZuaDlK?=
 =?utf-8?B?bk9kbFhEM1pacm95VEJKTGlwMklHN0dlMVdwYmhpRitPbEpYczVuOGRDMGVn?=
 =?utf-8?B?MVZXRThFYjlORVJmUEFzbld1SnErTjRVdlRyT0x6OXdqa3BRY2tuMEV3Vk1W?=
 =?utf-8?B?QUZHRVpoRDNZb1kxclo1dGRYYzR5YnZaNVVpbUxmQjVIVkNYZkVsa0QzazAv?=
 =?utf-8?B?aWdKdlFEUS95bWlnbXNDa2pHMTVqcytId1hDQVVST0VqalU0aHpPenlWYWNv?=
 =?utf-8?B?Y1ZXMWZXRWxEdFZabWFNQjNUaS9yNzRxSTEreFV0dUdiVFBIMHkweUkrb0Fp?=
 =?utf-8?B?VzNXZ2ZKcHRFRkdTeHBxVzluQjJCYlRmMExKWHZJRTlVYzFlRlkyb0k4R201?=
 =?utf-8?B?c2paM21sT0tvMWlPMDJ4Y2EzWFUyY09FZ2JMM2NRbXNFMTlKS1ZEaG04V25B?=
 =?utf-8?B?bGdiTWMrb2RFZUdXQ3pqai9Fc25QbGYwK010OXlUNzQ3S3VPeURRbG1RRHJR?=
 =?utf-8?B?a2EwNFhnbkZpeEw3RXdvNklrYmRZbjNkV0VYMzhDeFdHSUFic3M5QXloZXdn?=
 =?utf-8?B?Ni9VanpKNk50SUk5QkE2K0lRcHNPYkJ1VFRzYk8vbURPcnVia3Q3YWw3VFZN?=
 =?utf-8?B?VVZwWHlIRGs2emJZV0c1cnJBNlBZK2ZXb3NlMlhTb25IL0dKZERzcXo3S2E2?=
 =?utf-8?B?b1FWWUFqMVlVa1VLTWoyNnpWV0xNakluSjFBSTk1MGlkL2xMV3ZMVENzMzBy?=
 =?utf-8?B?VFFKcktWaWZuSi9mUHV5UVYvRVgveVBrVFYrWHBjcW51Z3NJVzBOdVU3Q1Vh?=
 =?utf-8?B?RDlsU1doUERxVnpJemd6R3JFSGk0VHFWbmxrMnFPL2czdHYzMG03b0l5ZzRy?=
 =?utf-8?B?Um5jK1YraXZvM0doWUdQdnpKNjVHNnRaYVJiOENpTWFjVEpKbkwxaUVnMitv?=
 =?utf-8?B?cGVCNEhFNEJYczRjWDl0NzVUeHgvdThTZGhicVhpNWw3bDFYL3hha3lqUUth?=
 =?utf-8?B?UE9zdzRNVEJydTkrZDFYK0FkL1lsUFdQNUk2ZVF1d2VYVzlhSERTQllSRytu?=
 =?utf-8?B?VGJyc1hZNkdMNFI0bXdldkhxeGZ1djlwQit4OUdkb0E1M3lRM2FuVGMvVmd0?=
 =?utf-8?B?VnhUZS9wa2p0WnVmLzNjV0JiUFRzU2ZqeHY2UUtHTmZ3aWMxOEdFWXdQQ20r?=
 =?utf-8?B?MFRnZDZKRzViSU9ueXNNR05Ic2piUUFXVWdDeHoybUxEZnZteTRKajRjdGgv?=
 =?utf-8?B?ckpTMjVsbEVCS3V1TGZFV2ZqM2xIOGMvc2JtY3ZsYkRBaVpJVG12cU1pRDda?=
 =?utf-8?B?am5POEd2VHZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eW9QUi85SzhEU0FqbU5lZFhFYXZYOGk0bFA2LzF2eWZCenRVMmQvR2VMZUJU?=
 =?utf-8?B?NWR6Wk9qaWlVV0kvS094eDRzYXEzR2pVdXFEbG1qSUJpY3dwVmk4enhjeDdM?=
 =?utf-8?B?Y0VCWGFQbE9TazRreVVvT21nQlF1a3BwakxCaDNJWmhsY1ZaeDVXdlVWams3?=
 =?utf-8?B?QjhBcTV5ZHN2YWFzOExZdUd5NEcrcDJ4R1ZyZlRpZkt1bERMM1ExaUVQQWtz?=
 =?utf-8?B?cE02Y1Q5YTcrQXoremt0SnZMdzN0a3didGlIc0ZSNTlqN0NFb0MyMjNzcmlO?=
 =?utf-8?B?UGh2V21XWU1xZEtxdi9ZRTZlM3pQY2EwV0w4N29scHdWSnpNeng0VGhhWEJj?=
 =?utf-8?B?UmdQZzN1VUlQSU93aUgrRFFtc2RncDJtOXlPVHB1SlVsUnI1RFMydkNwaWs2?=
 =?utf-8?B?ZnduZWRuZy94OURYb0lJRUpKMW5pM1NHVU5QRzhNelZoNGVwZGZrQXJ5NWUz?=
 =?utf-8?B?NC9yc2xQWG1rbVFaVS9rS0RSUTIxSEZlbUh1YVV6MXRGVFRnWkxuRjRTUWZH?=
 =?utf-8?B?dGFKcTN2cFJVckhZWVdMVXRaZ1YxWi9tNEY5UGhvUWhsZnJ3RUxqVkZ0cEpr?=
 =?utf-8?B?dU95emhTYlgxQmNPUnc2T2k0RnpBU3Q3SzBpRkI3NHBsL3Z4YjVodlRmUGx2?=
 =?utf-8?B?SFp4aElZNTNPZzFKY2lkWHFERGlJTUJzdXBFODBlNDZEU0QzdUt6MVEzeEZ5?=
 =?utf-8?B?cXNuSHQxSXI4dEEzK3JUUWtpUFZja3JMRFJJZWlHVFY4MVgxd01DODdWck5h?=
 =?utf-8?B?eUhTc2ZlQ3gyY054SVI3bXNrT2pkU2RYbkhqV2NsMFpmcEZFbUZyR2NnQzVY?=
 =?utf-8?B?TWpJODRTc29EUXNWRnZ2S3dKL1l6bnpKUi9OaHpMSHBUSzVjODlMek9QYXQz?=
 =?utf-8?B?RWZYdWNmbTJJWkoreGZqblB0aTRuNkxUN3NHRWhaY0RLb2JKTmgwb2RmVzVv?=
 =?utf-8?B?VU1vdW9pbGk0WmNKZ0ZLUGYya0NSb2RFWGxkVitNL3FmeDZqTFFZRzJqZXBI?=
 =?utf-8?B?NktDbk8wZTJyWS8rQWwzZkpMSHFNTXQ4Ky9qZXEwbG1vdDd5ZUJ6TnFMd0lT?=
 =?utf-8?B?WWQxVkZCM05wblRjeWhEMHU0VUdsMXB3cmJkaHQzb0I5QjgvTklmWkM0R1k5?=
 =?utf-8?B?Mk9YMWtDRkkwcW5UTFNuSHBDOUhVSWNhVEJiTENCbkQreEl4NFFBNkNsZVVz?=
 =?utf-8?B?T0gyRy94YjY0bmdDcU9CS1lWZC9UMFF4YUdtYjljQ2VWdkZPVENMR3ErMkhD?=
 =?utf-8?B?RncwdllVQ2xuZzZ6QlBxeE85WTJ3ZVdzS3c4TlpWQ2JnUnFZeDZDa2E2M3Zk?=
 =?utf-8?B?M2llUEdhSm9OUHNQbEdpVDRrVjNvL0J4Y3hJdTJZSk0yTXprOEd3QWZTaXN5?=
 =?utf-8?B?WmhMdXM4YkJMdG9KcHJBQm1hendidkpBL0F3K2JqNlVKaUpMZHA1V0VtVnpB?=
 =?utf-8?B?MUJudXJ6elB3OUVTMElMME41M0d0cmF0SVAwaW5rdi85Z3BiKzZsUWVJSUNH?=
 =?utf-8?B?OUoxRlF1THp3eGJiM3JRc0hJQVpVREdWakdYWGtGMkhBTUhUZVM5b3BEYTNy?=
 =?utf-8?B?SjhyMy9hMnNLaTErUUNneWdrcUF1QnVKVTRiMDlZOUR1eURJNHlUSWNEdFFw?=
 =?utf-8?B?STNKeDhXL1k0TWQvdGFVZXVqUE04WGt3QkYwQTRPRmQ1YWhpZ1ZET2dEYU9i?=
 =?utf-8?B?MU16Z29mREp0RmtNKzZkTEhXWUROYUs3M2laMnhvdTJlWC90OHJiL29Ceng2?=
 =?utf-8?B?OFlRYVdzdkprY1cveStCazBJV3hmRGpqbjZaRm5kOGx0Rm5RZE1yUTJMNHFx?=
 =?utf-8?B?VFRjM1F2a0FZb2Ewa2QrbXJseUxyRGxxZ2ZCQkxsQ3RuS3o5Z2hPOVhESmRQ?=
 =?utf-8?B?NHJ0bW9sTnYxRjJiQU1iWFh1bkIxYm15NXJzUGZNbHkzTjluM1VySGtFK3V5?=
 =?utf-8?B?d1B1K0ZjOG0xZ2VIb2J2WjlLVS9meUNvSFFzYXRMOHBGTVBNaXNvZU85ZDNZ?=
 =?utf-8?B?azFRb0E1MHp1Q3NoemxVdFVXMy9NYjZQaDZYVFhDR3FySGtDUXROQTNpYmRS?=
 =?utf-8?B?QWlML3RQSTRRaWs3OE9jVW1zdTBpUnVWbE5rUXF5eGFvWmxDc0VUamtUeTk5?=
 =?utf-8?Q?6LiI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17213822-faed-4b27-a4a9-08dd93d8d40c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 17:49:23.6268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MprWfVEsJndbYdHD7Hi9DlhZWE5hgXID0JGN6tkuzvXraf0NKATv18JYJbMrrU9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
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
Cg0KV2l0aCB0aGUgY2hhbmdlLA0KDQpUaGUgc2VyaWVzIGlzDQpSZXZpZXdlZC1ieTogUnVpamlu
ZyBEb25nIDxydWlqaW5nLmRvbmdAYW1kLmNvbT4NCg0KVGhhbmtzLA0KUnVpamluZw0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogV3UsIERhdmlkIDxEYXZpZC5XdTNAYW1kLmNv
bT4NClNlbnQ6IFRodXJzZGF5LCBNYXkgMTUsIDIwMjUgMTozMCBQTQ0KVG86IERvbmcsIFJ1aWpp
bmcgPFJ1aWppbmcuRG9uZ0BhbWQuY29tPjsgV3UsIERhdmlkIDxEYXZpZC5XdTNAYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPg0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT47IExpdSwgTGVvIDxMZW8uTGl1QGFtZC5jb20+OyBKaWFuZywgU29ubnkg
PFNvbm55LkppYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYyIDUvOV0gZHJtL2Ft
ZGdwdTogcmVhZCBiYWNrIHJlZ2lzdGVyIGFmdGVyIHdyaXR0ZW4NCg0KDQpPbiAyMDI1LTA1LTE1
IDEzOjI1LCBEb25nLCBSdWlqaW5nIHdyb3RlOg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0g
QU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBXdSwgRGF2aWQgPERhdmlkLld1M0BhbWQuY29tPg0KPiBTZW50OiBU
aHVyc2RheSwgTWF5IDE1LCAyMDI1IDEyOjQxIFBNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4N
Cj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExp
dSwgTGVvIDxMZW8uTGl1QGFtZC5jb20+OyBKaWFuZywgU29ubnkgPFNvbm55LkppYW5nQGFtZC5j
b20+OyBEb25nLCBSdWlqaW5nIDxSdWlqaW5nLkRvbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIHYyIDUvOV0gZHJtL2FtZGdwdTogcmVhZCBiYWNrIHJlZ2lzdGVyIGFmdGVyIHdyaXR0ZW4N
Cj4NCj4gVGhlIGFkZGl0aW9uIG9mIHJlZ2lzdGVyIHJlYWQtYmFjayBpbiBWQ04gdjQuMC4wIGlz
IGludGVuZGVkIHRvIHByZXZlbnQgcG90ZW50aWFsIHJhY2UgY29uZGl0aW9ucy4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogRGF2aWQgKE1pbmcgUWlhbmcpIFd1IDxEYXZpZC5XdTNAYW1kLmNvbT4NCj4g
LS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y0XzAuYyB8IDIwICsrKysr
KysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjRfMC5jDQo+IGluZGV4IDhmZmY0NzBiY2U4
Ny4uNWFjZGY4ZmQ1YTYyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92Y25fdjRfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8w
LmMNCj4gQEAgLTExMjIsNiArMTEyMiwxMSBAQCBzdGF0aWMgaW50IHZjbl92NF8wX3N0YXJ0X2Rw
Z19tb2RlKHN0cnVjdCBhbWRncHVfdmNuX2luc3QgKnZpbnN0LCBib29sIGluZGlyZWN0KQ0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmluZy0+ZG9vcmJlbGxfaW5kZXggPDwgVkNOX1JCMV9E
Ql9DVFJMX19PRkZTRVRfX1NISUZUIHwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIFZDTl9S
QjFfREJfQ1RSTF9fRU5fTUFTSyk7DQo+DQo+ICsgICAgICAgLyogS2VlcGluZyBvbmUgcmVhZC1i
YWNrIHRvIGVuc3VyZSBhbGwgcmVnaXN0ZXIgd3JpdGVzIGFyZSBkb25lLA0KPiArICAgICAgICAq
IG90aGVyd2lzZSBpdCBtYXkgaW50cm9kdWNlIHJhY2UgY29uZGl0aW9ucy4NCj4gKyAgICAgICAg
Ki8NCj4gKyAgICAgICBSUkVHMzJfU09DMTUoVkNOLCBpbnN0X2lkeCwgcmVnVVZEX1JCX1dQVFIp
Ow0KPiArDQo+DQo+DQo+DQo+IFVzZSB0aGUgc2FtZSByZWdpc3RlciByZWdVVkRfU1RBVFVTPw0K
Z29vZCBjYXRjaCAtIEkgd2lsbCBjaGFuZ2UgdGhlbS4NCkRhdmlkDQo+DQo+DQo+ICAgICAgICAg
IHJldHVybiAwOw0KPiAgIH0NCj4NCj4gQEAgLTEzMDMsNiArMTMwOCwxMSBAQCBzdGF0aWMgaW50
IHZjbl92NF8wX3N0YXJ0KHN0cnVjdCBhbWRncHVfdmNuX2luc3QgKnZpbnN0KQ0KPiAgICAgICAg
ICBXUkVHMzJfU09DMTUoVkNOLCBpLCByZWdWQ05fUkJfRU5BQkxFLCB0bXApOw0KPiAgICAgICAg
ICBmd19zaGFyZWQtPnNxLnF1ZXVlX21vZGUgJj0gfihGV19RVUVVRV9SSU5HX1JFU0VUIHwgRldf
UVVFVUVfRFBHX0hPTERfT0ZGKTsNCj4NCj4gKyAgICAgICAvKiBLZWVwaW5nIG9uZSByZWFkLWJh
Y2sgdG8gZW5zdXJlIGFsbCByZWdpc3RlciB3cml0ZXMgYXJlIGRvbmUsDQo+ICsgICAgICAgICog
b3RoZXJ3aXNlIGl0IG1heSBpbnRyb2R1Y2UgcmFjZSBjb25kaXRpb25zLg0KPiArICAgICAgICAq
Lw0KPiArICAgICAgIFJSRUczMl9TT0MxNShWQ04sIGksIHJlZ1VWRF9SQl9XUFRSKTsNCj4gKw0K
PiAgICAgICAgICByZXR1cm4gMDsNCj4gICB9DQo+DQo+IEBAIC0xNTgzLDYgKzE1OTMsMTEgQEAg
c3RhdGljIHZvaWQgdmNuX3Y0XzBfc3RvcF9kcGdfbW9kZShzdHJ1Y3QgYW1kZ3B1X3Zjbl9pbnN0
ICp2aW5zdCkNCj4gICAgICAgICAgLyogZGlzYWJsZSBkeW5hbWljIHBvd2VyIGdhdGluZyBtb2Rl
ICovDQo+ICAgICAgICAgIFdSRUczMl9QKFNPQzE1X1JFR19PRkZTRVQoVkNOLCBpbnN0X2lkeCwg
cmVnVVZEX1BPV0VSX1NUQVRVUyksIDAsDQo+ICAgICAgICAgICAgICAgICAgflVWRF9QT1dFUl9T
VEFUVVNfX1VWRF9QR19NT0RFX01BU0spOw0KPiArDQo+ICsgICAgICAgLyogS2VlcGluZyBvbmUg
cmVhZC1iYWNrIHRvIGVuc3VyZSBhbGwgcmVnaXN0ZXIgd3JpdGVzIGFyZSBkb25lLA0KPiArICAg
ICAgICAqIG90aGVyd2lzZSBpdCBtYXkgaW50cm9kdWNlIHJhY2UgY29uZGl0aW9ucy4NCj4gKyAg
ICAgICAgKi8NCj4gKyAgICAgICBSUkVHMzJfU09DMTUoVkNOLCBpbnN0X2lkeCwgcmVnVVZEX1NU
QVRVUyk7DQo+ICAgfQ0KPg0KPiAgIC8qKg0KPiBAQCAtMTY2Niw2ICsxNjgxLDExIEBAIHN0YXRp
YyBpbnQgdmNuX3Y0XzBfc3RvcChzdHJ1Y3QgYW1kZ3B1X3Zjbl9pbnN0ICp2aW5zdCkNCj4gICAg
ICAgICAgLyogZW5hYmxlIFZDTiBwb3dlciBnYXRpbmcgKi8NCj4gICAgICAgICAgdmNuX3Y0XzBf
ZW5hYmxlX3N0YXRpY19wb3dlcl9nYXRpbmcodmluc3QpOw0KPg0KPiArICAgICAgIC8qIEtlZXBp
bmcgb25lIHJlYWQtYmFjayB0byBlbnN1cmUgYWxsIHJlZ2lzdGVyIHdyaXRlcyBhcmUgZG9uZSwN
Cj4gKyAgICAgICAgKiBvdGhlcndpc2UgaXQgbWF5IGludHJvZHVjZSByYWNlIGNvbmRpdGlvbnMu
DQo+ICsgICAgICAgICovDQo+ICsgICAgICAgUlJFRzMyX1NPQzE1KFZDTiwgaSwgcmVnVVZEX1NU
QVRVUyk7DQo+ICsNCj4gICBkb25lOg0KPiAgICAgICAgICBpZiAoYWRldi0+cG0uZHBtX2VuYWJs
ZWQpDQo+ICAgICAgICAgICAgICAgICAgYW1kZ3B1X2RwbV9lbmFibGVfdmNuKGFkZXYsIGZhbHNl
LCBpKTsNCj4gLS0NCj4gMi40OS4wDQo+DQo=
