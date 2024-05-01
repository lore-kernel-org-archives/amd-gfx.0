Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A72C10F1A
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 18:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C771910E157;
	Wed,  1 May 2024 18:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1555JFXz";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1855F10E157
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 18:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ba+UroqyXJ8Dn8vqI3CUfhoziZ3GOnh4mi1PQtoyNxJW6naKznf2yup+Zj8oF4oseX80JJqS545Xqi//B0jE7vdo+HMZ5JnzwHnviNlKEEkRE0VJaQEIHBP36WBYPLJQ6EvBF4Dm6rF5XDrg0sJZXTHvAs5KKXV0NmguyppDvrKT4V0b1shay9Ql7yzCyNjJk1xGbUzTiWrXVgBHVDZpf6C/WdsXU6IwBxmuwv1eORHrkGILIGndNhB9hNY1TufDj0ORVd8HX2JgL4LQdfaDCwdhOBmqKi2Dtr5dsAgNRiMwYv5bRLbOGYl0m7bdUYbCRAJuifNcQYZ5MQSjyW8aYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vkh8iofLNBxqyeE1mbMHTyxeAeNPrFQZQKQWbXMx+Co=;
 b=jT/jpSQqDUncGh4bnyUjO9a9rWwGXH65mC19I7vvBKvUqKm9odzFJrLQuID43nR7tLp3ISmOxnoL+ORLP/lWlddSiPr6AIW1ls2/2401MevOapQdJtKeTOuaQIBAMRIjHPZU8d6lGdgp1o0XITeNLS409p+hO7S5jTQtPzdZONqdMj1DELjyC5qDnHr2puPCgPJx0P+EiONTUxq/umaZWQ39X7V59qenuZsBNc2It7518pM0moAO4jp7Fbi/ejajWiL9cIM8NIhsZaqFS0JH6aNSWwJEDzydSSfnrvSgjpds8jElPhbrDQoYj93MixHuxTe54ychcA6xdKTdduxYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vkh8iofLNBxqyeE1mbMHTyxeAeNPrFQZQKQWbXMx+Co=;
 b=1555JFXzzayH1zmthHln3LLCLBW0vOPz2j7CYXWjaTDYoGkRXda2Fmj5kAqzpj1BhZv/QRZ1+Wv5grdKOmrF7a8+QJsfa6eOzzMaRX1zdt/eAAnMJa12IDfQTv7fEJB/45xZlZyL17XcBT3L/DBSJAFxNv9On5mPcWk2C6e1lAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 18:22:57 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f3cf:148e:3827:8035]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f3cf:148e:3827:8035%7]) with mapi id 15.20.7544.029; Wed, 1 May 2024
 18:22:56 +0000
Message-ID: <4e9a12f0-deb9-c148-5892-757ee7a1b89d@amd.com>
Date: Wed, 1 May 2024 14:22:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/amdkfd: Fix a resource leak in
 svm_range_validate_and_map()
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240430232901.2878169-1-Ramesh.Errabolu@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240430232901.2878169-1-Ramesh.Errabolu@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::19) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: fbeed165-0e80-45cf-456e-08dc6a0bb95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFYvSGVNdXFRa2Ivb0FWR1l0bEd5WUxmak1aeDA1WUJkeXgxRTMzNjVFRVk0?=
 =?utf-8?B?R2pyS3VrbFk2aXJHVHQyNnVyREx5SmIyT003RGUybVlmSjM5WW42aWdOMFRG?=
 =?utf-8?B?dDhBeHA4alcwRVJvSklnejNHTlpIVWd4WHA5TTBUWUgzc3p4S1NaVmJmUXNs?=
 =?utf-8?B?YnJmbVlqWDRhM2NTNDFuekgvRXBYYndBOGZaQzNmMWpRcFYwa3ZNbUplQVpH?=
 =?utf-8?B?SUFyOXo4ZjRqK0hVZW1tbmNiM2FEWGVjdU5EZDNPRUN1dFFoSWltclBoUHpj?=
 =?utf-8?B?a2oreW1HMWxnMEsrU1ltcHVFNGZrQUttVkYyenIxcmJEYlR0VHlxNy9tVGw3?=
 =?utf-8?B?Q3MxVDJNZ1ZqeGJDLzN1dFZ6ZzNZdEpXWHFEbjRoUVdwT1FoYnMwcEN1MXJu?=
 =?utf-8?B?cTNtM2NxSUNhUWNsd2tvNEc2N0s2M1Y5RkxLUGo1WHd0eEppaGlJSGFZUVZJ?=
 =?utf-8?B?Um51SHdpQ2QyUWwvZHlBUGx0aGFxay8vZldsUHcyUlIzT0U5Yk9pVUpGYzVS?=
 =?utf-8?B?blpqNlZ5WXFOakNJZjg3UnNnT3J3SWpoMVpvZUlXc1ZwYzBzNkx0czRmRkNy?=
 =?utf-8?B?MEpBaUZkZlovcitZQWc1V0h0TVlVTThWZytoeGljSHhZcTVYRk5UbVBRdUpo?=
 =?utf-8?B?dDBpT0hxRWVvQWduU1FaQzFNTHlDaWpUNmRrSEhWNkwrQzZyK1RiSUdtdVpU?=
 =?utf-8?B?cUthT0FmMDd1TzJRc3VaNlRsSjVGMVUyTmYrMW5WeERGWDV0cmVYWlVVcENR?=
 =?utf-8?B?cUF3K1A4RmJGQUpjRHkxOWREVUtBQkkvbDJlU3J5eDc1NU1xR2s5MWVMZVZI?=
 =?utf-8?B?cG5icjZGdi9QVDJ2UkxidFdOazJ6NUhwVW5pY2tLdnJwdGV3UWdYQzVXRTZG?=
 =?utf-8?B?VEpmNnErZ0t5TkxzeUFKMXo1SXBnRUNMWXJjVXYxcmZBL1c2YStTSjNQRVJ3?=
 =?utf-8?B?QlF2cTIxQlVGRHhEL3krZzd2eVkvMEdDODZaQS93cjBnTnJZdVBOVFRDalhv?=
 =?utf-8?B?bzlNaCt3b3MxSU5XR2RrNklMTnIzU2VVTXg2U0ROYzhTa0VlWHRmQjFGVE5h?=
 =?utf-8?B?RllvSlp2ZEE3NnBzNks4MWJXbS9adjRjQ0pDeVZDc1JxWWttcmpwckJlUGUv?=
 =?utf-8?B?ejNUZW5NdnlzWjNpMC9OaFo4Z1JOWFliUm5qbXJWWG9JSy9BSDExUWFqRERK?=
 =?utf-8?B?UENIMDRZV1BYdW9YdDEyQUJzeDdxSGVEbUREeW1ibm5ZdGNQQWhzMW4xdGhG?=
 =?utf-8?B?RDdjZzZxYXFTd1lxWjVtSlVuYlU0WGlTTWlOL25KbklJWjIvRjV6QUZnSzJn?=
 =?utf-8?B?VGdkZzFYS0ltVUp0Q3RXOUx5cEVQRjk5TWxXbWtZT29qY29kYzEzWktQNEkx?=
 =?utf-8?B?bEVlajNIZEtsTHAxWTBtakQwall2QWNER1RxMzFQVWFxcmx6OExwQm91cHBO?=
 =?utf-8?B?ZldBM2QzaUNlRTJBaDZRYkVIaWpTWnR2ajM2b08vMXNNNStjblUrMjBJMXVU?=
 =?utf-8?B?YUFoM0NZL3krQlJGMkVjRklkWGViM3lHbVpuQUZEemQxNUJQQnRVcERjS2dq?=
 =?utf-8?B?QUdBL1dVd3ZBb3NMaUkyVDlpb2hMU3Q4c3R5V2kxRHFKSTZycWw1Y1lIRVJX?=
 =?utf-8?B?RWEyallONDY1N2tZb0lIbHFCczMxakR6YVNOeTIzUnYxZWozODUrM0pkRWZi?=
 =?utf-8?B?ckEwc05LTGpBWnpWbHgydmpUQktyaGEybW1aRjFzaGEwazg1bEhNZTRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3hrVEJjdUFkZG0xUkxWN3ZEY0hVZDd0RzZnNS9XUURRNGdKWndZdTUvdGdn?=
 =?utf-8?B?TWRDaXZvQ0sxREFTelhFZTk4TFNtMHNCYXB3ZWpTb0owd2RoUWNhdlNBeHpH?=
 =?utf-8?B?dDBsQ291QngrK0xaUEJrb1htWjNudWdONXUrajFIVjNLM0o3eXBxM3g2dVJZ?=
 =?utf-8?B?bi9WTGQ0OUljZlJQQkdabktQbkZObis0a2s2WGdPTHVkYnNGTjA5M3U1YXFx?=
 =?utf-8?B?bmNyajAwTlkwU0VkREQwVFRYT3Q1RlRvWDNTbUZYNHd1NXR3V0V5SDdBVExI?=
 =?utf-8?B?eWd4T0RDK2xNcStGN0tTTy9udllUNnpxTHMwVURWK1ZXRkFDQU9Uc0NJaUNU?=
 =?utf-8?B?dnQ0UUF6djFQZ1ZnVy9aWTZiVjVhd1pUcENIMDdkSUREMzhVQjV3MnhGdEgy?=
 =?utf-8?B?R1JEWFoxU3pPY2tnc2FaUS9QdlZ4OG9MWWFOV2ErYk5xZGVDTWkyN0NmU0tv?=
 =?utf-8?B?ZnNRN2RGTEJReGZqNGhXUUtxZlFkSGJrWWJtd2JmZkdtQlozWlVUM1Z4L25r?=
 =?utf-8?B?Q3lYTm9PSXVGeTVwUHVVWTFtMFFzMzRTb3VjKzBZakt2QjJUYTRJc0NIUmhL?=
 =?utf-8?B?OEJKcERLWHd3WStacVpRaTlxdGhKTHFzZWR2SXR0WGEzNEgybHBiNk9IUE1L?=
 =?utf-8?B?alFPWlBOUnR1YUVkRXFodE92cjFYVTQrcHc2dENwaTNReEU2RnB6MHl1MUhO?=
 =?utf-8?B?a1I5ci9zWWV2M1dWc29SWmVLQzlzZ1VwMndaZmFQeWthckF0YWRUSFR5Q2FO?=
 =?utf-8?B?cVNhSG1GTjRyL2JDMStqNHVBVkFNdFpka0xtSWpqdnoxckRVNDByck94WTdt?=
 =?utf-8?B?M1RhZEFDR0VNRUdQbHpSYUNNUjRvYnI1QmF1N2tVeitmajIvL2c3UmVFVldk?=
 =?utf-8?B?QmpENjY4TStDa2NDK0xpNGMvSVlWYkRVa3QrOCsza0VGbXduMWVTQWx0Zkow?=
 =?utf-8?B?MmxhUnF3aXpLNUNsSHlEOTJweUdLK3loRFhrOEQ2VlhkQzBoTEVRYW5KRHRu?=
 =?utf-8?B?MXNMSXpTd2JGTldQZDQ4VDROZTgyMTNDY2I5akFlUDVNYld0QkZWQmVBUVBU?=
 =?utf-8?B?RytHWTNsbjE4MS9BTTJjcXB0VExlRkdjbHlxUnlONVh2Z1licktNRXZYNUV6?=
 =?utf-8?B?UDJWUGhldk1xWURwbnFWNCtpWk5aRk1wQ04vQkZSOElFTmtyMXBua3JOTHVj?=
 =?utf-8?B?NlJjSzE2cm9vY0FXYVhyeCt4Tm8vN0EzSU0xRXZsMU1mZGQzVDBaSWZiaG1n?=
 =?utf-8?B?UWVvVVl6cnlPL0tIMndyaStmN0hpb1NnclRLVjFadGRzZWVOSmVuclpOdWZn?=
 =?utf-8?B?T0hHYlJlZVRuMDhPcFBsRVkxNXVVdmRoNzZGVXVIWTl1dDY4bmZSb2RrekQ5?=
 =?utf-8?B?VFJiYWIvK0haQWovd2l5RXZudjhBUWgwb2NpNzdvMmkybFFkelA4NW05Rjdq?=
 =?utf-8?B?YzY3eHVkeWFRd0NJT3RXVUZIZ01oZzVZMXRnQlF2bkFsZWgrUlQ3dWgvUWFs?=
 =?utf-8?B?aTBvSGZtdWprUWE2SFRXYjhMa3NUNVBMeXBKbTVMMjJoTEJLS2NmMVFjVDVl?=
 =?utf-8?B?c0VJUlJNNkhNVU1UU2xDRXp6V1JDVk5PZm5DMEw4MEMwZTNHUW1BS0lVbjYx?=
 =?utf-8?B?emk1d2ZKaituTHhWaXQ0bEl2ODdHbEdtdG1FcnhTeUxOMHo5ZmRtTkxUd0Vu?=
 =?utf-8?B?aHNPanlDVnh3Uy85ZUVSSjhsM0Z4NkE2S0tzSVpJL25GajhQWERsZ0Y4TXlm?=
 =?utf-8?B?cC9yUkordEMxV0J6dkJyMlg0NmNJL3NyMXNnbWhOYVJKeFZnQUJuK1NlbXpE?=
 =?utf-8?B?amtoSENlL0RmMSttOXhacUcxVnlUU1hiVDhoZUNNaU1ZSGFLSXRYV0pNSHlV?=
 =?utf-8?B?eEpGaUNJc3BnRVdSNldESVRyUEt0TklQK0JTN2cwRnordDV5UjNBbGprRVNw?=
 =?utf-8?B?LytqRWR2Nkd1T0JsZ3FXSnRpSzJadFQzVlFnTWlFcnVraVAyQXozREtMdXJL?=
 =?utf-8?B?UC9aNzBtdDgxMlJkN0hsR29EU1hnM1dCOENicld4WDVGVnF4V3Q4Nm1iZS80?=
 =?utf-8?B?cVB3dkxoQjVVaG54VHFxaUJ3MWVRV09FaWRuOXJSTmdnc2FRZDYyd1hZUVhT?=
 =?utf-8?Q?0Sio=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbeed165-0e80-45cf-456e-08dc6a0bb95e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 18:22:56.8339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnECFPMfSDoSPBG270jmlhJJ++H5GmQLPW4JMBLzUIxT6F5GTQH76CiMmDubhX5C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-04-30 19:29, Ramesh Errabolu
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240430232901.2878169-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">Analysis of code by Coverity, a static code analyser, has identified
a resource leak in the symbol hmm_range. This leak occurs when one of
the prior steps before it is released encounters an error.

Signed-off-by: Ramesh Errabolu <a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com">&lt;Ramesh.Errabolu@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20240430232901.2878169-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 386875e6eb96..dcb1d5d3f860 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1658,7 +1658,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	start = map_start &lt;&lt; PAGE_SHIFT;
 	end = (map_last + 1) &lt;&lt; PAGE_SHIFT;
 	for (addr = start; !r &amp;&amp; addr &lt; end; ) {
-		struct hmm_range *hmm_range;
+		struct hmm_range *hmm_range = NULL;
 		unsigned long map_start_vma;
 		unsigned long map_last_vma;
 		struct vm_area_struct *vma;
@@ -1696,7 +1696,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		svm_range_lock(prange);
-		if (!r &amp;&amp; amdgpu_hmm_range_get_pages_done(hmm_range)) {
+
+		// Free backing memory of hmm_range if it was initialized
+		if (hmm_range &amp;&amp; amdgpu_hmm_range_get_pages_done(hmm_range)) {
 			pr_debug(&quot;hmm update the range, need validate again\n&quot;);
 			r = -EAGAIN;
 		}
</pre>
    </blockquote>
  </body>
</html>
