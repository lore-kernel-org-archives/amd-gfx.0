Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F54C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 22:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79E361041
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 22:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79E361041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D986ECEB;
	Thu,  6 May 2021 22:37:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99FA16ECEB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 May 2021 22:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G95bzCzlBXBCGDuJSM+tGMM0B7mdHYzpGxfzq43z+QZzJyxvLdRs0JHjnvc3fOQmyk3qG+hHODXd8CswL1i0m3M+M8DNuQ6GdrRz4i0gdbJC7VEbEGGQsfN9pLnHtAqUpoHTgjVLD0DfAMIMnHnTkXCauikQ2ryMR6V0juwzyqyrJP8v7fQsYH6GvQl33QRrlULhWkhbgS9O/BD2Y/7KN7wIeRQ3RisYfmQGz034xNNgN9SiGxuE/FQQWRnkUNTQVdZlRWpR1UJJMk0/WIt8d0DSz+FgWs1kYFOqSyTkdbzH+vzR4uDqnuz8T3a9IQcB8i3agKksPWffeWHMgRIM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tRQIGIYQyrdHG5dYuCgYfH7bB8SINYYJvGlKHRO6bQ=;
 b=aOxYVwoKEHcaYbly4AA8gfndY9ksK/gFexNic+kiYVikAHkYxPXfXzeEPTh/7UshIYWUFUptlpn3Sq11x+nGDWoXv0fCFCRNg5lm//eR5PuZ67EiTFUX41FfHCJZCMd1+lgMqnUjrEPblpM4gQvAL+hOvClI08RYHiABTiGAFadhampXyVF6wnCP2DFKrpZ8XYqT0AaCYeDk194C2AFKOE2kUzQ4aUoEdV9w+kySGqStC2GyJVzxjTPDGbjjKpLOn2EIiAfeNebnCdvb2879ZEodNTYVfi+d3AUBusqa3OCK2139RDvczkUPDBpc8uTzn5l4NL6fmjphWLHW1Rf/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tRQIGIYQyrdHG5dYuCgYfH7bB8SINYYJvGlKHRO6bQ=;
 b=Y4rklbOmxqAs5Y3dxK57f/QzprZaPYRUn2TSK5wfHU8q4raq7D88CQ4/Da29XeFO0fuGlnqzWpiWVbBjCYuPixwMAxoLZPH6lF2l/7FV9uGXeE0N5c+ggEGKp0LsLQHvcwtKH6ES0CWllziDgqWXG4HGNID49Z41M+DNlnIp2z0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 22:37:48 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.027; Thu, 6 May 2021
 22:37:48 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: 
Date: Thu,  6 May 2021 15:37:31 -0700
Message-Id: <20210506223733.28058-1-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR03CA0290.namprd03.prod.outlook.com (2603:10b6:a03:39e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Thu, 6 May 2021 22:37:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6c6e888-daca-42f7-a64b-08d910df92e0
X-MS-TrafficTypeDiagnostic: BYAPR12MB2840:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2840E97E1DE7524174940736F4589@BYAPR12MB2840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zCR858L6Of/CEZkn0bTM1Jth0UqtNeGxAJpIRVdjh3QRx8YlV80g/9EvPiikzX6IlYYhkpZ08exYMR57txN35f3pvyL3+1BVbDXQezPLjzqLJP4c1S9pUj6vm7L0KpMO9O4+spIVsGg9GVo0UFd9zC9CwzMdIdFAekGTWjy19wuSzmjsAl5QZMbFTuNXKyrG3b2O1nR+5OejVz59j7arINPBdzINPdl7oW5qHPOl3rJnNX5yM8GyHA3dRKolt1KyMwYKwber06/0aTi54risp+P/w9gvARCujGt9bfafMIx7kde+jjfXvdPpqPptl0GAYNmeAaVBEvanaRcv8ysZwcvYt1w53XJZ3fJVxCxDklcikYr6b2IsYY9Qirc27aei+2wNuApHVjWXCk3hzPWiw4Lx6Ti0T75silKe1FUK028Nlb/EfDHlNyONr8y3Wrhugn+Mfafpo0A74khwhnignjK183KPsmrwmr2fWbzUDmdSQwgdAq1ubQqHcsaT7IPISxGDDnHzAw8WlqVkm84BBrA8W4TVsIk8BoGdz1APA3E8SVwGX/oQY9hQMofnYO4Ej9G/UC4e2ZHivCfRHmen9YSNpQPHlOkUlgiBe0ndF0MHzM/PfFcEkGPWMF1u6PhOOtcuMX1dBDCJG7fNvGQf4OP+SteVYAeg32aIynZ2U0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(2906002)(5406001)(52116002)(7696005)(1076003)(956004)(6916009)(6486002)(5660300002)(478600001)(66476007)(26005)(86362001)(36756003)(316002)(8936002)(16526019)(186003)(66946007)(83380400001)(6666004)(66556008)(38350700002)(2616005)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jwQUg9b1R1F80gVmeFk2S0CCRZmNV3J5Y1aAEAxJG/bdJiuY/AYxD3+nrkMf?=
 =?us-ascii?Q?dtmLCrAetEvLmudPXJuVC2HtkLffOEON/bTL4WDfIX9wxE9qEP/lDgAwtirr?=
 =?us-ascii?Q?8QkMJfVwunSTa7v/OvbX9Vh9Ca2Kf7XMClQzmsjIOMiUHvDE71h6GPxo3sKZ?=
 =?us-ascii?Q?tdF+nQ4SxgfzcdsTX1autqsPssSy2jILlotIZn4FGPh0wxucAe/Lbkx2QkH5?=
 =?us-ascii?Q?G6EDVtO7+ENspamopETVzlKk0OOz+xEKqXO4+q5Ga28waMxhQ66PdddVImpv?=
 =?us-ascii?Q?OxG0n0d+Bi0BxhuzilIsc8s1N49uL9RcB5KC3ODHLKKIbZ1BTrHp96ed/irW?=
 =?us-ascii?Q?u0ofp6UW8RhZhTdUskI0B0CaWC+qknajHeBuxcfMHdds2pJTeSWgOzrgpHVz?=
 =?us-ascii?Q?XiroWCiOQSxfadR1i4IOJFvWzDGodRR1Uv4n9NT9wsvVxVzqshVVCWfWhCIA?=
 =?us-ascii?Q?fYi2jMJgTwQwbjJNnGUPjbasDBjSNkuA3myxtlDtQXNvQoCA0C+fyHZNrfrP?=
 =?us-ascii?Q?7azPCvb0dxfMmnCbT1KeNrWslZxKo08JPxB/NAB/begNiduAymgX5RwwEn3c?=
 =?us-ascii?Q?eBILs9ygXNxtPJhdKuJa/snd3/RbGwA9NKsf2HEzVkYdQvgvFeSE3EqlCFPY?=
 =?us-ascii?Q?j0JPQe9TDcQUf6CyHm2ao+ep79UIRTP1HHBJ0hgcYZNYPq2KGdpe2mOiFyoE?=
 =?us-ascii?Q?jMZZmxwNF+PgK6aDlwsxlM7N94L7UZooYRpclW5g+YUbKEdwMKtYTZ6TBtpq?=
 =?us-ascii?Q?7+jzlQChKlO4cg9d+EtwPaJ9T7P+ePfvmLCiM5DLznCAkPVWbSLeYE+j2sI+?=
 =?us-ascii?Q?W4ZiV4YVMLKNGJGPFNaTsE1Y182qMU4ShAmW2/lbuM+crgAXvjPfq2e31JQO?=
 =?us-ascii?Q?8eblC06S73Zq1WnhfipRXUcksnsq0q2ElgFTTo8FEzkHx1G7j32zPOGCEuKH?=
 =?us-ascii?Q?VP8ahzVqQBLr25KXO6iHb5p2ZtgGENzN6lpWstzuTs58mRp02k1lhZM8gv29?=
 =?us-ascii?Q?k+XpBAGh9x24S1KLkGdeapD04oGv8FeuzJRNGXdC/BtmEnNMXhLd/WPxeV1K?=
 =?us-ascii?Q?BWYIKqlfabr69ZdzN2qnzfuJdqqHWcgDdpQzahOGSYcmOhGCBzJrTlT9rBYQ?=
 =?us-ascii?Q?swfr2hPRnWDoQl4cdJEhU0HcpsyTHjmzz+/rKp/0fNKQihbD4P3JXoa8/BBA?=
 =?us-ascii?Q?s+fHd+RDMlYbH8zMtFfR9UYyOta/6QinJVnCHDDM3LKGD+fDRm56QDXjM6O5?=
 =?us-ascii?Q?NY98w1DtD9ekVpHNZSdmJHXw8v37Ahm/RuyMKUvcxaL23yPpYCzhTrnAkPt/?=
 =?us-ascii?Q?54p1USUo4JXCtzPHUjgsGUXl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c6e888-daca-42f7-a64b-08d910df92e0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 22:37:47.9052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoO9EBmsN8t8Lj4RUH81P7w/IMqU8R00ksXomLmgMHdUtefZJt8fXugbpSPpv6av
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2840
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During stress testing we found that with some Vulkan applications
the fence information displayed in the recently added fdinfo was not
properly calculated, two issues were discovered:

(1) A missing dma_put_fence on the loop that calculates the usage
ratios when the fence is being ignored.
(2) The approximation for the ratio calculation is not accurate
when accounting for non-active contexts. The fix is to ignore those
context if they have activity ratios lower than 0.01%

Attached is also a script demonstrating how the fdinfo can be used
to monitor gpu usage on running processes.

#!/usr/bin/env python3

#
# Copyright (C) 2021 Advanced Micro Devices. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of
# this software and associated documentation files (the "Software"), to
# deal in
# the Software without restriction, including without limitation the
# rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of
# the Software, and to permit persons to whom the Software is furnished
# to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
# IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

from tokenize import tokenize
import sys
import os
import pwd

total_mem = dict()
total_usage = dict()
def can_access(path):
    return os.access(path + "/fdinfo", os.X_OK)


def calc_perc(entry, metric):
    if not metric in entry:
        return 0.0
    if (type(entry[metric]) == list) :
        return sum(entry[metric])
    else :
        return entry[metric]

def process_pid(file):
    stat = dict()
    pasids = []

    for fd in os.scandir(file.path + "/fdinfo"):
        entry = {}
        with open(fd) as f:
            for line in f:
                entries = line.strip().split()
                if (entries[0] == "pdev:") :
                    entry["pdev"] = entries[1]
                elif (entries[0] == "pasid:") :
                    entry["pasid"] = entries[1]
                elif (entries[0] == "vram") :
                    entry["mem"] = int(entries[2])
                elif ("gfx" in entries[0]) :
                    if not "gfx" in entry :
                        entry["gfx"] = [0,0,0,0,0,0,0,0]
                    entry["gfx"][int(entries[0].lstrip("gfx").rstrip(":"))]
=
			float(entries[1].rstrip("%"))
                elif ("dma" in entries[0]) :
                    if not "dma" in entry :
                        entry["dma"] = [0,0,0,0,0,0,0,0]
                    entry["dma"][int(entries[0].lstrip("dma").rstrip(":"))]
=
			float(entries[1].rstrip("%"))
                elif ("dec" in entries[0]) :
                    if not "dec" in entry :
                        entry["dec"] = [0,0,0,0,0,0,0,0]
                    entry["dec"][int(entries[0].lstrip("dec").rstrip(":"))]
=
			float(entries[1].rstrip("%"))
                elif ("enc" in entries[0]) :
                    if not "enc" in entry :
                        entry["enc"] = [0,0,0,0,0,0,0,0]
                    entry["enc"][int(entries[0].lstrip("enc").rstrip(":"))]
=
			float(entries[1].rstrip("%"))
                elif ("compute" in entries[0]) :
                    if not "compute" in entry :
                        entry["compute"] = [0,0,0,0,0,0,0,0]
                    entry["compute"][int(entries[0].lstrip("compute").rstrip(":"))]
=
			float(entries[1].rstrip("%"))

            if not "pdev" in entry:
                continue
            if not "pasid" in entry :
                continue
            if (entry["pdev"], entry["pasid"]) in pasids:
              continue
            pasids.append((entry["pdev"], entry["pasid"]))

            pdev = entry["pdev"]

            if not pdev in stat:
                stat[pdev] = dict()

            if "mem" in entry :
                if "mem" in stat[pdev] :
                    stat[pdev]["mem"] = stat[pdev]["mem"] +
entry["mem"];
                else :
                    stat[pdev]["mem"] = entry["mem"]

            if "gfx" in entry :
                if "gfx" in stat[pdev] :
                    stat[pdev]["gfx"] = [a + b for a, b in
zip(stat[pdev]["gfx"],
			entry["gfx"])]
                else :
                    stat[pdev]["gfx"] = entry["gfx"]

            if "enc" in entry :
                if "enc" in stat[pdev] :
                    stat[pdev]["enc"] = [a + b for a, b in
zip(stat[pdev]["enc"],
			entry["enc"])]
                else :
                    stat[pdev]["enc"] = entry["enc"]

            if "dec" in entry :
                if "dec" in stat[pdev] :
                    stat[pdev]["dec"] = [a + b for a, b in
zip(stat[pdev]["dec"],
			entry["dec"])]
                else :
                    stat[pdev]["dec"] = entry["dec"]

            if "dma" in entry :
                if "dma" in stat[pdev] :
                    stat[pdev]["dma"] = [a + b for a, b in
zip(stat[pdev]["dma"],
			entry["dma"])]
                else :
                    stat[pdev]["dma"] = entry["dma"]

            if "compute" in entry :
                if "compute" in stat[pdev] :
                    stat[pdev]["compute"] = [a + b for a, b in
zip(stat[pdev]["compute"],
			entry["compute"])]
                else :
                    stat[pdev]["compute"] = entry["compute"]

    for gpu in stat:
        stat[gpu]["pid"] = file.name
        with open(file.path + "/comm") as f:
            stat[gpu]["name"] = f.readline().strip()

    if stat:
        for s in stat:
            if not s in total_mem:
                total_mem[s] = int(stat[s]["mem"])
            else:
                total_mem[s] = total_mem[s] + int(stat[s]["mem"])

            if not s in total_usage:
                total_usage[s] = dict()

            for key in stat[s]:
                if key == "mem":
                    continue
                if key == "name":
                    continue
                if key == "pid":
                    continue
                total = calc_perc(stat[s], key)

                if not key in total_usage[s]:
                    total_usage[s][key] = total
                else:
                    total_usage[s][key] = total + total_usage[s][key]

            # the /proc/PID is owned by process creator
            proc_stat_file = os.stat("/proc/%d" % int(stat[s]['pid']))
            # get UID via stat call
            uid = proc_stat_file.st_uid
            # look up the username from uid
            username = pwd.getpwuid(uid)[0]

            print("| {0:5s} | {1:16s} | {9:10s} | {2} | {3:7d} KiB |
{4:6.2f}  {5:6.2f}  {6:6.2f}  {7:6.2f}  {8:6.2f}  |"
                .format(stat[s]["pid"].ljust(5),
stat[s]["name"].ljust(16), s,
                stat[s]["mem"],
                calc_perc(stat[s], 'gfx'),
                calc_perc(stat[s], 'compute'),
                calc_perc(stat[s], 'dma'),
                calc_perc(stat[s], 'enc'),
                calc_perc(stat[s], 'dec'),
                username
                ))
            print("+-------+------------------+------------+--------------+-------------+-----------------------------------------+")

path = "/proc/"
print("+=======+==================+============+==============+=============+=========================================+")
print("| pid   | name             | user       | gpu bdf      | fb usage
| ring usage (%)                          |")
print("|       |                  |            |              |
| gfx     comp    dma     enc     dec     |")
print("+=======+==================+============+==============+=============+=========================================+")

for file in os.scandir(path):
    if (file.is_dir() and file.name.isnumeric()) :
        if (can_access(file.path)):
            process_pid(file)

for gpu in total_mem:
    print("|                                 TOTAL:| {0} | {1:7d} KiB |
{2:6.2f}  {3:6.2f}  {4:6.2f}  {5:6.2f}  {6:6.2f}  |".format(gpu,
total_mem[gpu],
        calc_perc(total_usage[gpu], 'gfx'),
        calc_perc(total_usage[gpu], 'compute'),
        calc_perc(total_usage[gpu], 'dma'),
        calc_perc(total_usage[gpu], 'enc'),
        calc_perc(total_usage[gpu], 'dec'),
        ))
print("+=======+==================+============+==============+=============+=====================+++=================+")




_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
