Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D55CAC5B0
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 17:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ABF210E19E;
	Thu,  2 Oct 2025 17:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ZQIEioU";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A1B610E19E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 17:02:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s037dZ33FcZQZMI6xnCmzQZzhZ0B4Ro4iCEQcjeU4M22mwhpRLS7HxttxJRd0evbeh/586IOlVh10B5H0IgP8c4ftvmyowRA/83NSxUaFFT4/xa1m1gfycWF/KOgmavue/vwziy6LLlrVwkHq5OTEmqPgTYJ+R6kZ0ZSxQMP6hUnm4AXrbRJe7/Y1ISNVGO5yO9aSHKqP7vFq6JQbvC7MFEKzrjSwX37C64zZzu4gR5/bPoNbrgmclUApt1VjjYoHE3MFGPqpGphgvxw6PbwE5GKvJyY421CCw9hfdu0ux+gaJNL6OnyRmDRwwKtmDsMuY+VqP9GLBmn7iJZ/E+w9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlyJUnuNYLp6bnmNjWwbK4/dMPe99ApJSgM7o4kI7JA=;
 b=jpeySXIES+1QuFA95gEPhN1BEuP4QXLL+1hfz8INt7/W5+AGzd7wMC4dv8vtSS6r6X4/5Zvgv6DzniO/uPFNiwLkAgeBD4J7IAbjmeLG7C6q94KenHIYs+uKLEreuD4Ujy2cSG6ZCwjNP/EG3O3mOAbAt2PK+k8VDx8muMyFZ7T8PqdJ3OjkPpnOKe1ZaGchZTj5Bnu2yaCbl32DwtuJngPmHD3amFqRzn7YSYClEDoj1lNxsLI7gf+eeLlb4IdDZD97cQ795KnWZ0u8utiFdFVuj/KH8ZdXYodXILl8Tg11AEaqk4H494qVe0mwokP6Suhy6lFRV1zueX5ZRT6L2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlyJUnuNYLp6bnmNjWwbK4/dMPe99ApJSgM7o4kI7JA=;
 b=4ZQIEioUF2UZ4NG5SDNuJrxAeqKME0CTnSd//FyDgZ2ZUfgqGjIWEfmUJc80M4QErg61wQQOJojPKMSV/I0yl6cwNLG485eZDYOrjQm3tHbdpJ6IVqGqmsNm43rRJHF93ZbPWrAWYJmLA4fcJu84V8H6PphbE+gMXOwRHrOTMWg=
Received: from DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) by
 BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Thu, 2 Oct 2025 17:02:26 +0000
Received: from DM3PR12MB9288.namprd12.prod.outlook.com
 ([fe80::506c:8361:ec1d:ab80]) by DM3PR12MB9288.namprd12.prod.outlook.com
 ([fe80::506c:8361:ec1d:ab80%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 17:02:26 +0000
From: "Liu, Robert" <Robert.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: kdf_ioctl_create_queue_args::write/read_pointer_address are still
 FROM KFD ?
Thread-Topic: kdf_ioctl_create_queue_args::write/read_pointer_address are
 still FROM KFD ?
Thread-Index: Adwzva31SDBImENXSaGfDotC/Q700Q==
Date: Thu, 2 Oct 2025 17:02:26 +0000
Message-ID: <DM3PR12MB9288D96636A81FEC59733A7C9FE7A@DM3PR12MB9288.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-02T16:56:24.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR12MB9288:EE_|BL3PR12MB6547:EE_
x-ms-office365-filtering-correlation-id: a8f53ac8-e9fb-4ebb-5fe9-08de01d576d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VJwgVApbbJ+RNJdCrtC7PoMzOJFpkCX51SG7fY1/34uVutGZBhZ+3ATe5fh+?=
 =?us-ascii?Q?1+HdTP/S7m9Uz+JospZE732fOhJ2Vx35qlWgTuM7HWekohoQJp3RmRq8YZYO?=
 =?us-ascii?Q?maGgVmepOytlHL/PNIdo5PfBYNR95MPymOT6bQKIuuf/8kiMmboRzY0gcTlT?=
 =?us-ascii?Q?7Qb45KgqfBGResAmRvf1DIgWiMUwO4MYnW62BCHZcCuwdClWlOBad2Da9bgL?=
 =?us-ascii?Q?RwAzDLGx/3T6kzH5uD8J+EqL7gv5unHKMeepIGZ+KwZqIh7rCiaEcBt42SXf?=
 =?us-ascii?Q?FXNeNCtdfY2crbuw0ns3q2Zb4zxoqKu1fbaRhyZZXmLBcezn0KlrXv46aRU3?=
 =?us-ascii?Q?stBI+2v+Bw4oqAKnlGJGk8VWlIxgpj6f8s0b+0JdCXMMXN8c8ulwVp9LaNMt?=
 =?us-ascii?Q?grm+hmkASgVv363ZKVGXzMJuFZiL0kjWd66q4yZ0cVtztrWx1R8CeNzu2nNF?=
 =?us-ascii?Q?C2NpO82FoS3FXjSdQSw6b7zzWNNCg/O14eLuLNuiV9vkqH2BrlRTLMcVeRNI?=
 =?us-ascii?Q?toGhJMvIVuyL7iImv4GjnvXdayC+ejwDEb4OQNTD59I3WXBiAcjnVqQlYFSX?=
 =?us-ascii?Q?VfW1S0TW2boytTcfmYnGwxZfEN0fZVJVLim3N2PGeyXu5VMcc+e781aAT1MC?=
 =?us-ascii?Q?yH5gq32+MpuCLmg/V1IhMs4pGqbXKhCCezMXE2AfMko15uUG8jtIb51WBTLS?=
 =?us-ascii?Q?hsDaiAEf+P3TrKNU37yVLGpHH/OGIrmZAoZU8tMiqVmCsgptEqbzC0L6xzwH?=
 =?us-ascii?Q?Q4dJ5G5BnlkzjjiUd0fKjNDFegcumE8nBhgTIgIsq5Ad3C5FoFrvhk/3QCv3?=
 =?us-ascii?Q?SYz8FogNSyiglJiDxRcsHtIz7XeGMD+UQz+nheI01M5owKmaEvrfR84U1zsH?=
 =?us-ascii?Q?g6QD5/4XtAPOpuJ5pLCGrUfX0uWR8E7EuG+ZKuHHCjtfsJ/Pdd7Cb83otLM1?=
 =?us-ascii?Q?N6zE+3iLrzOpxUenWULGhcrWLgvJgHMgMTTzkAP3AwMywAIyKEY/qGRtVQke?=
 =?us-ascii?Q?FItEPhRfSbX4+hs8QHt2u2rLgZwbCRKtyf5FTBRaAE6YQgLvU5QwNUpa2ggd?=
 =?us-ascii?Q?hi/nwmDTHL5078GyjarIsbzNW47sKtHHYIsmJEexA2Za1kdrKu7Q9tFht7rz?=
 =?us-ascii?Q?lcn5unbxaPOOm1XSgaCoKGne7WahVKb6SNyEyjIad7hW4uleVe8F0Xy3MvFi?=
 =?us-ascii?Q?fpZxyUkl24vgJzlYXA9RICzODPqfwDm8+uANOkwERylw8yfgtCof4twgTqoZ?=
 =?us-ascii?Q?ZPM8udSfFOz4xIvOH/POXYGUEZGzAeyTffgPXYEAC9DkE2Q0GDJtSlLIsu12?=
 =?us-ascii?Q?x3WYzpDNlkX14P/rOtYNXURHcg3hqtF72sB5AmfmZzlT0nT9I03D0EuibCKe?=
 =?us-ascii?Q?kRcg8xY9bH3VsF2n3LLeVH/wkwWIf87Nw3lqmv74O7jwRiF5i82ELQjkX9qv?=
 =?us-ascii?Q?72B4zQNZQN/bLSU5wen2CKjvCjbP23izCTtc3XFQxSxayNuBRMZ68qagW7D6?=
 =?us-ascii?Q?Lcg8d+Wr7mypd+9sGPBaPMEq4wzdmSypunZ6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9288.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XjVsR2KOT1kxXKpdss6+cUXy+JRYF8ZtICrSwsRb36TnZqNY2MjpwGT68vJJ?=
 =?us-ascii?Q?ooXVjZh5rCJ/NbJfvDqMTl53vTjPw4+l7LTsNoKqPyv0BL9Kg0YI7HperJcu?=
 =?us-ascii?Q?LU3pP0PfDzbE+c+GBqFz599N7bcrfYXOTmRzVzJXCjCa+YTQAFw2mmjCKbon?=
 =?us-ascii?Q?k01uJcHRSktwq7TJ6KQOGFmY5J1jiEqHd73j1B1QJFEBOj4Dze0iz5VnXQvi?=
 =?us-ascii?Q?jhrsEwSSxLthAnSUw8sWheKi3vI4voe4vUcFdFw4o6ULFUtynIIa4g2dtiNA?=
 =?us-ascii?Q?2YL+2AF1PHCzRQe+ENsQ8py2uF+52nADsGA0EIk0HY9yfkYGqUhGzKIiTNvV?=
 =?us-ascii?Q?h5qt6m6SEj3QE+s25FVqHoeGOckeJ3fN8lM4MwoHq5v5kt6dSyTi/0H/TXi2?=
 =?us-ascii?Q?jw3QtvCAb+tx//hmeXzPQXVC7HjY3/8Rw9SJNN0MxaNvh+pwLPURuHZ+//MC?=
 =?us-ascii?Q?PFO7HG2qAZuNzU23uzxIT0CcAszgIAfJtkaCId388YmX1m02+V1eT2by6k2f?=
 =?us-ascii?Q?9vFd2/KheD2yQR+bTN88DP8eYQp2AzvII2Et3FIuQV9clvR94NnHVzSvZXfy?=
 =?us-ascii?Q?7In/LOWeIOfGKKOkzKLNgroiNyzXoSpTAQyEacbNZ/H7R4HRSQmdCPKeHg60?=
 =?us-ascii?Q?oDYNzyBXkLmYPqCVp4v5Wy89T6h3A2tQ1WkbhH2NGvvDiDS+8Ug/NVx3pEnU?=
 =?us-ascii?Q?ppKrqSJh7+Pukn2cCKn0n9H/rRjpRuNcFDDrvyTeMO4wd5u3ZLcbueRMD89H?=
 =?us-ascii?Q?+U3C5QN2LLgW/vXu35dblWfXEbTY2gLU34QjRfQtoWbck/5hkkKbDOdyi151?=
 =?us-ascii?Q?zhC9stcJ2nui+QNc4R0XBIEkqPpTJcbpciQaw7FaUk0jnep0upz7bToysVqS?=
 =?us-ascii?Q?F0V58zLQ+oqDuPbVygc8ZFNf0MhzapMkfdvgr6DWHjT/tm/IHdu/8Ovn+YdC?=
 =?us-ascii?Q?1GZTfOFtBrmmsWwWqQmb9RQYPbMZIgtLKokwuiZ9BkywWpQpSubeWPs6UTNx?=
 =?us-ascii?Q?1OHC18N6TYmFMGB4NtkRHF8OaSTX89+zd+baXrpt/rVtCH/ubmC2d2wg0oPm?=
 =?us-ascii?Q?c2LUWkGz0sMxhuUZKsK+rumz/GXG4Hpho3EE6hemnM59ZOzxVbvnWUgoqVSS?=
 =?us-ascii?Q?VXKSFBpfUaR0/CVOJserb+yglbzCoVi9VdHH3j0z3V0Ui/7nfERr/69ZkxUe?=
 =?us-ascii?Q?e786kVc/j93N2zOjVNNAPVlNs+bBtx9OsXP5VdbXYjr67en17wDLRUBNKDXb?=
 =?us-ascii?Q?SHydhpEV1vRxt+dscrThqppTRa43W+2AfIggKV3PwVhjscvaVxUi4jgRhmTo?=
 =?us-ascii?Q?5wA3vEP+prti4Wyj78+F4FfByeC6cFUnX/EFtw5hFiv5yS8LobL/yZltvYlq?=
 =?us-ascii?Q?XiCxA1S/k8OrXHbf/fGhN5C2tnBuMhG/JJPXOAGHvu+7bG6D4tsZ5GiPrpVw?=
 =?us-ascii?Q?FD/VRNEW96sdt2BM/tfJ6OkdrfYcZqCj3yNpAH4Z8eoYFLdnqqoT50tLhPFw?=
 =?us-ascii?Q?xLTXuvP5okRRI6Vnk56OcJ1y28kJDjyxd1qCukZufbV1JfaxM4tLnJdj3Au3?=
 =?us-ascii?Q?sArmE2/oluYTPoLt9FQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM3PR12MB9288D96636A81FEC59733A7C9FE7ADM3PR12MB9288namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f53ac8-e9fb-4ebb-5fe9-08de01d576d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 17:02:26.6460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYNFZRCqyxiuNpxMvtCPt+tbK/L6O5A4BjPYCi3sArn4HZVsg35B9IhB0j/A9AAe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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

--_000_DM3PR12MB9288D96636A81FEC59733A7C9FE7ADM3PR12MB9288namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

This below struct is shared by kdf and libhsakmt. In the latest codeline, i=
t's seems they are going TO KFD now, together with ring_base and size.  If =
this is true, it'd be nice to make the comments aligned with the code.

struct kfd_ioctl_create_queue_args {
     __u64 ring_base_address;   /* to KFD */
     __u64 write_pointer_address;     /* from KFD */
     __u64 read_pointer_address; /* from KFD */
     __u64 doorbell_offset;     /* from KFD */

     __u32 ring_size;      /* to KFD */
     __u32 gpu_id;         /* to KFD */
     __u32 queue_type;          /* to KFD */
     __u32 queue_percentage;    /* to KFD */
     __u32 queue_priority; /* to KFD */
     __u32 queue_id;       /* from KFD */

     __u64 eop_buffer_address;  /* to KFD */
     __u64 eop_buffer_size;     /* to KFD */
     __u64 ctx_save_restore_address; /* to KFD */
     __u32 ctx_save_restore_size;     /* to KFD */
     __u32 ctl_stack_size;      /* to KFD */
     __u32 sdma_engine_id;      /* to KFD */
     __u32 pad;
};

Thanks,
Robert

--_000_DM3PR12MB9288D96636A81FEC59733A7C9FE7ADM3PR12MB9288namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">This below struct is shared by kdf and libhsakmt. In=
 the latest codeline, it&#8217;s seems they are going TO KFD now, together =
with ring_base and size.&nbsp; If this is true, it&#8217;d be nice to make =
the comments aligned with the code.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">struct kfd_ioct=
l_create_queue_args {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u64 ring_base_address;&nbsp;&nbsp; /* to KFD */<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><b><span style=3D"font-family:Consolas;color:red">&n=
bsp;&nbsp;&nbsp;&nbsp; __u64 write_pointer_address;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* from KFD */<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-family:Consolas;color:red">&n=
bsp;&nbsp;&nbsp;&nbsp; __u64 read_pointer_address; /* from KFD */<o:p></o:p=
></span></b></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u64 doorbell_offset;&nbsp;&nbsp;&nbsp;&nbsp; /* from KFD */<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u32 ring_size;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u32 gpu_id;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
to KFD */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u32 queue_type;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* to KFD */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u32 queue_percentage;&nbsp;&nbsp;&nbsp; /* to KFD */<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u32 queue_priority; /* to KFD */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u32 queue_id;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* from KFD *=
/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u64 eop_buffer_address;&nbsp; /* to KFD */<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u64 eop_buffer_size;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u64 ctx_save_restore_address; /* to KFD */<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u32 ctx_save_restore_size;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u32 ctl_stack_size;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u32 sdma_engine_id;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp; __u32 pad;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">};<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Robert<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_DM3PR12MB9288D96636A81FEC59733A7C9FE7ADM3PR12MB9288namp_--
